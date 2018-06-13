From: james.morse@arm.com (James Morse)
Date: Wed, 13 Jun 2018 11:29:17 +0100
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
 <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
Message-ID: <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

On 13/06/18 06:16, Bhupesh Sharma wrote:
> On Tue, Jun 12, 2018 at 3:42 PM, James Morse <james.morse@arm.com> wrote:
>> On 12/06/18 09:25, Bhupesh Sharma wrote:
>>> On Tue, Jun 12, 2018 at 12:23 PM, Ard Biesheuvel wrote:
>>>> Userland code that assumes that the linear map cannot have a hole at
>>>> the beginning should be fixed.

>>> That is a separate case (although that needs fixing as well via a
>>> kernel patch probably as the user-space tools rely on '/proc/iomem'
>>> contents to determine the first System RAM/reserved range).
>>
>> This is for kexec-tools generating the kdump vmcore ELF headers in user-space?
> 
> Yes, but again, I would like to reiterate that the case where I see a
> hole at the start of the System RAM range (as I listed above) is just
> a specific case, which probably deserves a separate patch. The current
> patch though is for a generic issue (please see more details below).


>>> # readelf -l vmcore
>>>
>>> ELF Header:
>>> ........................
>>>
>>> Program Headers:
>>>   Type           Offset             VirtAddr           PhysAddr
>>>          FileSiz            MemSiz              Flags  Align
>>> ..............................................................................................................................................................
>>>   LOAD        0x0000000076d40000 0xffff80017fe00000 0x0000000180000000
>>>                 0x0000001680000000 0x0000001680000000  RWE    0
>>>
>>> 3. So if we do a simple calculation:
>>>
>>> (VirtAddr + MemSiz) = 0xffff80017fe00000 + 0x0000001680000000 =
>>> 0xFFFF8017FFE00000 != 0xffff801800000000.
>>>
>>> which indicates that the end virtual memory nodes are not the same
>>> between vmlinux and vmcore.
>>
>> If I've followed this properly: the problem is that to generate the ELF headers
>> in the post-kdump vmcore, at kdump-load-time kexec-tools has to guess the
>> virtual addresses of the 'System RAM' regions it can see in /proc/iomem.
>>
>> The problem you are hitting is an invisible hole at the beginning of RAM,
>> meaning user-space's guess_phys_to_virt() is off by the size of this hole.
>>
>> Isn't KASLR a special case for this? You must have to correct for that after
>> kdump has happened, based on an elf-note in the vmcore. Can't we always do this?
> 
> No, I hit this issue both for the KASLR and non-KASLR boot cases.

Because in both cases there is a hole at the beginning of the linear-map. KASLR
is a special-case of this as the kernel adds a variable sized hole to do the
randomization.

Surely treating this as one case makes your user-space code simpler.


> Fixing this in kernel space seems better to me as the definition of

Is there a kernel bug? Changing the definitions of internal kernel variables for
the benefit of code digging in /proc/kcore|/dev/mem isn't going to fly.


> 'memstart_addr' is that it indicates the start of the physical ram,
> but since in this case there is a hole at the start of the system ram
> visible in Linux (and thus to user-space), but 'memstart_addr' is
> still 0 which seems contradictory at the least. This causes PHY_OFFSET
> to be 0 as well, which is again contradictory.


>>> This happens because the kexec-tools rely on 'proc/iomem' contents
>>> while 'memstart_addr' is computed as 0 by kernel (as value of
>>> memblock_start_of_DRAM() < ARM64_MEMSTART_ALIGN).
>>
>>> Returning back to this patch, this is a generic requirement where we
>>> need the linear region start/base addresses in user-space applications
>>> which is used to read addresses which lie in the linear region (for
>>> e.g. when we read /proc/kcore contents).

[...]

>> This patch adds a variable that nothing uses, its going to be removed. You can't
>> depend on reading this via /dev/mem.
>>
>> Could you add the information you need as an elf-note to the vmcore instead? You
>> must already pick these up to handle kaslr. (from memory, this is where the
>> kaslr-offset is described to user-space after we kdump).


> No you are mixing up the two cases (please see above), the issue which
> this patch fixes is for use cases where we don't have the vmcore
> available in case of 'live' debugging via makedumpfile and crash tools
> (we only have '/proc/kcore' or 'vmlinux' available in such cases). I
> detailed the use case in [1] better (in a reply to Ard), I will detail
> the use-case again below:

Okay, so not kdump...


> One specific use case that I am working on at the moment is the
> makedumpfile '--mem-usage', which allows one to see the page numbers
> of current system (1st kernel) in different use (please see
> MAKEDUMPFILE(8) for more details).

https://linux.die.net/man/8/makedumpfile :
| Name: makedumpfile - make a small dumpfile of kdump

... but now we are talking about kdump again ...


> Using this we can know how many pages are dumpable when different
> dump_level is specified when invoking the makedumpfile.
> 
> Normally, makedumpfile analyses the contents of '/proc/kcore' (while
> excluding the crashkernel range), and then calculates the page number
> of different kind per vmcoreinfo.

$ apt-get source makedumpfile
$ cd makedumpfile-1.5.3
$ grep -r "kcore" .
$

I suspect there are two pieces of software with the same name here.


> This use case requires directly reading the '/proc/kcore' and the
> hence the PAGE_OFFSET value is used to determine the base address of
> the linear region, whose value is not static in case of KASLR boot.

Eh? I thought PAGE_OFFSET was a compile-time constant, and it was PHYS_OFFSET
has a value other the aligned base of memory for KASLR.


> Another use-case is where the crash-utility uses the PAGE_OFFSET value
> to perform a virtual-to-physical conversion for the address lying in
> the linear region:

In all cases the problem you have is assuming the first 'System RAM' value in
/proc/iomem is the base of DRAM, which you can use a PHYS_OFFSET in your
user-space phys2virt() calculation.

What information do you need to make this work?

You can evidently read kernel variables, why can't you read memstart_addr and do:
| #define __phys_to_virt(x)				\
|			((unsigned long)((x) - memstart_addr) | PAGE_OFFSET)

based on the physical addresses in /proc/iomem, and PAGE_OFFSET pulled out of
the vmlinux.

Reading memstart_addr is fragile, we might need to rename it
wednesday_memstart_addr. If user-space needs this value to work with
/proc/{kcore,vmcore} we should expose something like 'p2v_offset' as an elf-note
on those files. (looks like they both have elf-headers).


Thanks,

James

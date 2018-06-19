From: james.morse@arm.com (James Morse)
Date: Tue, 19 Jun 2018 11:16:06 +0100
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
References: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
 <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619085541.GB13984@arm.com>
 <6860c284f1c74faa95edd6cf866ec80d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619094045.GD13984@arm.com>
 <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
Message-ID: <09260c7e-8b9d-bc3c-5bca-0fd75417f552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yanjiang, Will,

On 19/06/18 10:57, Jin, Yanjiang wrote:
>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon at arm.com]
>> Sent: 2018?6?19? 17:41
>> To: Jin, Yanjiang <yanjiang.jin@hxt-semitech.com>
>> Cc: James Morse <james.morse@arm.com>; Bhupesh Sharma
>> <bhsharma@redhat.com>; Mark Rutland <mark.rutland@arm.com>; Ard
>> Biesheuvel <ard.biesheuvel@linaro.org>; Catalin Marinas
>> <catalin.marinas@arm.com>; Kexec Mailing List <kexec@lists.infradead.org>;
>> AKASHI Takahiro <takahiro.akashi@linaro.org>; Bhupesh SHARMA
>> <bhupesh.linux@gmail.com>; linux-arm-kernel <linux-arm-
>> kernel at lists.infradead.org>
>> Subject: Re: [PATCH] arm64/mm: Introduce a variable to hold base address of
>> linear region
>>
>> On Tue, Jun 19, 2018 at 09:34:56AM +0000, Jin, Yanjiang wrote:
>>>> On Tue, Jun 19, 2018 at 03:02:15AM +0000, Jin, Yanjiang wrote:
>>>>>> You seem to be using this for user-space phys_to_virt() based on
>>>>>> values found in /proc/iomem. This should give you what you want,
>>>>>> and isolate your user-space from the kernel's unexpected naming of
>> variables.
>>>>>
>>>>> I don't know could I simplify this problem?
>>>>> Let's ignore what memstart_addr represents here, we just want to
>>>>> implement
>>>>> phys_to_virt() in an userspace applications(kexec-tools or others).
>>>>>
>>>>> ARM64 Kernel has a below definition:
>>>>>
>>>>> #define __phys_to_virt(x)       ((unsigned long)((x) - PHYS_OFFSET) |
>>>> PAGE_OFFSET)
>>>>>
>>>>> So userspace app must know PHYS_OFFSET(equal to memstart_addr now).
>>>>> Seems this is very simple, but memstart_addr has gone through
>>>>> several operations in arm64_memblock_init() depends on different
>>>>> Kernel configurations, so userspace app needs to know many
>>>>> additional definitions as
>>>> following:
>>>>>
>>>>> memblock_start_of_DRAM(),  (ifdef CONFIG_SPARSEMEM_VMEMMAP),
>>>>> ARM64_MEMSTART_SHIFT,  SECTION_SIZE_BITS,  PAGE_OFFSET,
>>>>> memblock_end_of_DRAM(), IS_ENABLED(CONFIG_RANDOMIZE_BASE),
>>>>> memstart_offset_seed.
>>>>>
>>>>> It is hard to know all above in kexec-tools now. Originally I
>>>>> planned to read memstart_addr's value from "/dev/mem", but someone
>>>>> thought not all Kernels enable "/dev/mem", we'd better find a more
>>>>> generic approach. So we want to get some suggestions from ARM kernel
>> community.
>>>>> Can we export this variable in Kernel side through sysconf() or
>>>>> other similar methods? Or someone can provide an effect way to get
>>>>> memstart_addr's value?
>>>>
>>>> I thought the suggestion from James was to expose this via an ELF
>>>> NOTE in kcore and vmcore (or in the header directly if that's possible, but I'm
>> not sure about it)?
>>>
>>> Thanks for your reply firstly. But same as DEVMEM, kcore is not a
>>> must-have, so we can't depend on it.
>>
>> Neither is KEXEC. We can select PROC_KCORE from KEXEC if it helps.
>>
>>> On the other hand, phys_to_virt() is called during generating vmcore
>>> in Kexec-tools, vmcore also can't help this issue.
>>
>> I don't understand this part. If you have the vmcore in your hand, why can't you
>> grok the pv offset from the note and use that in phys_to_virt()?
> 
> It is a chicken-and-egg issue.
> phys_to virt() is for crashdump setup. To generate vmcore, we must call
> phys_to_virt(). At this point, no vmcore exists.

Its needed for the parts of the ELF header that kexec-tools generates at kdump
load time?

So adding this pv_offset to the key=value data crash_save_vmcoreinfo_init()
saves isn't available early enough?


If we select PROC_KCORE for KEXEC so you know you will have /proc/kcore if the
system supports kdump. We should probably provide the same information in the
PT_NOTE section of the /proc/kcore file.


(I thought the kdump kernel exported that crash_save_vmcoreinfo_init() data as
an elf-note itself, but digging deeper I see the kernel exposes the physical
address in /sys/kernel/vmcoreinfo. Presumably its passed back via the kdump
elfcorehdr.)


>>> Unfortunately, not all platforms support analyzing Kernel config in
>>> userspace application, so Kexec-tools can't know some key kernel options.
>>> If not so, we can simulate the whole arm64_memblock_init()  progress
>>> in kexec-tools.
>>
>> I don't understand what the kernel config has to do with kexec tools.
> 
> I mean that if we can know kernel .config in all circumstances, we can calculate memstart_addr  as below in Kexec-tools:
> 
> 
>         memstart_addr = round_down(memblock_start_of_DRAM(),
>                                    ARM64_MEMSTART_ALIGN);

This wouldn't work for KASLR. Having the kernel provide you with the offset
means you are insulated from the details of phys_to_virt() and what affects
these values. It should be possible to do this in the same way for all
architectures.


Thanks,

James

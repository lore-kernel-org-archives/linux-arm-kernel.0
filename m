From: mjaggi@caviumnetworks.com (Manish Jaggi)
Date: Tue, 4 Oct 2016 15:35:43 +0530
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <57F37A73.3030105@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <8a57223d-000d-536e-6885-d427ee81508c@caviumnetworks.com>
 <20161003110424.GD14025@linaro.org>
 <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
 <57F37A73.3030105@arm.com>
Message-ID: <691230c7-051d-afee-9014-d22963a8f045@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/04/2016 03:16 PM, James Morse wrote:
> Hi Manish,
> 
> On 03/10/16 13:41, Manish Jaggi wrote:
>> On 10/03/2016 04:34 PM, AKASHI Takahiro wrote:
>>> On Mon, Oct 03, 2016 at 01:24:34PM +0530, Manish Jaggi wrote:
>>>> With the v26 kdump and v3 kexec-tools and top of tree crash.git, below are the tests done
>>>> Attached is a patch in crash.git (symbols.c) to make crash utility work on my setup.
>>>> Can you please have a look and provide your comments.
>>>>
>>>> To generate a panic, i have a kernel module which on init calls panic.
> 
> ... modules ... I haven't tested that. I bet it causes some problems!
> We probably need to include module_alloc_base as an elf note in the vmcore file...
> 
> 
>>>> First kernel is booted with mem=2G crashkernel=1G command line option.
>>>> While the system has 64G memory.
> 
>>> Are you saying that "mem=..." doesn't have any effect?
>> What I am saying it that If the first kernel is booted using mem= option and crashkernel= option
>> the memory for second kernel has to be withing the crashkernel size.
>> As per /proc/iomem System RAM the information is correct, but the /proc/meminfo is showing total memory
>> much more than the first kernel had in first place.
> 
> So your second crashkernel has 63G of memory? Unless you provide the same 'mem='
> to the kdump kernel, this is the expected behaviour. The
> DT:/reserved-memory/crash_dump describes the memory not to use.
> 
> On your first boot with 'mem=2G' memblock_mem_limit_remove_map() called from
> arm64_memblock_init() removed the top 62G of memory. Neither the first kernel
> nor kexec-tools know about the top 62G.
> When you run kexec-tools, it describes what it sees in /proc/iomem in the
> DT:/reserved-memory/crash_dump, which is just the remaining 1G of memory.
> 
> When we crash and reboot, the crash kernel discovers all 64G of memory from the
> EFI memory map.
So the iomem and meminfo should be same or different for the second kernel?
Also i assumed that crashkernel=1G should restrict the second kernels to 1G.
This is my understanding from the description. It should not require a second mem= option
> kexec-tools described the 1G of memory that the first kernel was using in the
> DT:/reserved-memory/crash_dump node, so early_init_fdt_scan_reserved_mem()
> reserves the 1G of memory the first kernel used. This leaves us with 63G of memory.
> 
> This may change with the next version of kdump if it switches back to using
> DT:/chosen/linux,usable-memory-range.
> If you need v26 to avoid the top 62G of memory, you need to provide the same
> 'mem=' to the first and second kernel.
If I provide for second kernel, I dont see any prints after Bye.
Have you tired this anytime?
> 
> 
>>>> 1.2 Live crash dump fails with error
> 
> ... do we expect this to work? I don't think it has anything to do with this
> series...
> 
Why it should not?
I saved the vmcore file while in second kernel. Since crash without vmcore file didnt run,
Tried with vmcore file and it worked. Its just that if you want to boot a second kernel
 with read only file system without network live crash dump analysis is handy.
> 
> Thanks,
> 
> James
> 

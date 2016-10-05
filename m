From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 5 Oct 2016 14:41:12 +0900
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <57F37A73.3030105@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <8a57223d-000d-536e-6885-d427ee81508c@caviumnetworks.com>
 <20161003110424.GD14025@linaro.org>
 <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
 <57F37A73.3030105@arm.com>
Message-ID: <20161005054111.GA19531@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 10:46:27AM +0100, James Morse wrote:
> Hi Manish,
> 
> On 03/10/16 13:41, Manish Jaggi wrote:
> > On 10/03/2016 04:34 PM, AKASHI Takahiro wrote:
> >> On Mon, Oct 03, 2016 at 01:24:34PM +0530, Manish Jaggi wrote:
> >>> With the v26 kdump and v3 kexec-tools and top of tree crash.git, below are the tests done
> >>> Attached is a patch in crash.git (symbols.c) to make crash utility work on my setup.
> >>> Can you please have a look and provide your comments.
> >>>
> >>> To generate a panic, i have a kernel module which on init calls panic.
> 
> ... modules ... I haven't tested that. I bet it causes some problems!
> We probably need to include module_alloc_base as an elf note in the vmcore file...

No, I don't think so :)
I created some test module as Manish implied and tested kdump:
(My kernel here even enables KASLR.)
===8<===
$ crash vmlinux vmcore
...
please wait... (gathering module symbol data)
...
crash> mod -S
     MODULE       NAME      SIZE  OBJECT FILE
ffff04d78f4b8000  testmod  16384  /opt/buildroot/15.11_64/root/kexec/testmod.ko 
crash> bt
PID: 1102   TASK: ffffb4da8e910000  CPU: 0   COMMAND: "insmod"
 #0 [ffffb4da8e9afa30] __crash_kexec at ffff0e0045020a54
 #1 [ffffb4da8e9afb90] panic at ffff0e004505523c
 #2 [ffffb4da8e9afc50] testmod_init at ffff04d78f4b6014 [testmod]
 #3 [ffffb4da8e9afb40] do_one_initcall at ffff0e0044f7333c
--- <Exception in user> ---
     PC: 0000000a  LR: 00000000  SP: ffff04d78f4b6000  PSTATE: 7669726420656c75
    X12: ffffb4da8e9ac000 X11: ffff04d78f4b6018 X10: ffffb4da8e9afc50  X9: 20676e6973756143
     X8: 00000000  X7: ffff0e0045e5ce00  X6: ffff0e0045e5c000  X5: 600001c5
     X4: ffff0e0045020a58  X3: ffffb4da8e9afa30  X2: ffff0e004502098c  X1: ffffb4da8e9afa30
     X0: 00000124
crash> disas testmod_init
Dump of assembler code for function testmod_init:
   0xffff04d78f4b6000 <+0>:     stp     x29, x30, [sp,#-16]!
   0xffff04d78f4b6004 <+4>:     mov     x29, sp
   0xffff04d78f4b6008 <+8>:     ldr     x0, 0xffff04d78f4b6018
   0xffff04d78f4b600c <+12>:    bl      0xffff04d78f4b6090
   0xffff04d78f4b6010 <+16>:    ldr     x0, 0xffff04d78f4b6020
   0xffff04d78f4b6014 <+20>:    bl      0xffff04d78f4b6080
End of assembler dump.
===>8===
(I see some issue in disassembled code, though.)

> 
> 
> >>> First kernel is booted with mem=2G crashkernel=1G command line option.
> >>> While the system has 64G memory.
> 
> >> Are you saying that "mem=..." doesn't have any effect?
> > What I am saying it that If the first kernel is booted using mem= option and crashkernel= option
> > the memory for second kernel has to be withing the crashkernel size.
> > As per /proc/iomem System RAM the information is correct, but the /proc/meminfo is showing total memory
> > much more than the first kernel had in first place.
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
> kexec-tools described the 1G of memory that the first kernel was using in the
> DT:/reserved-memory/crash_dump node, so early_init_fdt_scan_reserved_mem()
> reserves the 1G of memory the first kernel used. This leaves us with 63G of memory.

Thank you very much for elaborating this on behalf of myself!

> This may change with the next version of kdump if it switches back to using
> DT:/chosen/linux,usable-memory-range.

Indeed.
We need to talk to Rob.

Thanks,
-Takahiro AKASHI

> If you need v26 to avoid the top 62G of memory, you need to provide the same
> 'mem=' to the first and second kernel.
>
> 
> >>> 1.2 Live crash dump fails with error
> 
> ... do we expect this to work? I don't think it has anything to do with this
> series...
> 
> 
> Thanks,
> 
> James
> 

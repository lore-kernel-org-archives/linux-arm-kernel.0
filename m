From: grundler@google.com (Grant Grundler)
Date: Thu, 4 May 2017 09:49:37 -0700
Subject: ARMv7 doesn't define CR_U?
In-Reply-To: <CANEJEGv2snHD8vcAu2Hyu1839VdkCwUsRKOa28AsuHnvyZWwBw@mail.gmail.com>
References: <CANEJEGv2snHD8vcAu2Hyu1839VdkCwUsRKOa28AsuHnvyZWwBw@mail.gmail.com>
Message-ID: <CANEJEGtLrtpQbCMxDY1gfrhzjR5CDZT+r6cSJu=G2RvbNStEvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[sorry - please drop linux-arm at vger on replies; not sure where I got that from]

On Thu, May 4, 2017 at 9:35 AM, Grant Grundler <grundler@google.com> wrote:
> Hi!
>
> I'm seeing unaligned accesses from sadc[1] (compiled with llvm) are
> getting SIGBUS on an QCA IPQ4019 chipset despite ARMv7 CPU claiming to
> support unaligned accesses[1].   My question is about use of CR_U on
> ARMv7 in cpu_is_v6_unaligned().
>
>
> localhost crash # strace sadc -F -L 600 -
> execve("/usr/local/bin/sadc", ["sadc", "-F", "-L", "600", "-"], [/* 20
> vars */]) = 0
> brk(NULL)                               = 0x3953c000
> ...
> access("/sys/block/mmcblk0/device", F_OK) = 0
> --- SIGBUS {si_signo=SIGBUS, si_code=BUS_ADRALN, si_addr=0x3953d8f8} ---
> +++ killed by SIGBUS (core dumped) +++
> Bus error (core dumped)
>
> And kernel output from a different invocation:
> [  226.596867] Alignment trap: not handling instruction f9602aef at [<2a0062b6>]
> [  226.596925] Unhandled fault: alignment exception (0x001) at 0x2a014088
>
> Backtrace from gdb:
> 0x2a0062ba in read_diskstats_io (st_io=0x2a014088) at rd_stats.c:568
> 568     rd_stats.c: No such file or directory.
> (gdb) bt
> #0  0x2a0062ba in read_diskstats_io (st_io=0x2a014088) at rd_stats.c:568
> #1  0x2a00299c in read_stats () at sadc.c:883
> #2  rw_sa_stat_loop (count=-1, rectime=0xbefff424, stdfd=<optimized out>,
>     ofd=<optimized out>, ofile=<optimized out>) at sadc.c:947
> #3  0x2a002d66 in main (argc=5, argv=<optimized out>) at sadc.c:1206
>
> But it looks like our kernel[2] should be handling this unaligned access:
> # cat /proc/cpu/alignment
> User:           16
> System:         0
> Skipped:        16
> Half:           0
> Word:           0
> DWord:          0
> Multi:          0
> User faults:    2 (fixup)
>
> Since Documentation/arm/mem_alignment doesn't seem to match the
> code[2], I'm not sure what to expect here.
> "echo 0 > /proc/cpu/alignment" results in kernel printing:
>     alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.
>
>
> arch/arm/mm/alignment.c:
> /* Return true if and only if the ARMv6 unaligned access model is in use. */
> static bool cpu_is_v6_unaligned(void)
> {
>         return cpu_architecture() >= CPU_ARCH_ARMv6 && get_cr() & CR_U;
> }
>
> arch/arm/include/asm/cp15.h:
> #define CR_U    (1 << 22)       /* Unaligned access operation           */
>
> But bit 22 isn't defined in the Cortex A7 (an ARMv7-A cpu).
>
> "Cortex-A7 MPCore Technical Reference Manual"
> "4.3.27. System Control Register"
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0464f/BABJAHDA.html
>
> says bit 22 is "Reserved, RAO/SBOP."
>
>
> So shouldn't cpu_is_v6_unaligned() be something like:
>
> static bool cpu_supports_unaligned(void)
> {
>         return (cpu_architecture() == CPU_ARCH_ARMv6 && get_cr() & CR_U)
>              || (cpu_architecture() >= CPU_ARCH_ARMv7);
> }
>
> thanks in advance for any guidance on this!
>
> cheers,
> grant
>
> [1] "Migrating from IA-32 to ARM Application Note 274" says there is
> an exception to "unaligned data access" and it possible this is
> related to current sadc behavior:
>
> "3.4.5       Access types, endianness and alignment
> ...
> 2.     Data alignment
> All ARM processors access data in memory more efficiently if it is
> aligned according to size (words on word boundaries, halfwords on
> halfword boundaries etc.). All ARMv7-A processors, however, are
> capable of accessing unaligned data, albeit with a slight performance
> penalty (this is due to the need for the memory interface to make
> multiple accesses and is hidden, functionally, from the programmer).
> Notable exceptions are stack accesses which are all word-sized and
> must be word-aligned. Some memory access instructions (e.g. LDM/STM
> and LDREX/STREX) do not support unaligned addresses."
>
> [2] chromium.org chromeos-3.18 branch:
>     https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.18/arch/arm/mm/alignment.c

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jul 2013 17:45:53 +0200
Subject: Analysis of Cortex-A9 r4 erratas
Message-ID: <20130709174553.426dfaa1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will, Catalin, Russell,

As Marvell is starting to run Linux on their latest Cortex-A9 based
SoC
(http://www.marvell.com/company/news/pressDetail.do?releaseID=4038), we
are having a look at the list of erratas affecting the Cortex-A9 r4
core, and see which ones have been fixed in the kernel, which ones
don't need to be fixed, and which ones should maybe have a fix, but
don't have one at this point.

I've listed below all the erratas affecting the Cortex-A9 r4, as of
"ARM UAN 0009B", together with a short analysis from me (which may very
well be wrong). After doing this analysis, I'm mostly concerned by the
following erratas, about which I'd appreciate to have your opinion:

 * 761319 Possible inconsistent sequencing of read accesses to the same
   memory location

 * 794072 A short loop including a DMB instruction might cause a denial
   of service on another processor which executes a CP15 broadcast
   operation

 * 794074 A write request to Uncacheable, Shareable normal memory
   region might be executed twice, possibly causing a software
   synchronisation issue

 * 754323 Repeated Store in the same cache line might delay the
   visibility of the Store.

All the other erratas seem to be either fixed, or not have any
consequence on the normal operation of the kernel, but I'm also
interested in your opinion about this.

Thanks!

Thomas

Complete list of erratas, with my (stupid?) comments

Category A

761319 Title:  Possible inconsistent sequencing of read accesses to the
               same memory location
       Status: Should be handled at the toolchain level, not the
       	       kernel, except in assembly code. Not sure if gcc has
       	       been patched to fix the issue.

Category B

740657 Title:  Global Timer can send two interrupts for the same event
       Status: No driver in mainline for the A9 global timer, but the
               proposed patch '[PATCH v3 02/10]
               clocksource:arm_global_timer: Add ARM global timer
               support.' takes care of this errata.

751476 Title:  Missed watchpoint on the second part of an unaligned
               access crossing a page boundary
       Status: Only related to debugging/watchpoint, not affecting
               normal kernel code.

754322 Title:  Faulty MMU translations following ASID switch
       Status: Handled in the kernel, ARM_ERRATA_754322

764369 Title:  Data or unified cache line maintenance by MVA fails on
       	       Inner Shareable memory
       Status: Handled in the kernel, ARM_ERRATA_764369

794072 Title:  A short loop including a DMB instruction might cause a
       	       denial of service on another processor which executes a
       	       CP15 broadcast operation
       Status: Not sure. Can this denial of service be trigerred from
               userspace?

794073 Title:  Speculative instruction fetches with MMU disabled might
       	       not comply with architectural requirements
       Status: Problem happens only when the MMU has been enabled,
               gets disabled, and the branch prediction array has some
               entries. Within the context of Linux, the MMU is only
               turned on, never turned back off. Bootloaders may turn
               on and then off the MMU before entering Linux, so it
               would be the bootloader's job of implementing the
               proposed workaround.

794074 Title:  A write request to Uncacheable, Shareable normal memory
       	       region might be executed twice, possibly causing a
       	       software synchronisation issue
       Status: Not sure.

Category C

725631 Title:  ISB is counted in Performance Monitor events 0x0C and 0x0D
       Status: Only affects performance counters, not critical for
               normal system operation.

729817 Title:  Main ID register alias addresses are not mapped on Debug
       	       APB interface
       Status: Only affects the APB debug interface, not critical for
               normal system operation.


729818 Title:  In debug state, next instruction is stalled when SDABORT
       	       flag is set, instead of being discarded

       Status: Only affects DCC stall mode, use for debugging only,
               not critical for normal system operation.

751471 Title:  DBGPCSR format is incorrect
       Status: Only affects the DBGPCSR, used by debugger tools, not
       	       critical for normal system operation.

752519 Title:  An imprecise abort might be reported twice on non-cacheable reads
       Status: Only happens when an imprecise abort is trigerred,
               which is by itself already a sign of something's going
               really wrong in the system, so having a second
               imprecise abort reported is not going to have any major
               consequence, as the system has most likely already been
               halted due to the first imprecise abort.

754323 Title:  Repeated Store in the same cache line might delay the
       	       visibility of the Store
       Status: Not sure.

756421 Title:  Sticky Pipeline Advance bit cannot be cleared from debug
       	       APB accesses
       Status: APB related, access to debugging specific registers,
       	       not affecting normal system operation.

757119 Title:  Some Unallocated memory hint instructions generate an
       	       Undefined Instruction exception instead of being
       	       treated as NOP
       Status: Compiler-related, not kernel-related, and affected
               instructions are unlikely to be generated by compilers.

761321 Title:  MRC and MCR are not counted in event 0x68
       Status: Performance counters related, not affecting normal
               system operation, only incorrect statistics.

764319 Title:  Read accesses to DBGPRSR and DBGOSLSR may generate an
       	       unexpected Undefined Instruction exception
       Status: As stated in the erratum, "This is unlikely to cause
       	       any significant issue in Cortex-A9 based systems
       	       because these accesses are mainly intended to be used
       	       as part of debug over powerdown sequences, and the
       	       Cortex-A9 does not support this feature."

771224 Title:  Visibility of Debug Enable access rights to
       	       enable/disable tracing is not ensured by an ISB
       Status: Related to debugging features only, not affecting
               normal system operation.

775419 Title:  PMU event 0x0A (exception return) might count twice the
       	       LDM PC ^ instructions with base address register
       	       write-back
       Status: Performance counters related, not affecting normal
               system operation, only incorrect statistics.

-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

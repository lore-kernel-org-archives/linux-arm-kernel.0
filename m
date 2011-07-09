From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:47 +0100
Subject: ARM: kprobes: Add support for Thumb-2
Message-ID: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On ARM, kprobes uses an undefined instruction as a breakpoint. When this
causes an exception, kprobe_handler() is invoked which calls the
pre_handler function as specified by the user. The original CPU
instruction which the breakpoint replaced then needs singlestepping.
As ARM CPUs don't have any hardware support for this it has to be done
by simulating or emulating the instruction.

'Simulation' is where the instruction's behaviour is duplicated in
C code. 'Emulation' is where the original instruction is rewritten
and executed, often by altering its registers.

This patch series adds support for kprobes on Thumb-2 kernels.
This requires making the framework handle Thumb breakpoints and adding
simulation and emulation routines for the Thumb instruction set.

Note, this series also modifies the existing behaviour in the case when
probes are placed on conditionally executed instructions (see patch 15).


Table of Contents:

Make undefined instruction handlers work for Thumb-2
----------------------------------------------------
  01  Thumb-2: Fix exception return sequence to restore stack correctly
  02  Thumb-2: Support Thumb-2 in undefined instruction handler

Source code reorg
-----------------
  03  kprobes: Rename kprobes-decode.c to kprobes-arm.c
  04  kprobes: Split out internal parts of kprobes.h
  05  kprobes: Add kprobes-common.c
  06  kprobes: Move is_writeback define to header file.
  07  kprobes: Move find_str_pc_offset into kprobes-common.c

Get kprobes infrastructure to support Thumb-2
---------------------------------------------
  08  kprobes: Make str_pc_offset a constant on ARMv7
  09  kprobes: Make kprobes framework work on Thumb-2 kernels
  10  kprobes: Add Thumb instruction decoding stubs
  11  Kconfig: Allow kprobes on Thumb-2 kernels
  12  kprobes: Add Thumb breakpoint support
  13  kprobes: Add condition code checking to Thumb emulation
  14  kprobes: Add it_advance()
  15  kprobes: Don't trigger probes on conditional instructions when condition is false
  16  kprobes: Use conditional breakpoints for ARM probes
  17  kprobes: Add hooks to override singlestep()
  18  kprobes: Extend arch_specific_insn to add pointer to emulated instruction
  19  kprobes: Infrastructure for table driven decoding of CPU instructions

16-bit Thumb instruction decoding and emulation/simulation
----------------------------------------------------------
  20  kprobes: Decode 16-bit Thumb hint instructions
  21  ptrace: Add APSR_MASK definition to ptrace.h
  22  kprobes: Decode 16-bit Thumb data-processing instructions
  23  kprobes: Add bx_write_pc()
  24  kprobes: Decode 16-bit Thumb BX and BLX instructions
  25  kprobes: Decode 16-bit Thumb special data instructions
  26  kprobes: Decode 16-bit Thumb load and store instructions
  27  kprobes: Decode 16-bit Thumb PC- and SP-relative address instructions
  28  kprobes: Decode 16-bit Thumb CBZ and bit manipulation instructions
  29  kprobes: Decode 16-bit Thumb PUSH and POP instructions
  30  kprobes: Decode 16-bit Thumb IT instruction
  31  kprobes: Reject 16-bit Thumb SVC and UNDEFINED instructions
  32  kprobes: Decode 16-bit Thumb branch instructions
  33  kprobes: Reject 16-bit Thumb SETEND, CPS and BKPT instructions

32-bit Thumb instruction decoding and emulation/simulation
----------------------------------------------------------
  34  kprobes: Decode 32-bit Thumb hint instructions
  35  kprobes: Add load_write_pc()
  36  kprobes: Add common decoding function for LDM and STM
  37  kprobes: Optimise emulation of LDM and STM
  38  kprobes: Decode 32-bit Thumb load/store multiple instructions
  39  kprobes: Decode 32-bit Thumb load/store dual and load/store exclusive instructions
  40  kprobes: Decode 32-bit Thumb table branch instructions
  41  kprobes: Decode 32-bit Thumb data-processing (shifted register) instructions
  42  kprobes: Decode 32-bit Thumb data-processing (modified immediate) instructions
  43  kprobes: Decode 32-bit Thumb data-processing (plain binary immediate) instructions
  44  kprobes: Decode 32-bit miscellaneous control instructions
  45  kprobes: Decode 32-bit Thumb branch instructions
  46  kprobes: Reject 32-bit Thumb coprocessor and SIMD instructions
  47  kprobes: Decode 32-bit Thumb memory hint instructions
  48  kprobes: Decode 32-bit Thumb load/store single data item instructions
  49  kprobes: Decode 32-bit Thumb data-processing (register) instructions
  50  kprobes: Decode 32-bit Thumb long multiply and divide instructions
  51  kprobes: Decode 32-bit Thumb multiply and absolute difference instructions


Overall diff stat:

 arch/arm/Kconfig                                   |    2 +-
 arch/arm/include/asm/kprobes.h                     |   28 +-
 arch/arm/include/asm/ptrace.h                      |   11 +-
 arch/arm/kernel/Makefile                           |    7 +-
 arch/arm/kernel/entry-header.S                     |   12 +-
 .../arm/kernel/{kprobes-decode.c => kprobes-arm.c} |  187 +---
 arch/arm/kernel/kprobes-common.c                   |  562 ++++++++
 arch/arm/kernel/kprobes-thumb.c                    | 1462 ++++++++++++++++++++
 arch/arm/kernel/kprobes.c                          |  222 +++-
 arch/arm/kernel/kprobes.h                          |  392 ++++++
 arch/arm/kernel/ptrace.c                           |   28 +-
 arch/arm/kernel/traps.c                            |   17 +-
 12 files changed, 2679 insertions(+), 251 deletions(-)

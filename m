From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 19:06:05 +0100
Subject: [GIT PULL] ARM: kprobes: Add support for Thumb-2
Message-ID: <1310580365.2258.73.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Please can you pull these for the next merge window?
These changes add Thumb-2 support to kprobes and have been reviewed and
Acked by Nicolas Pitre.

Thanks

-- 
Jon Medhurst (usually know as Tixy)


The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://git.yxit.co.uk/linux kprobes-thumb

Jon Medhurst (75):
      ARM: Thumb-2: Fix exception return sequence to restore stack correctly
      ARM: Thumb-2: Support Thumb-2 in undefined instruction handler
      ARM: kprobes: Rename kprobes-decode.c to kprobes-arm.c
      ARM: kprobes: Split out internal parts of kprobes.h
      ARM: kprobes: Add kprobes-common.c
      ARM: kprobes: Move is_writeback define to header file.
      ARM: kprobes: Move find_str_pc_offset into kprobes-common.c
      ARM: kprobes: Make str_pc_offset a constant on ARMv7
      ARM: kprobes: Make kprobes framework work on Thumb-2 kernels
      ARM: kprobes: Add Thumb instruction decoding stubs
      ARM: Kconfig: Allow kprobes on Thumb-2 kernels
      ARM: kprobes: Add Thumb breakpoint support
      ARM: kprobes: Add condition code checking to Thumb emulation
      ARM: kprobes: Add it_advance()
      ARM: kprobes: Don't trigger probes on conditional instructions when condition is false
      ARM: kprobes: Use conditional breakpoints for ARM probes
      ARM: kprobes: Add hooks to override singlestep()
      ARM: kprobes: Extend arch_specific_insn to add pointer to emulated instruction
      ARM: kprobes: Infrastructure for table driven decoding of CPU instructions
      ARM: kprobes: Decode 16-bit Thumb hint instructions
      ARM: ptrace: Add APSR_MASK definition to ptrace.h
      ARM: kprobes: Decode 16-bit Thumb data-processing instructions
      ARM: kprobes: Add bx_write_pc()
      ARM: kprobes: Decode 16-bit Thumb BX and BLX instructions
      ARM: kprobes: Decode 16-bit Thumb special data instructions
      ARM: kprobes: Decode 16-bit Thumb load and store instructions
      ARM: kprobes: Decode 16-bit Thumb PC- and SP-relative address instructions
      ARM: kprobes: Decode 16-bit Thumb CBZ and bit manipulation instructions
      ARM: kprobes: Decode 16-bit Thumb PUSH and POP instructions
      ARM: kprobes: Decode 16-bit Thumb IT instruction
      ARM: kprobes: Reject 16-bit Thumb SVC and UNDEFINED instructions
      ARM: kprobes: Decode 16-bit Thumb branch instructions
      ARM: kprobes: Reject 16-bit Thumb SETEND, CPS and BKPT instructions
      ARM: kprobes: Decode 32-bit Thumb hint instructions
      ARM: kprobes: Add load_write_pc()
      ARM: kprobes: Add common decoding function for LDM and STM
      ARM: kprobes: Optimise emulation of LDM and STM
      ARM: kprobes: Decode 32-bit Thumb load/store multiple instructions
      ARM: kprobes: Decode 32-bit Thumb load/store dual and load/store exclusive instructions
      ARM: kprobes: Decode 32-bit Thumb table branch instructions
      ARM: kprobes: Decode 32-bit Thumb data-processing (shifted register) instructions
      ARM: kprobes: Decode 32-bit Thumb data-processing (modified immediate) instructions
      ARM: kprobes: Decode 32-bit Thumb data-processing (plain binary immediate) instructions
      ARM: kprobes: Decode 32-bit miscellaneous control instructions
      ARM: kprobes: Decode 32-bit Thumb branch instructions
      ARM: kprobes: Reject 32-bit Thumb coprocessor and SIMD instructions
      ARM: kprobes: Decode 32-bit Thumb memory hint instructions
      ARM: kprobes: Decode 32-bit Thumb load/store single data item instructions
      ARM: kprobes: Decode 32-bit Thumb data-processing (register) instructions
      ARM: kprobes: Decode 32-bit Thumb long multiply and divide instructions
      ARM: kprobes: Decode 32-bit Thumb multiply and absolute difference instructions
      ARM: kprobes: Migrate ARM space_1111 to decoding tables
      ARM: kprobes: Add alu_write_pc()
      ARM: kprobes: Add BLX macro
      ARM: kprobes: Add emulate_rd12rn16rm0rs8_rwflags()
      ARM: kprobes: Migrate ARM data-processing (register) instructions to decoding tables
      ARM: kprobes: Add emulate_ldrdstrd()
      ARM: kprobes: Migrate ARM LDRD and STRD to decoding tables
      ARM: kprobes: Migrate ARM space_cccc_000x to decoding tables
      ARM: kprobes: Migrate ARM space_cccc_001x to decoding tables
      ARM: kprobes: Add emulate_rd12rn16rm0_rwflags_nopc()
      ARM: kprobes: Migrate ARM space_cccc_0110__1 to decoding tables
      ARM: kprobes: Migrate ARM space_cccc_0111__1 to decoding tables
      ARM: kprobes: Migrate ARM space_cccc_01xx to decoding tables
      ARM: kprobes: Migrate ARM space_cccc_100x to decoding tables
      ARM: kprobes: Migrate remaining instruction decoding functions to tables
      ARM: kprobes: Add emulate_rd16rn12rm0rs8_rwflags_nopc()
      ARM: kprobes: Replace use of prep_emulate_rd12rn16rm0_wflags()
      ARM: kprobes: Add emulate_rd12rm0_noflags_nopc()
      ARM: kprobes: Add emulate_rdlo12rdhi16rn0rm8_rwflags_nopc()
      ARM: kprobes: Add new versions of emulate_ldr() and emulate_str()
      ARM: kprobes: Use new versions of emulate_ldr() and emulate_str()
      ARM: kprobes: Reject probing of unprivileged load and store instructions
      ARM: kprobes: Decode ARM preload (immediate) instructions
      ARM: kprobes: Remove now unused code

 arch/arm/Kconfig                 |    2 +-
 arch/arm/include/asm/kprobes.h   |   28 +-
 arch/arm/include/asm/ptrace.h    |   11 +-
 arch/arm/kernel/Makefile         |    7 +-
 arch/arm/kernel/entry-header.S   |   12 +-
 arch/arm/kernel/kprobes-arm.c    |  999 +++++++++++++++++++++++
 arch/arm/kernel/kprobes-common.c |  577 +++++++++++++
 arch/arm/kernel/kprobes-decode.c | 1670 --------------------------------------
 arch/arm/kernel/kprobes-thumb.c  | 1462 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes.c        |  222 +++++-
 arch/arm/kernel/kprobes.h        |  420 ++++++++++
 arch/arm/kernel/ptrace.c         |   28 +-
 arch/arm/kernel/traps.c          |   17 +-
 13 files changed, 3707 insertions(+), 1748 deletions(-)
 create mode 100644 arch/arm/kernel/kprobes-arm.c
 create mode 100644 arch/arm/kernel/kprobes-common.c
 delete mode 100644 arch/arm/kernel/kprobes-decode.c
 create mode 100644 arch/arm/kernel/kprobes-thumb.c
 create mode 100644 arch/arm/kernel/kprobes.h

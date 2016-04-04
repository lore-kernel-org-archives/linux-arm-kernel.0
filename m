From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:16 +0200
Subject: [PATCH 0/8] arm64: 2016 head.S spring cleaning
Message-ID: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After having been responsible for obfuscating the head.S code in the v4.6
cycle to implement KASLR support, this series attempts to make amends by
performing some janitorial duties as well.

The main point of this series is to get rid of the file scoped callee saved
registers in head.S to store the FDT pointer, ID map and swapper dir addresses,
KASLR offset, PHYS offset etc. The fact that these are file scoped makes it
unnecessarily complicated to reason about lifetimes etc, especially since the
code is called by both the boot CPU and secondaries.

Since some of these functions are called without a stack, we still need to use
callee saved registers to preserve values across function calls without
stacking/unstacking the previous values, but these instances are now function
scoped, not file scoped, and documented.

Patch #1 gets rid of the confusing subtraction of address and offset values to
obtain __secondary_switched.

Patch #2 gets rid of x21 in head.S

Patch #3 creates moves the stack pointer init to an earlier time in
__mmap_switched, and creates a proper stack frame.

Patch #4 changes the EL2 detection code to simply use x0 as a return value and
first argument.

Patch #5 gets rid of x25 and x26 to store idmap_pg_dir and swapper_pg_dir

Patch #6 gets rid of x27 to store __mmap_switched or __secondary_switched

Patch #7 gets rid of x24 to store PHYS_OFFSET

Patch #8 gets rid of x23 to store the kaslr offset

@Maintainers: feel free to cherry pick if not all [or none] of these patches
make sense to you

Ard Biesheuvel (8):
  arm64/kernel: use literal for relocated address of
    __secondary_switched
  arm64/kernel: reuse boot_args array to get to __fdt_pointer
  arm64/kernel: use a proper stack frame in __mmap_switched()
  arm64/kernel: use ordinary calling convention for EL2 setup
  arm64/kernel: refer to idmap_pg_dir and swapper_pg_dir directly
  arm64/kernel: pass virtual entry point as __enable_mmu() argument
  arm64/kernel: drop __PHYS_OFFSET register with file scope from head.S
  arm64/kernel: drop global kaslr_offset in x23 from head.S

 arch/arm64/kernel/head.S  | 177 +++++++++++---------
 arch/arm64/kernel/setup.c |   4 +-
 2 files changed, 95 insertions(+), 86 deletions(-)

-- 
2.5.0

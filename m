From: liuj97@gmail.com (Jiang Liu)
Date: Sun, 13 Oct 2013 22:50:20 +0800
Subject: [PATCH v2 0/7] Optimize jump label implementation on ARM64
Message-ID: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

This patchset tries to optimize arch specfic jump label implementation
for ARM64 by dynamic kernel text patching.

To enable this feature, your toolchain must support "asm goto" extension
and "%c" constraint extesion. Current GCC for AARCH64 doesn't support
"%c", so you need a GCC patch similiar to this:
http://gcc.gnu.org/viewcvs/gcc/trunk/gcc/config/arm/arm.c?view=patch&r1=175293&r2=175565&pathrev=175565
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637

It has been tested on ARM Fast mode, but not on real hardware yet.

Any comments are welcomed!

V1->V2: address review comments of V1
1) refine comments
2) add a new interface to always synchronize with stop_machine()
   when patching code
3) handle endian issue when patching code

Jiang Liu (7):
  arm64: introduce basic aarch64 instruction decoding helpers
  arm64: introduce interfaces to hotpatch kernel and module code
  arm64: move encode_insn_immediate() from module.c to insn.c
  arm64: introduce aarch64_insn_gen_{nop|branch_imm}() helper functions
  arm64, jump label: detect %c support for ARM64
  arm64, jump label: optimize jump label implementation
  jump_label: use defined macros instead of hard-coding for better
    readability

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/insn.h       |  79 ++++++++++
 arch/arm64/include/asm/jump_label.h |  52 +++++++
 arch/arm64/kernel/Makefile          |   3 +-
 arch/arm64/kernel/insn.c            | 290 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/jump_label.c      |  60 ++++++++
 arch/arm64/kernel/module.c          | 151 ++++---------------
 include/linux/jump_label.h          |  15 +-
 scripts/gcc-goto.sh                 |   2 +-
 9 files changed, 527 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/include/asm/insn.h
 create mode 100644 arch/arm64/include/asm/jump_label.h
 create mode 100644 arch/arm64/kernel/insn.c
 create mode 100644 arch/arm64/kernel/jump_label.c

-- 
1.8.1.2

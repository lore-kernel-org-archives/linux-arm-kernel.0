From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:04:16 +0000
Subject: [PATCH v2 0/9] ARM: Thumb-2: Various fixes for building Thumb-2
	kernels
Message-ID: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes various minor problems affecting building with
CONFIG_THUMB2_KERNEL.

v2: 

  * Improve zImage header layout patch based on feedback.
  * Disable kprobes via Kconfig when using CONFIG_THUMB2_KERNEL (for now)
  * Force longer-range Thumb-2 branch encoding for some branches in head.S,
	to avoid fixup errors when vmlinux is large.

Applies to 2.6.37-rc3


v1:

Fix misaligned data risks resulting from .long/.word without .align:
 * ARM: kexec: Correct data alignment for CONFIG_THUMB2_KERNEL
 * ARM: vfp: Correct data alignment for CONFIG_THUMB2_KERNEL
 * ARM: Thumb-2: Correct data alignment for CONFIG_THUMB2_KERNEL in bootp/init.S
 * ARM: Thumb-2: Correct data alignment for CONFIG_THUMB2_KERNEL in kernel/head.S
 * ARM: Thumb-2: Correct data alignment for CONFIG_THUMB2_KERNEL in mm/proc-v7.S

Fix Thumb-2 incompatibilities in compressed kernel entry code,
to avoid build failures:
 * ARM: Thumb-2: Fix CONFIG_THUMB2_KERNEL breakage in compressed/head.S

Fix strange zImage header layout when building Thumb-2 kernels:
 * ARM: Thumb-2: Restore sensible zImage header layout for CONFIG_THUMB2_KERNEL

----

Dave Martin (9):
  ARM: kexec: Correct data alignment for CONFIG_THUMB2_KERNEL
  ARM: vfp: Correct data alignment for CONFIG_THUMB2_KERNEL
  ARM: Thumb-2: Correct data alignment for CONFIG_THUMB2_KERNEL in
    bootp/init.S
  ARM: Thumb-2: Correct data alignment for CONFIG_THUMB2_KERNEL in
    kernel/head.S
  ARM: Thumb-2: Correct data alignment for CONFIG_THUMB2_KERNEL in
    mm/proc-v7.S
  ARM: Thumb-2: Fix CONFIG_THUMB2_KERNEL breakage in compressed/head.S
  ARM: Thumb-2: Restore sensible zImage header layout for
    CONFIG_THUMB2_KERNEL
  ARM: Thumb-2: Fix long-distance conditional branches in head.S for
    Thumb-2.
  ARM: kprobes: Don't HAVE_KPROBES when CONFIG_THUMB2_KERNEL is
    selected

 arch/arm/Kconfig                  |    2 +-
 arch/arm/boot/Makefile            |    5 -----
 arch/arm/boot/bootp/init.S        |    2 ++
 arch/arm/boot/compressed/head.S   |   15 +++++++++++----
 arch/arm/kernel/head.S            |    7 +++++++
 arch/arm/kernel/relocate_kernel.S |    2 ++
 arch/arm/mm/proc-v7.S             |    4 ++--
 arch/arm/vfp/vfphw.S              |    1 +
 8 files changed, 26 insertions(+), 12 deletions(-)

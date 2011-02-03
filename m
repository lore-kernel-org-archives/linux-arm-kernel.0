From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  3 Feb 2011 18:02:36 +0000
Subject: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Message-ID: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches, along with some other patches under
discussion on alkml, should enable omap3 and omap4 kernels to be
built with CONFIG_THUMB2_KERNEL.

This patch set builds on recent cleanup done by the omap
maintainers.

It is also more aggressive than my last post: all affected
low-level code is now built in Thumb-2.  At least some of this
code definitely works, but whether the Secure firmware can talk
to Thumb-2 code properly is unproven:
in particular, I could use some help/advice from the omap
community for validating that the low-level power management
interactions actually work with this patch set.

I've done simple "does it boot?" testing by building a single
kernel with CONFIG_SMP_ON_UP and CONFIG_THUMB2_KERNEL enabled
which works on Beagle xM A2 and Panda A1.

Details below.

Cheers,
Dave


The patches can be found, along with a buildable working tree,
in the following repo:

git://git.linaro.org/people/dmart/linux-2.6-arm.git

 * arm/omap-thumb2: has the patches proposed here
 * arm/omap-thumb2+merged: additionally has some patches cherry-
        picked from other trees which are needed in order for the
        patches on arm/omap-thumb2 to work usefully.
 * dirty/arm/omap-thumb2+merged: buildable test tree, which adds
        2 local patches to work around a toolchain bug.

A working kernel config for this tree is here:
http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config :

  CONFIG_SMP_ON_UP=y
  CONFIG_THUMB2_KERNEL=y
  CONFIG_SERIAL_OMAP=n (to avoid garbage on xM; for Panda use console=ttyS2)

(The config is derived from the linaro omap config and so turns on
loads of modules -- don't feel you have to build them all...)


Cherry-picked patches originated from Russell's devel tree
and Tony Lindgren's omap-testing tree:

http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git devel

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-testing


Dave Martin (5):
  ARM: omap4: Correct definition of do_wfi() for CONFIG_THUMB2_KERNEL
  ARM: omap4: Convert END() to ENDPROC() for correct linkage with
    CONFIG_THUMB2_KERNEL
  ARM: omap3: Remove hand-encoded SMC instructions
  ARM: omap3: Thumb-2 compatibility for sram34xx.S
  ARM: omap3: Thumb-2 compatibility for sleep34xx.S

 arch/arm/mach-omap2/include/mach/omap4-common.h |    5 ++
 arch/arm/mach-omap2/omap-headsmp.S              |    2 +-
 arch/arm/mach-omap2/omap44xx-smc.S              |    8 ++--
 arch/arm/mach-omap2/sleep34xx.S                 |   56 ++++++++++++++++-------
 arch/arm/mach-omap2/sram34xx.S                  |   28 ++++++++---
 5 files changed, 69 insertions(+), 30 deletions(-)

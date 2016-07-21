From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 21 Jul 2016 11:11:34 -0400
Subject: [PATCH] ARM: dont specify STACKPROTECTOR in defconfigs
Message-ID: <20160721151134.5803-1-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note the output from the following:

   $ git grep STACKPROTECTOR arch/arm/configs/
   arch/arm/configs/aspeed_g4_defconfig:CONFIG_CC_STACKPROTECTOR_STRONG=y
   arch/arm/configs/aspeed_g5_defconfig:CONFIG_CC_STACKPROTECTOR_STRONG=y
   arch/arm/configs/bcm2835_defconfig:CONFIG_CC_STACKPROTECTOR_REGULAR=y
   $

Only three defconfigs specify a value.  And two of the three ask for
the strong variant, which isn't supported by older toolchains.

Due to the nature of ARM having more platform specific code than say
x86, the allyesconfig and allmodconfig aren't as effective for build
coverage.  So, in addition, I like to use a trivial script to walk all
the defconfigs and build each one.

However I will get false positives on unsupported stackprotector values
with an older toolchain like gcc-4.6.3.  As in this instance I am just
using the compiler as a glorified syntax checker on a machine where I
build a bunch of other arch for the same reason, there is no real
motivation to get a newer toolchain for improved optimization etc.

Since there are only three of them, and there is nothing about these
settings that are board/platform specific, I propose we just eliminate
the three existing instances and take the default.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel at lists.infradead.org
Cc: bcm-kernel-feedback-list at broadcom.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/configs/aspeed_g4_defconfig | 1 -
 arch/arm/configs/aspeed_g5_defconfig | 1 -
 arch/arm/configs/bcm2835_defconfig   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index b6e54ee9bdbd..78dae22c56de 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -18,7 +18,6 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_CC_STACKPROTECTOR_STRONG=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLOCK is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 892605167357..2253a09cc3c2 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -18,7 +18,6 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-CONFIG_CC_STACKPROTECTOR_STRONG=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLOCK is not set
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index cc55e4252fda..8c06b380c561 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -24,7 +24,6 @@ CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_JUMP_LABEL=y
-CONFIG_CC_STACKPROTECTOR_REGULAR=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
-- 
2.8.4

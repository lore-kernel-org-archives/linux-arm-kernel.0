From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Sep 2010 11:56:56 +0200
Subject: [PATCH 5/7] ARM: don't expose CONFIG_ZRELADDR to the users
In-Reply-To: <20100903095504.GC13643@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
Message-ID: <1283507818-1573-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This value is essential for booting a zImage and only depends on the
memory layout of the machine to boot.  This value was specified in
Makefile.boot before

	e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)

and so wasn't available to change via .config.

The only exception is bcmring that had a extra config for specifing the
address used, which is removed in this commit, too, as it isn't used
anymore since e69edc79.  This is the only machine that still gets a
possibility to change CONFIG_ZRELADDR.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Eric Miao <eric.miao@canonical.com>
Cc: Leo Chen <leochen@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                    |    2 +-
 arch/arm/configs/bcmring_defconfig  |    1 -
 arch/arm/mach-bcmring/Kconfig       |    3 ---
 arch/arm/mach-bcmring/Makefile.boot |    1 -
 4 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4a9a55c..0654afe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1577,7 +1577,7 @@ config AUTO_ZRELADDR
 	  from start of memory.
 
 config ZRELADDR
-	hex "Physical address of the decompressed kernel image"
+	hex "Physical address of the decompressed kernel image" if ARCH_BCMRING
 	depends on !AUTO_ZRELADDR
 	default 0x00008000 if ARCH_BCMRING ||\
 		ARCH_CNS3XXX ||\
diff --git a/arch/arm/configs/bcmring_defconfig b/arch/arm/configs/bcmring_defconfig
index 75984cd..9168d05 100644
--- a/arch/arm/configs/bcmring_defconfig
+++ b/arch/arm/configs/bcmring_defconfig
@@ -21,7 +21,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_BCMRING=y
-CONFIG_BCM_ZRELADDR=0x8000
 CONFIG_CPU_32v6K=y
 CONFIG_NO_HZ=y
 CONFIG_PREEMPT=y
diff --git a/arch/arm/mach-bcmring/Kconfig b/arch/arm/mach-bcmring/Kconfig
index 457b438..e076cc8 100644
--- a/arch/arm/mach-bcmring/Kconfig
+++ b/arch/arm/mach-bcmring/Kconfig
@@ -13,9 +13,6 @@ endchoice
 menu "BCMRING Options"
 	depends on ARCH_BCMRING
 
-config BCM_ZRELADDR
-	hex "Compressed ZREL ADDR"
-
 endmenu
 
 # source "drivers/char/bcmring/Kconfig"
diff --git a/arch/arm/mach-bcmring/Makefile.boot b/arch/arm/mach-bcmring/Makefile.boot
index fb53b28..6894871 100644
--- a/arch/arm/mach-bcmring/Makefile.boot
+++ b/arch/arm/mach-bcmring/Makefile.boot
@@ -1,6 +1,5 @@
 # Address where decompressor will be written and eventually executed.
 #
 # default to SDRAM
-zreladdr-y      := $(CONFIG_BCM_ZRELADDR)
 params_phys-y   := 0x00000800
 
-- 
1.7.1

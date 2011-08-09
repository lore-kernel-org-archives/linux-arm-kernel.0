From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 9 Aug 2011 21:41:31 +0200
Subject: [PATCH 2/5] mach-u300: drop SEMI config option
Message-ID: <1312918891-11861-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

When we have only dual-RAM configurations, the SEMI (shared
memory interface) must always be enabled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/Kconfig |    8 --------
 arch/arm/mach-u300/core.c  |    9 +--------
 2 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index d3a9ca4..966a5a0 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -54,14 +54,6 @@ config U300_DEBUG
 	help
 		Debug support for U300 in sysfs, procfs etc.
 
-config MACH_U300_SEMI_IS_SHARED
-	bool "The SEMI is used by both the access and application side"
-	depends on MACH_U300
-	help
-		This makes it possible to use the SEMI (Shared External
-		Memory Interface) from both from access and application
-		side.
-
 config MACH_U300_SPIDUMMY
 	bool "SSP/SPI dummy chip"
 	select SPI
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 399c89f..8b78af9 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1837,17 +1837,10 @@ void __init u300_init_devices(void)
 	/* Register subdevices on the SPI bus */
 	u300_spi_register_board_devices();
 
-#ifndef CONFIG_MACH_U300_SEMI_IS_SHARED
-	/*
-	 * Enable SEMI self refresh. Self-refresh of the SDRAM is entered when
-	 * both subsystems are requesting this mode.
-	 * If we not share the Acc SDRAM, this is never the case. Therefore
-	 * enable it here from the App side.
-	 */
+	/* Enable SEMI self refresh */
 	val = readw(U300_SYSCON_VBASE + U300_SYSCON_SMCR) |
 		U300_SYSCON_SMCR_SEMI_SREFREQ_ENABLE;
 	writew(val, U300_SYSCON_VBASE + U300_SYSCON_SMCR);
-#endif /* CONFIG_MACH_U300_SEMI_IS_SHARED */
 }
 
 static int core_module_init(void)
-- 
1.7.3.2

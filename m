From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 21 Nov 2017 14:50:41 +0000
Subject: [PATCH] ARM: make decompressor debug output user selectable
Message-ID: <E1eH9sn-0007yj-E1@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the decompressor debug output user selectable, otherwise merely
enabling DEBUG_LL causes the decompressor to become board specific,
thereby preventing a multi-platform kernel from booting.  Enabling
DEBUG_LL doesn't cause the kernel itself to become platform specific
unless EARLY_PRINTK is enabled, or one of the debugging routines is
added in a path that results in it being called.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6dcea8e8e941..fa021568d051 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1757,9 +1757,9 @@ config DEBUG_UART_8250_FLOW_CONTROL
 	default y if ARCH_EBSA110 || DEBUG_FOOTBRIDGE_COM1 || DEBUG_GEMINI || ARCH_RPC
 
 config DEBUG_UNCOMPRESS
-	bool
+	bool "Enable decompressor debugging via DEBUG_LL output"
 	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
+	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART
 	help
-- 
2.7.4

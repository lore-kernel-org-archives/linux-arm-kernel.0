From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Thu, 15 Apr 2010 13:53:21 -0400
Subject: [PATCH] ARM: LPC32XX: adding a LPC3XXX machine for backwards
	compatibility
Message-ID: <1271354001-14210-1-git-send-email-bengardiner@nanometrics.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the previous release of the lpc3250 kernel support -- a patch against
2.6.27.8 -- the machine type registered was LPC3XXX. This patch proposes
to enable a compatibiluty machine definition so that existing u-boots
can use a newer kernel without being re-flashed.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 arch/arm/mach-lpc32xx/Kconfig   |    5 +++++
 arch/arm/mach-lpc32xx/phy3250.c |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
index d522922..fade298 100644
--- a/arch/arm/mach-lpc32xx/Kconfig
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -47,4 +47,9 @@ config ARCH_LPC32XX_HSUART7_SELECT
 
 endmenu
 
+config LPC3XXX_COMPAT
+	bool "Define also a LPC3XXX machine"
+	help
+	 Adds also a LPC3XXX machine for backwards compatibility with old u-boot versions.
+
 endif
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 2672b63..a7d94d7 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -569,3 +569,17 @@ MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
 	.timer		= &lpc32xx_timer,
 	.init_machine	= phy3250_board_init,
 MACHINE_END
+
+#ifdef CONFIG_LPC3XXX_COMPAT
+MACHINE_START(LPC3XXX, "Phytec 3250 board with the LPC3250 Microcontroller")
+	/* Maintainer: Kevin Wells, NXP Semiconductors */
+	.phys_io	= LPC32XX_UART5_BASE,
+	.io_pg_offst	= ((IO_ADDRESS(LPC32XX_UART5_BASE))>>18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= lpc32xx_map_io,
+	.init_irq	= lpc32xx_init_irq,
+	.timer		= &lpc32xx_timer,
+	.init_machine	= phy3250_board_init,
+MACHINE_END
+
+#endif
-- 
1.6.3.3

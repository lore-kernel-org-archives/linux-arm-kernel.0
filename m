From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 15 Jul 2011 12:24:21 +0200
Subject: [PATCH 1/3] ARM: tegra: paz00: add support serial port on JP1
In-Reply-To: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
References: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
Message-ID: <1310725464-2524-2-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART-A is connected to JP1 and used by the bootloader for debugging
output while UART-D is connected to the mini-pcie expansion slot.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 1b076f6..931b06e 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -47,7 +47,17 @@
 #include "gpio-names.h"
 
 static struct plat_serial8250_port debug_uart_platform_data[] = {
+/* serial port on JP1 */
 	{
+		.membase	= IO_ADDRESS(TEGRA_UARTA_BASE),
+		.mapbase	= TEGRA_UARTA_BASE,
+		.irq		= INT_UARTA,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 216000000,
+	}, {
+/* serial port on mini-pcie */
 		.membase	= IO_ADDRESS(TEGRA_UARTD_BASE),
 		.mapbase	= TEGRA_UARTD_BASE,
 		.irq		= INT_UARTD,
@@ -137,6 +147,7 @@ static void __init tegra_paz00_fixup(struct machine_desc *desc,
 
 static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
 	/* name		parent		rate		enabled */
+	{ "uarta",	"pll_p",	216000000,	true },
 	{ "uartd",	"pll_p",	216000000,	true },
 	{ NULL,		NULL,		0,		0},
 };
-- 
1.7.4.1

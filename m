From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 11:48:42 +0100
Subject: [PATCH V3 4/5] [RFC] ARM: shmobile: genmai: Add preliminary RSPI
 pinmux setup
In-Reply-To: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
References: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389523723-2288-5-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This does not work as there's no pinmux configuration in setup-r7s72100.c
yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - New
V3:
  - No changes

 arch/arm/mach-shmobile/board-genmai.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index f85628e24de4..c8d07d3d81e9 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
 #include <linux/spi/rspi.h>
@@ -80,9 +81,25 @@ static const struct spi_board_info spi_info[] __initconst = {
 	},
 };
 
+static const struct pinctrl_map genmai_pinctrl_map[] = {
+	/* RSPI4 */
+	PIN_MAP_MUX_GROUP_DEFAULT("rspi.4", "pfc-r7s72100",
+				  "rspi4_rspck_p4_0", "rspi4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rspi.4", "pfc-r7s72100",
+				  "rspi4_ssl0_p4_1", "rspi4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rspi.4", "pfc-r7s72100",
+				  "rspi4_mosi_p4_2", "rspi4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rspi.4", "pfc-r7s72100",
+				  "rspi4_miso_p4_3", "rspi4"),
+};
+
 static void __init genmai_add_standard_devices(void)
 {
 	r7s72100_clock_init();
+	pinctrl_register_mappings(genmai_pinctrl_map,
+				  ARRAY_SIZE(genmai_pinctrl_map));
+	/* FIXME there's no pinmux configuration in setup-r7s72100.c yet */
+	/* r7s72100_pinmux_init(); */
 	r7s72100_add_dt_devices();
 
 	r7s72100_register_rspi(0);
-- 
1.7.9.5

From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Dec 2013 21:15:59 +0100
Subject: [PATCH v2 5/8] [RFC] ARM: shmobile: genmai: Add preliminary RSPI
 pinmux setup
In-Reply-To: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388175362-17132-6-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This does not work as there's no pinmux configuration in setup-r7s72100.c
yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
New in v2

 arch/arm/mach-shmobile/board-genmai.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index 7c912d337828..d89d87ac1c6f 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
 #include <linux/spi/spi.h>
@@ -51,9 +52,25 @@ static const struct spi_board_info spi_info[] __initconst = {
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
 
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
-- 
1.7.9.5

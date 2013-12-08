From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 8 Dec 2013 23:52:44 +0300
Subject: [PATCH v3 2/3] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>
Message-ID: <201312082352.45265.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register Ether platform device and pin data on  the  Koelsch board. 
Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- changed "r8a779x-ether" wildcard device name to "r8a7791-ether";
- added PFC data for IRQ0 pin used by KSZ8041 PHY;
- resolved rejects, refreshed the patch.

Changes in version 2:
- added *if* (IS_ENABLED(CONFIG_PHYLIB)) around phy_register_fixup_for_id()
  call;
- changed Ether device name to "r8a779x-ether".

 arch/arm/mach-shmobile/board-koelsch.c |   57 ++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
+++ renesas/arch/arm/mach-shmobile/board-koelsch.c
@@ -24,15 +24,31 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/phy.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* Ether */
+static const struct sh_eth_plat_data ether_pdata __initconst = {
+	.phy			= 0x1,
+	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
+	.phy_interface		= PHY_INTERFACE_MODE_RMII,
+	.ether_link_active_low	= 1,
+};
+
+static const struct resource ether_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee700000, 0x400),
+	DEFINE_RES_IRQ(gic_spi(162)),
+};
+
 /* LEDS */
 static struct gpio_led koelsch_leds[] = {
 	{
@@ -80,6 +96,15 @@ static const struct gpio_keys_platform_d
 };
 
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-ether", "pfc-r8a7791",
+				  "eth_link", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-ether", "pfc-r8a7791",
+				  "eth_mdio", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-ether", "pfc-r8a7791",
+				  "eth_rmii", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-ether", "pfc-r8a7791",
+				  "intc_irq0", "intc"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7791",
 				  "scif0_data_d", "scif0"),
@@ -95,6 +120,10 @@ static void __init koelsch_add_standard_
 				  ARRAY_SIZE(koelsch_pinctrl_map));
 	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
+	platform_device_register_resndata(&platform_bus, "r8a7791-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  &ether_pdata, sizeof(ether_pdata));
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &koelsch_leds_pdata,
 				      sizeof(koelsch_leds_pdata));
@@ -103,6 +132,32 @@ static void __init koelsch_add_standard_
 				      sizeof(koelsch_keys_pdata));
 }
 
+/*
+ * Ether LEDs on the Koelsch board are named LINK and ACTIVE which corresponds
+ * to non-default 01 setting of the Micrel KSZ8041 PHY control register 1 bits
+ * 14-15. We have to set them back to 01 from the default 00 value each time
+ * the PHY is reset. It's also important because the PHY's LED0 signal is
+ * connected to SoC's ETH_LINK signal and in the PHY's default mode it will
+ * bounce on and off after each packet, which we apparently want to avoid.
+ */
+static int koelsch_ksz8041_fixup(struct phy_device *phydev)
+{
+	u16 phyctrl1 = phy_read(phydev, 0x1e);
+
+	phyctrl1 &= ~0xc000;
+	phyctrl1 |= 0x4000;
+	return phy_write(phydev, 0x1e, phyctrl1);
+}
+
+static void __init koelsch_init(void)
+{
+	koelsch_add_standard_devices();
+
+	if (IS_ENABLED(CONFIG_PHYLIB))
+		phy_register_fixup_for_id("r8a7791-ether-ff:01",
+					  koelsch_ksz8041_fixup);
+}
+
 static const char * const koelsch_boards_compat_dt[] __initconst = {
 	"renesas,koelsch",
 	NULL,
@@ -112,7 +167,7 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_time	= rcar_gen2_timer_init,
-	.init_machine	= koelsch_add_standard_devices,
+	.init_machine	= koelsch_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END

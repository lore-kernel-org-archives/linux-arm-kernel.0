From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Oct 2013 02:19:58 +0300
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
Message-ID: <201310310219.58963.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register Ether platform device and pin data on  the  Koelsch board. 
Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-koelsch.c |   61 ++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
+++ renesas/arch/arm/mach-shmobile/board-koelsch.c
@@ -24,14 +24,31 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/phy.h>
+#include <linux/pinctrl/machine.h>
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
@@ -70,11 +87,29 @@ static const struct gpio_keys_platform_d
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+static const struct pinctrl_map koelsch_pinctrl_map[] = {
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
+				  "eth_link", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
+				  "eth_mdio", "eth"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
+				  "eth_rmii", "eth"),
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
+
+	pinctrl_register_mappings(koelsch_pinctrl_map,
+				  ARRAY_SIZE(koelsch_pinctrl_map));
 	r8a7791_pinmux_init();
+
 	r8a7791_add_standard_devices();
+	platform_device_register_resndata(&platform_bus, "r8a7790-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  &ether_pdata, sizeof(ether_pdata));
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &koelsch_leds_pdata,
 				      sizeof(koelsch_leds_pdata));
@@ -83,6 +118,30 @@ static void __init koelsch_add_standard_
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
+	phy_register_fixup_for_id("r8a7790-ether-ff:01", koelsch_ksz8041_fixup);
+}
+
 static const char * const koelsch_boards_compat_dt[] __initconst = {
 	"renesas,koelsch",
 	NULL,
@@ -91,7 +150,7 @@ static const char * const koelsch_boards
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
-	.init_machine	= koelsch_add_standard_devices,
+	.init_machine	= koelsch_init,
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END

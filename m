From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Dec 2013 02:28:00 +0300
Subject: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
In-Reply-To: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
Message-ID: <201312200228.00555.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
trigger type to be low-level as per the Micrel PHY driver's setup.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-koelsch.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-koelsch.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
+++ renesas/arch/arm/mach-shmobile/board-koelsch.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/phy.h>
@@ -92,6 +93,7 @@ static void __init koelsch_add_du_device
 /* Ether */
 static const struct sh_eth_plat_data ether_pdata __initconst = {
 	.phy			= 0x1,
+	.phy_irq		= irq_pin(0),
 	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
 	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 	.ether_link_active_low	= 1,
@@ -215,6 +217,8 @@ static void __init koelsch_init(void)
 {
 	koelsch_add_standard_devices();
 
+	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
+
 	if (IS_ENABLED(CONFIG_PHYLIB))
 		phy_register_fixup_for_id("r8a7791-ether-ff:01",
 					  koelsch_ksz8041_fixup);

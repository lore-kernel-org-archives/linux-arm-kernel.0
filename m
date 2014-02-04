From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 4 Feb 2014 18:53:50 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: Lager: pass Ether PHY IRQ
In-Reply-To: <201402041851.47198.sergei.shtylyov@cogentembedded.com>
References: <201402041851.47198.sergei.shtylyov@cogentembedded.com>
Message-ID: <201402041853.51460.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
trigger type to be low-level as per the Micrel PHY driver's setup.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed the patch.

 arch/arm/mach-shmobile/board-lager.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-lager.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-lager.c
+++ renesas/arch/arm/mach-shmobile/board-lager.c
@@ -22,6 +22,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
@@ -233,6 +234,7 @@ static const struct resource mmcif1_reso
 /* Ether */
 static const struct sh_eth_plat_data ether_pdata __initconst = {
 	.phy			= 0x1,
+	.phy_irq		= irq_pin(0),
 	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
 	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 	.ether_link_active_low	= 1,
@@ -618,6 +620,8 @@ static void __init lager_init(void)
 {
 	lager_add_standard_devices();
 
+	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
+
 	if (IS_ENABLED(CONFIG_PHYLIB))
 		phy_register_fixup_for_id("r8a7790-ether-ff:01",
 					  lager_ksz8041_fixup);

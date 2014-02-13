From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:03:49 +0900
Subject: [PATCH 02/11] ARM: shmobile: Koelsch: pass Ether PHY IRQ
In-Reply-To: <cover.1392276547.git.horms+renesas@verge.net.au>
References: <cover.1392276547.git.horms+renesas@verge.net.au>
Message-ID: <29d9f010d7103f2b83ce1c25999a6f3a1e57f5e2.1392276547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
trigger type to be low-level as per the Micrel PHY driver's setup.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 2ab5c75..1ec3b91 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/phy.h>
@@ -92,6 +93,7 @@ static void __init koelsch_add_du_device(void)
 /* Ether */
 static const struct sh_eth_plat_data ether_pdata __initconst = {
 	.phy			= 0x1,
+	.phy_irq		= irq_pin(0),
 	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
 	.phy_interface		= PHY_INTERFACE_MODE_RMII,
 	.ether_link_active_low	= 1,
@@ -232,6 +234,8 @@ static void __init koelsch_init(void)
 {
 	koelsch_add_standard_devices();
 
+	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
+
 	if (IS_ENABLED(CONFIG_PHYLIB))
 		phy_register_fixup_for_id("r8a7791-ether-ff:01",
 					  koelsch_ksz8041_fixup);
-- 
1.8.5.2

From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu,  2 May 2013 20:25:38 +0200
Subject: [PATCH 1/3] ARM: dove: add DT parsing for legacy mv643xx_eth
In-Reply-To: <1367519140-19716-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519140-19716-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367519140-19716-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow to move to orion irqchip driver, existing legacy devices
have to map their irqs. This patch adds a node for mv643xx_eth and
some init code to map the corresponding irqs. While the device tree
node can stay, the init code will vanish as soon as there is true
device tree support for mv643xx_eth.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi   |    7 +++++++
 arch/arm/mach-dove/board-dt.c |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index f7509ca..ea7c5da 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -197,6 +197,13 @@
 			status = "disabled";
 		};
 
+		gbe: ethernet-controller {
+			compatible = "marvell,mv643xx-eth-block";
+			reg = <0x72000 0x4000>;
+			interrupts = <29>, <30>;
+			status = "disabled";
+		};
+
 		rtc at d8500 {
 			compatible = "marvell,orion-rtc";
 			reg = <0xd8500 0x20>;
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index fbde1dd..9df6dd7 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -12,6 +12,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/mvebu.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <asm/hardware/cache-tauros2.h>
@@ -57,6 +58,34 @@ static struct mv643xx_eth_platform_data dove_dt_ge00_data = {
 	.phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT,
 };
 
+#define DOVE_GE00_PHYS_BASE	0xf1070000
+
+static void __init dove_legacy_ge00_init(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL, NULL,
+					 "marvell,mv643xx-eth-block");
+	int irq_sum, irq_err;
+
+	if (!np)
+		return;
+
+	irq_sum = irq_of_parse_and_map(np, 0);
+	if (!irq_sum) {
+		pr_err("%s: missing sum irq\n", np->full_name);
+		return;
+	}
+
+	irq_err = irq_of_parse_and_map(np, 1);
+	if (!irq_err) {
+		pr_err("%s: missing err irq\n", np->full_name);
+		return;
+	}
+
+	/* legacy ge00_init wants phys base */
+	orion_ge00_init(&dove_dt_ge00_data, DOVE_GE00_PHYS_BASE,
+			irq_sum, irq_err, 1600);
+}
+
 static void __init dove_dt_init(void)
 {
 	pr_info("Dove 88AP510 SoC\n");
@@ -70,7 +99,7 @@ static void __init dove_dt_init(void)
 	dove_of_clk_init();
 
 	/* Internal devices not ported to DT yet */
-	dove_ge00_init(&dove_dt_ge00_data);
+	dove_legacy_ge00_init();
 	dove_pcie_init(1, 1);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.2.5

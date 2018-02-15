From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 15 Feb 2018 11:02:08 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
Message-ID: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator setup is suboptimal on H2 Stout too. The Stout newly has
two DA9210 regulators, so the quirk is extended to handle another
DA9210 at i2c address 0x70.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
V2: - Handle another DA9210 at 0x70
    - Drop explicit board list from the leading comment in the file
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 44438f344dc8..8324f9820fde 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -1,9 +1,9 @@
 /*
  * R-Car Generation 2 da9063/da9210 regulator quirk
  *
- * The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
- * da9210 regulators.  Both regulators have their interrupt request lines tied
- * to the same interrupt pin (IRQ2) on the SoC.
+ * Certain Gen2 development boards have an da9063 and one or more da9210
+ * regulators. All of these regulators have their interrupt request lines
+ * tied to the same interrupt pin (IRQ2) on the SoC.
  *
  * After cold boot or da9063-induced restart, both the da9063 and da9210 seem
  * to assert their interrupt request lines.  Hence as soon as one driver
@@ -59,6 +59,10 @@ static struct i2c_msg da9xxx_msgs[2] = {
 		.addr = 0x68,
 		.len = ARRAY_SIZE(da9210_irq_clr),
 		.buf = da9210_irq_clr,
+	}, {
+		.addr = 0x70,
+		.len = ARRAY_SIZE(da9210_irq_clr),
+		.buf = da9210_irq_clr,
 	},
 };
 
@@ -85,7 +89,8 @@ static int regulator_quirk_notify(struct notifier_block *nb,
 	dev_dbg(dev, "Detected %s\n", client->name);
 
 	if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
-	    (client->addr == 0x68 && !strcmp(client->name, "da9210"))) {
+	    (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
+	    (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
 		int ret;
 
 		dev_info(&client->dev, "clearing da9063/da9210 interrupts\n");
@@ -118,6 +123,7 @@ static int __init rcar_gen2_regulator_quirk(void)
 
 	if (!of_machine_is_compatible("renesas,koelsch") &&
 	    !of_machine_is_compatible("renesas,lager") &&
+	    !of_machine_is_compatible("renesas,stout") &&
 	    !of_machine_is_compatible("renesas,gose"))
 		return -ENODEV;
 
-- 
2.15.1

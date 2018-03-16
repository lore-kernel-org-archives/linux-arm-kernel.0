From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:32 +0100
Subject: [PATCH 10/14] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <ff938cd14d67a7040258759b46e3d5b4548f4c2c.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Regulator setup is suboptimal on H2 Stout too. The Stout newly has
two DA9210 regulators, so the quirk is extended to handle another
DA9210 at i2c address 0x70.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 23 +++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 44438f344dc8..27fb3a5ec73e 100644
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
@@ -50,7 +50,7 @@ static void __iomem *irqc;
 static u8 da9063_irq_clr[] = { DA9063_REG_IRQ_MASK_A, 0xff, 0xff, 0xff, 0xff };
 static u8 da9210_irq_clr[] = { DA9210_REG_MASK_A, 0xff, 0xff };
 
-static struct i2c_msg da9xxx_msgs[2] = {
+static struct i2c_msg da9xxx_msgs[3] = {
 	{
 		.addr = 0x58,
 		.len = ARRAY_SIZE(da9063_irq_clr),
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
 
@@ -85,11 +89,15 @@ static int regulator_quirk_notify(struct notifier_block *nb,
 	dev_dbg(dev, "Detected %s\n", client->name);
 
 	if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
-	    (client->addr == 0x68 && !strcmp(client->name, "da9210"))) {
-		int ret;
+	    (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
+	    (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
+		int ret, len;
+
+		/* There are two DA9210 on Stout, one on the other boards. */
+		len = of_machine_is_compatible("renesas,stout") ? 3 : 2;
 
 		dev_info(&client->dev, "clearing da9063/da9210 interrupts\n");
-		ret = i2c_transfer(client->adapter, da9xxx_msgs, ARRAY_SIZE(da9xxx_msgs));
+		ret = i2c_transfer(client->adapter, da9xxx_msgs, len);
 		if (ret != ARRAY_SIZE(da9xxx_msgs))
 			dev_err(&client->dev, "i2c error %d\n", ret);
 	}
@@ -118,6 +126,7 @@ static int __init rcar_gen2_regulator_quirk(void)
 
 	if (!of_machine_is_compatible("renesas,koelsch") &&
 	    !of_machine_is_compatible("renesas,lager") &&
+	    !of_machine_is_compatible("renesas,stout") &&
 	    !of_machine_is_compatible("renesas,gose"))
 		return -ENODEV;
 
-- 
2.11.0

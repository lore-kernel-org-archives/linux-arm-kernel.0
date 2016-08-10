From: j-keerthy@ti.com (Keerthy)
Date: Wed, 10 Aug 2016 18:22:24 +0530
Subject: [PATCH v7 4/5] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
In-Reply-To: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
References: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1470833545-29462-5-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mfd_add_devices enables parsing device tree nodes without compatibles
for regulators and gpio modules. Replace of_platform_populate with
mfd_add_devices. mfd_cell currently is populated with regulators,
gpio and powerbutton.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tps65218.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 9bca1b1..13834a0 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -33,6 +33,18 @@
 
 #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
 
+static const struct mfd_cell tps65218_cells[] = {
+	{
+		.name = "tps65218-pwrbutton",
+		.of_compatible = "ti,tps65218-pwrbutton",
+	},
+	{
+		.name = "tps65218-gpio",
+		.of_compatible = "ti,tps65218-gpio",
+	},
+	{ .name = "tps65218-regulator", },
+};
+
 /**
  * tps65218_reg_write: Write a single tps65218 register.
  *
@@ -245,8 +257,10 @@ static int tps65218_probe(struct i2c_client *client,
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
 
-	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
-				   &client->dev);
+	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
+			      ARRAY_SIZE(tps65218_cells), NULL, 0,
+			      regmap_irq_get_domain(tps->irq_data));
+
 	if (ret < 0)
 		goto err_irq;
 
-- 
1.9.1

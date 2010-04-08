From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 8 Apr 2010 06:11:39 -0400
Subject: [PATCH] mfd: enable onkey on max8925
Message-ID: <mailman.459.1274252240.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable onkey feature in max8925 driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/max8925-core.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index f621bce..9c5a09d 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -90,6 +90,24 @@ static struct mfd_cell rtc_devs[] = {
 	},
 };

+static struct resource onkey_resources[] = {
+	{
+		.name	= "max8925-onkey",
+		.start	= MAX8925_IRQ_GPM_SW_3SEC,
+		.end	= MAX8925_IRQ_GPM_SW_3SEC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell onkey_devs[] = {
+	{
+		.name		= "max8925-onkey",
+		.num_resources	= 1,
+		.resources	= &onkey_resources[0],
+		.id		= -1,
+	},
+};
+
 #define MAX8925_REG_RESOURCE(_start, _end)	\
 {						\
 	.start	= MAX8925_##_start,		\
@@ -596,6 +614,15 @@ int __devinit max8925_device_init(struct
max8925_chip *chip,
 		dev_err(chip->dev, "Failed to add rtc subdev\n");
 		goto out;
 	}
+
+	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
+			      ARRAY_SIZE(onkey_devs),
+			      &onkey_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add onkey subdev\n");
+		goto out;
+	}
+
 	if (pdata && pdata->regulator[0]) {
 		ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
 				      ARRAY_SIZE(regulator_devs),
-- 
1.5.6.5

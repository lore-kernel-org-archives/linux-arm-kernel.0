From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 12 Aug 2010 11:59:33 +0800
Subject: [PATCH 1/5] mfd: add codec resource into 88pm860x driver
Message-ID: <mailman.167.1281707726.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add codec IRQ resources that are used in 88pm860x codec driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 1580f1f..fba00b4 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -158,6 +158,43 @@ static struct mfd_cell onkey_devs[] = {
 	},
 };

+static struct resource codec_resources[] = {
+	{
+		/* Headset microphone insertion or removal */
+		.name		= "micin",
+		.start		= PM8607_IRQ_MICIN,
+		.end		= PM8607_IRQ_MICIN,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Hook-switch press or release */
+		.name		= "hook",
+		.start		= PM8607_IRQ_HOOK,
+		.end		= PM8607_IRQ_HOOK,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Headset insertion or removal */
+		.name		= "headset",
+		.start		= PM8607_IRQ_HEADSET,
+		.end		= PM8607_IRQ_HEADSET,
+		.flags		= IORESOURCE_IRQ,
+	}, {
+		/* Audio short */
+		.name		= "audio-short",
+		.start		= PM8607_IRQ_AUDIO_SHORT,
+		.end		= PM8607_IRQ_AUDIO_SHORT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct mfd_cell codec_devs[] = {
+	{
+		.name		= "88pm860x-codec",
+		.num_resources	= 4,
+		.resources	= &codec_resources[0],
+		.id		= -1,
+	},
+};
+
 static struct resource regulator_resources[] = {
 	PM8607_REG_RESOURCE(BUCK1, BUCK1),
 	PM8607_REG_RESOURCE(BUCK2, BUCK2),
@@ -695,6 +732,13 @@ static void __devinit device_8607_init(struct
pm860x_chip *chip,
 		goto out_dev;
 	}

+	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
+			      ARRAY_SIZE(codec_devs),
+			      &codec_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add codec subdev\n");
+		goto out_dev;
+	}
 	return;
 out_dev:
 	mfd_remove_devices(chip->dev);
-- 
1.5.6.5

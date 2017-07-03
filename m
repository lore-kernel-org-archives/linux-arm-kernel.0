From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 3 Jul 2017 11:16:08 +0200
Subject: [PATCH v2 7/7] [media] ov9650: add analog power supply and clock
 gating
In-Reply-To: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
References: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1499073368-31905-8-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional analog power supply and clock gating.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/i2c/ov9650.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
index 9ff0782..56b1eb3 100644
--- a/drivers/media/i2c/ov9650.c
+++ b/drivers/media/i2c/ov9650.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/ratelimit.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/videodev2.h>
@@ -374,6 +375,7 @@ struct ov965x {
 	/* External master clock frequency */
 	unsigned long mclk_frequency;
 	struct clk *clk;
+	struct regulator *avdd;
 
 	/* Protects the struct fields below */
 	struct mutex lock;
@@ -943,13 +945,31 @@ static void ov965x_gpio_set(struct gpio_desc *gpio, int val)
 
 static void __ov965x_set_power(struct ov965x *ov965x, int on)
 {
+	int ret;
+
 	if (on) {
+		/* Bring up the power supply */
+		ret = regulator_enable(ov965x->avdd);
+		if (ret)
+			dev_warn(&ov965x->client->dev,
+				 "Failed to enable analog power (%d)\n", ret);
+		msleep(25);
+		/* Enable clock */
+		ret = clk_prepare_enable(ov965x->clk);
+		if (ret)
+			dev_warn(&ov965x->client->dev,
+				 "Failed to enable clock (%d)\n", ret);
+		msleep(25);
+
 		ov965x_gpio_set(ov965x->gpios[GPIO_PWDN], 0);
 		ov965x_gpio_set(ov965x->gpios[GPIO_RST], 0);
 		msleep(25);
 	} else {
 		ov965x_gpio_set(ov965x->gpios[GPIO_RST], 1);
 		ov965x_gpio_set(ov965x->gpios[GPIO_PWDN], 1);
+
+		clk_disable_unprepare(ov965x->clk);
+		regulator_disable(ov965x->avdd);
 	}
 
 	ov965x->streaming = 0;
@@ -1969,6 +1989,12 @@ static int ov965x_probe(struct i2c_client *client,
 			devm_gpiod_get_optional(&client->dev, "pwdn",
 						GPIOD_OUT_HIGH);
 
+		ov965x->avdd = devm_regulator_get(&client->dev, "avdd");
+		if (IS_ERR(ov965x->avdd)) {
+			dev_err(&client->dev, "Could not get analog regulator\n");
+			return PTR_ERR(ov965x->avdd);
+		}
+
 		ov965x->clk = devm_clk_get(&client->dev, NULL);
 		if (IS_ERR(ov965x->clk)) {
 			dev_err(&client->dev, "Could not get clock\n");
-- 
1.9.1

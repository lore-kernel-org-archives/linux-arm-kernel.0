From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 17:17:09 +0530
Subject: [PATCH 4/6] mfd: 88pm800: Enable 32KHZ XO low jitter clock out
In-Reply-To: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436442431-3471-5-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM800/860 device supports output of 32KHz low jitter XO clock
out on
 - CLK32K3 - for 88pm800
 - CLK32K2 - for 88pm860

Both devices share same register bit-field to configure this.

This patch adds support to enable this clock out, using DT property
"marvell,88pm800-32khz-xolj-out-en"

Since this configuration is controlled through DT property, it is
safe to put it as common code.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c       | 13 +++++++++++++
 include/linux/mfd/88pm80x.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 80a1bc1..8930fd8 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -526,6 +526,19 @@ static int pm800_init_config(struct pm80x_chip *chip, struct device_node *np)
 	int ret;
 	unsigned int val;
 
+	/* Enable 32Khz-out-3 low jitter XO_LJ = 1 in pm800
+	 * Enable 32Khz-out-2 low jitter XO_LJ = 1 in pm860
+	 * they are the same bit
+	 */
+	if (of_property_read_bool(np, "marvell,88pm800-32khz-xolj-out-en")) {
+		ret = regmap_update_bits(chip->regmap,
+					PM800_LOW_POWER2,
+					PM800_XO_LJ_OUT_EN,
+					PM800_XO_LJ_OUT_EN);
+		if (ret)
+			goto error;
+	}
+
 	switch (chip->type) {
 	case CHIP_PM800:
 	case CHIP_PM805:
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 2ef62af..fb916f1 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -88,6 +88,7 @@ enum {
 /* Referance and low power registers */
 #define PM800_LOW_POWER1		(0x20)
 #define PM800_LOW_POWER2		(0x21)
+#define PM800_XO_LJ_OUT_EN		BIT(5)
 
 #define PM800_LOW_POWER_CONFIG3		(0x22)
 #define PM800_LDOBK_FREEZE		BIT(7)
-- 
1.9.1

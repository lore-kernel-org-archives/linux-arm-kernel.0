From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 17:17:11 +0530
Subject: [PATCH 6/6] mfd: 88pm800: Add support for configuration of dual phase
 on BUCK1
In-Reply-To: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436442431-3471-7-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 device supports dual phase mode on BUCK1 output.
In normal usecase, BUCK1A and BUCK1B operates independently with 3A
capacity. And they both can work as a dual phase providing 6A capacity.

This patch adds support to enable dual phase mode, using DT property
"marvell,88pm860-buck1-dualphase-en"

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mfd/88pm800.c       | 11 +++++++++++
 include/linux/mfd/88pm80x.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 8930fd8..a2ef0c7 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -556,6 +556,17 @@ static int pm800_init_config(struct pm80x_chip *chip, struct device_node *np)
 		if (ret)
 			goto error;
 
+		/* enable buck1 dual phase mode*/
+		if (of_property_read_bool(np,
+					"marvell,88pm860-buck1-dualphase-en")) {
+			ret = regmap_update_bits(chip->subchip->regmap_power,
+						PM860_BUCK1_MISC,
+						BUCK1_DUAL_PHASE_SEL,
+						BUCK1_DUAL_PHASE_SEL);
+			if (ret)
+				goto error;
+		}
+
 		/*
 		 * Set buck2 and buck4 driver selection to be full.
 		 * The default value is 0, for full drive support
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index fb916f1..b40d15f 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -293,6 +293,9 @@ enum {
 #define PM860_BUCK4_MISC2		(0x82)
 #define PM860_BUCK4_FULL_DRV		BIT(2)
 
+#define PM860_BUCK1_MISC		(0x8E)
+#define BUCK1_DUAL_PHASE_SEL		BIT(2)
+
 struct pm80x_rtc_pdata {
 	int		vrtc;
 	int		rtc_wakeup;
-- 
1.9.1

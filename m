From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 May 2016 14:34:20 +0200
Subject: [RFC v2 07/13] power: pwrseq: simple: Add support for toggling
 regulator
In-Reply-To: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices need real hard-reset by cutting the power.  During power
sequence turn off and on the regulator, if it is provided.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 +
 drivers/power/pwrseq/pwrseq_simple.c               | 50 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index ce0e76749671..176ff831e7f1 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -16,6 +16,7 @@ Optional properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).
+- ext-supply : External regulator supply
 
 Example:
 
@@ -24,4 +25,5 @@ Example:
 		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		clocks = <&clk_32768_ck>;
 		clock-names = "ext_clock";
+		ext-supply = <&buck8>;
 	}
diff --git a/drivers/power/pwrseq/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
index ab0098412690..4d5ea53d3ead 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -16,7 +16,9 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/pwrseq.h>
+#include <linux/delay.h>
 
 #include <linux/mmc/host.h>
 
@@ -25,6 +27,7 @@ struct mmc_pwrseq_simple {
 	bool clk_enabled;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	struct regulator *ext_reg;
 };
 
 #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
@@ -62,6 +65,13 @@ static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
+	if (pwrseq->ext_reg) {
+		int err;
+
+		err = regulator_enable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
+
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
@@ -75,6 +85,13 @@ static void mmc_pwrseq_simple_power_off(struct pwrseq *_pwrseq)
 		clk_disable_unprepare(pwrseq->ext_clk);
 		pwrseq->clk_enabled = false;
 	}
+
+	if (pwrseq->ext_reg) {
+		int err;
+
+		err = regulator_disable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
 }
 
 static const struct pwrseq_ops mmc_pwrseq_simple_ops = {
@@ -102,6 +119,32 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return PTR_ERR(pwrseq->ext_clk);
 
+	/* FIXME: regulator_get_exclusive? */
+	pwrseq->ext_reg = devm_regulator_get_optional(dev, "ext");
+	if (IS_ERR(pwrseq->ext_reg)) {
+		if (PTR_ERR(pwrseq->ext_reg) == -ENODEV)
+			pwrseq->ext_reg = NULL;
+		else
+			return PTR_ERR(pwrseq->ext_reg);
+	} else {
+		int err;
+		/*
+		 * Be sure that regulator is off, before the driver will start
+		 * power sequence. It is likely that regulator is on by default
+		 * and it without toggling it here, it would be disabled much
+		 * later by the core.
+		 */
+
+		err = regulator_enable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+
+		/* FIXME: handle this in a more sensible way */
+		mdelay(10);
+
+		err = regulator_disable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
+
 	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
 							GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios) &&
@@ -124,6 +167,13 @@ static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
 
 	pwrseq_unregister(&pwrseq->pwrseq);
 
+	if (pwrseq->ext_reg) {
+		int err;
+
+		err = regulator_disable(pwrseq->ext_reg);
+		WARN_ON_ONCE(err);
+	}
+
 	return 0;
 }
 
-- 
1.9.1

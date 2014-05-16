From: Ying.Liu@freescale.com (Liu Ying)
Date: Fri, 16 May 2014 13:11:08 +0800
Subject: [PATCH v3] pwm: i.MX: Avoid sample FIFO overflow for i.MX PWM version2
Message-ID: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX PWM version2 is embedded in several i.MX SoCs,
such as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit
sample FIFOs in this IP, each of which determines the duty
period of a PWM waveform in one full cycle.  The IP spec
mentions that we should not write a fourth sample because
the FIFOs will become full and trigger a FIFO write error
(FWE) which will prevent the PWM from starting once it is
enabled.  In order to avoid any sample FIFO overflow issue,
this patch clears all sample FIFOs or waits for a rollover
event to consume a FIFO slot when necessary.  In this way,
only the first FIFO slot will be loaded at most.

Note that the PWM controller will not generate any rollover
event if the duty period is zero.  This makes the logic a
bit complicated to determine if we clear the sample FIFOs
or wait for a rollover event.

The FIFO overflow issue can be reproduced by the following
commands on the i.MX6SL EVK platform, assuming we use PWM2
for the debug LED which is driven by the pin HSIC_STROBE
and the maximal brightness is 255.
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 255 > /sys/class/leds/user/brightness
Here, FWE happens(PWMSR register reads 0x58) and the LED
can not be lighten.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: linux-pwm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v2->v3:
* Wait for a rollover event before configuration when PWM
  is active with non-zero duty period.  And, update commit
  message for that.
* Fix some typos in commit head and message(fifo -> FIFO,
  pwm -> PWM, etc).
* Cc linux-kernel at vger.kernel.org.

v1->v2:
* To address Lothar Wa?mann's comment, add a timeout mechanism
  instead of endless polling the SWR bit to be cleared by the
  hardware.

 drivers/pwm/pwm-imx.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d797c7b..204f4a9 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -14,7 +14,9 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -30,6 +32,7 @@
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
 
 #define MX3_PWMCR                 0x00    /* PWM Control Register */
+#define MX3_PWMIR                 0x08    /* PWM Interrupt Register */
 #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
 #define MX3_PWMPR                 0x10    /* PWM Period Register */
 #define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
@@ -38,7 +41,12 @@
 #define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
+#define MX3_PWMCR_SWR		  (1 << 3)
 #define MX3_PWMCR_EN              (1 << 0)
+#define MX3_PWMSR_ROV             (1 << 4)
+#define MX3_PWMIR_RIE             (1 << 1)
+
+#define MX3_PWM_SWR_LOOP	  5
 
 struct imx_chip {
 	struct clk	*clk_per;
@@ -48,6 +56,9 @@ struct imx_chip {
 
 	struct pwm_chip	chip;
 
+	unsigned int	irq;
+	struct completion rov_complete;
+
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
@@ -99,12 +110,33 @@ static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
 	writel(val, imx->mmio_base + MX1_PWMC);
 }
 
+/* Software reset clears all sample FIFOs. */
+static void imx_pwm_software_reset_v2(struct pwm_chip *chip)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	struct device *dev = chip->dev;
+	int wait_count = 0;
+	u32 cr;
+
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		usleep_range(200, 1000);
+		cr = readl(imx->mmio_base + MX3_PWMCR);
+	} while ((cr & MX3_PWMCR_SWR) &&
+		 (wait_count++ < MX3_PWM_SWR_LOOP));
+
+	if (cr & MX3_PWMCR_SWR)
+		dev_warn(dev, "software reset timeout\n");
+}
+
 static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	struct device *dev = chip->dev;
 	unsigned long long c;
 	unsigned long period_cycles, duty_cycles, prescale;
+	bool enable = test_bit(PWMF_ENABLED, &pwm->flags);
 	u32 cr;
 
 	c = clk_get_rate(imx->clk_per);
@@ -128,6 +160,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	else
 		period_cycles = 0;
 
+	if (!enable || duty_cycles == 0)
+		imx_pwm_software_reset_v2(chip);
+	else if (readl(imx->mmio_base + MX3_PWMSAR))
+		/* No rollover irq generated if duty peroid is zero. */
+		if (!wait_for_completion_timeout(&imx->rov_complete, HZ))
+			dev_warn(dev, "timeout when waiting for rollover irq\n");
+
 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
@@ -135,27 +174,55 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
 		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
 
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (enable)
 		cr |= MX3_PWMCR_EN;
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
+	if (enable && duty_cycles)
+		/* No rollover irq generated if duty peroid is zero. */
+		writel(MX3_PWMIR_RIE, imx->mmio_base + MX3_PWMIR);
+
 	return 0;
 }
 
 static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	bool enabled;
 	u32 val;
 
 	val = readl(imx->mmio_base + MX3_PWMCR);
 
+	enabled = val & MX3_PWMCR_EN;
+
 	if (enable)
 		val |= MX3_PWMCR_EN;
 	else
 		val &= ~MX3_PWMCR_EN;
 
 	writel(val, imx->mmio_base + MX3_PWMCR);
+
+	if (!enable)
+		imx_pwm_software_reset_v2(chip);
+	else if (!enabled && readl(imx->mmio_base + MX3_PWMSAR))
+		/* No rollover irq generated if duty period is zero. */
+		writel(MX3_PWMIR_RIE, imx->mmio_base + MX3_PWMIR);
+}
+
+static irqreturn_t imx_pwm_irq_handler_v2(int irq, void *data)
+{
+	struct imx_chip *imx = data;
+	u32 val;
+
+	/* disable rollover interrupt */
+	val = readl(imx->mmio_base + MX3_PWMIR);
+	val &= ~MX3_PWMIR_RIE;
+	writel(val, imx->mmio_base + MX3_PWMIR);
+
+	complete(&imx->rov_complete);
+
+	return IRQ_HANDLED;
 }
 
 static int imx_pwm_config(struct pwm_chip *chip,
@@ -209,16 +276,19 @@ struct imx_pwm_data {
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
+	irqreturn_t (*irq_handler)(int irq, void *data);
 };
 
 static struct imx_pwm_data imx_pwm_data_v1 = {
 	.config = imx_pwm_config_v1,
 	.set_enable = imx_pwm_set_enable_v1,
+	.irq_handler = NULL,
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
 	.config = imx_pwm_config_v2,
 	.set_enable = imx_pwm_set_enable_v2,
+	.irq_handler = imx_pwm_irq_handler_v2,
 };
 
 static const struct of_device_id imx_pwm_dt_ids[] = {
@@ -272,6 +342,23 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->config = data->config;
 	imx->set_enable = data->set_enable;
 
+	init_completion(&imx->rov_complete);
+
+	imx->irq = platform_get_irq(pdev, 0);
+	if (imx->irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return imx->irq;
+	}
+
+	if (data->irq_handler) {
+		ret = devm_request_irq(&pdev->dev, imx->irq, data->irq_handler,
+				       0, "imx-pwm", imx);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request irq\n");
+			return ret;
+		}
+	}
+
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
1.7.9.5

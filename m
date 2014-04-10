From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 10 Apr 2014 17:23:49 +0800
Subject: [PATCH v2] pwm: i.MX: Avoid sample fifo overflow for i.MX pwm version2
Message-ID: <1397121829-19331-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX pwm version2 is embedded in several i.MX SoCs, such
as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit sample
fifos in this IP, each of which determines the duty period
of a PWM waveform in one full cycle.  The IP spec mentions
that we should not write a fourth sample because the fifo
will become full and trigger a fifo write error(FWE) which
will prevent the PWM from starting once it is enabled.  In
order to avoid any sample fifo overflow issue, this patch
does software reset to clear all the sample fifos in the
very beginning of the pwm configuration function.

The fifo overflow issue can be reproduced by the following
commands on the i.MX6SL evk platform, assuming we use pwm2
for the debug LED which is driven by the pin HSIC_STROBE
and the maximal brightness is 255.
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 255 > /sys/class/leds/user/brightness
Here, FWE happens(PWMSR register reads 0x58) and the LED
can not be lighten.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: linux-pwm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v1->v2:
* To address Lothar Wa?mann's comment, add a timeout mechanism
  instead of endless polling the SWR bit to be cleared by the
  hardware.

 drivers/pwm/pwm-imx.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..8929b0d 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
@@ -38,8 +39,11 @@
 #define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
+#define MX3_PWMCR_SWR		  (1 << 3)
 #define MX3_PWMCR_EN              (1 << 0)
 
+#define MX3_PWM_SWR_LOOP	  5
+
 struct imx_chip {
 	struct clk	*clk_per;
 	struct clk	*clk_ipg;
@@ -103,10 +107,23 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	struct device *dev = chip->dev;
 	unsigned long long c;
 	unsigned long period_cycles, duty_cycles, prescale;
+	int wait_count = 0;
 	u32 cr;
 
+	/* do software reset in case fifo overflows */
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		usleep_range(200, 1000);
+		cr = readl(imx->mmio_base + MX3_PWMCR);
+	} while ((cr & MX3_PWMCR_SWR) &&
+		 (wait_count++ < MX3_PWM_SWR_LOOP));
+
+	if (cr & MX3_PWMCR_SWR)
+		dev_warn(dev, "software reset timeout\n");
+
 	c = clk_get_rate(imx->clk_per);
 	c = c * period_ns;
 	do_div(c, 1000000000);
-- 
1.7.9.5

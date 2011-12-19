From: jason.chen@linaro.org (Jason Chen)
Date: Mon, 19 Dec 2011 11:23:28 +0800
Subject: [PATCH] ARM:imx:fix pwm period value
Message-ID: <1324265008-22866-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to imx pwm RM, the real period value should be
PERIOD value in PWMPR plus 2.

PWMO (Hz) = PCLK(Hz) / (period +2)

Signed-off-by: Jason Chen <jason.chen@linaro.org>
---
 arch/arm/plat-mxc/pwm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
index 6b78490..0b112d2 100644
--- a/arch/arm/plat-mxc/pwm.c
+++ b/arch/arm/plat-mxc/pwm.c
@@ -78,6 +78,15 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
 		do_div(c, period_ns);
 		duty_cycles = c;
 
+		/*
+		 * according to imx pwm RM, the real period value should be
+		 * PERIOD value in PWMPR plus 2.
+		 */
+		if (period_cycles > 2)
+			period_cycles -= 2;
+		else
+			period_cycles = 0;
+
 		writel(duty_cycles, pwm->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, pwm->mmio_base + MX3_PWMPR);
 
-- 
1.7.4.1

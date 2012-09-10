From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 10 Sep 2012 10:59:36 +0200
Subject: [PATCH 6/7] pwm: i.MX: use per clock unconditionally
In-Reply-To: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
References: <1347267577-3296-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347267577-3296-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX PWM module has two clocks: The ipg clock and the ipg highfreq
(peripheral) clock. The ipg clock has to be enabled for this hardware
to work. The actual PWM output can either be driven by the ipg clock
or the ipg highfreq. The ipg highfreq has the advantage that it runs
even when the SoC is in low power modes.
Use the always running clock also on i.MX25.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 drivers/pwm/pwm-imx.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index b4e0ad3..852de6c 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -132,16 +132,11 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 
 	cr = MX3_PWMCR_PRESCALER(prescale) |
 		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		MX3_PWMCR_DBGEN;
+		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
 
 	if (imx->enabled)
 		cr |= MX3_PWMCR_EN;
 
-	if (cpu_is_mx25())
-		cr |= MX3_PWMCR_CLKSRC_IPG;
-	else
-		cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
-
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	return 0;
-- 
1.7.10.4

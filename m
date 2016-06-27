From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 27 Jun 2016 09:09:56 -0400
Subject: [PATCH v2 2/3] pwm: lpc32xx: Add support for PWM_PIN_LEVEL bit
 configuration
In-Reply-To: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <1467032997-5340-3-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Provide support to configure the pin output
(i.e. PWM_PIN_LEVEL bit) when the PWM is disabled.

Note:
When the LPC32xx PWM is disabled, both options of pin
output high and low level values are valid; however this
particular controller does not have polarity control.

Refer to the LPC32x0 User Manual [1], for details.

[1] http://www.nxp.com/documents/user_manual/UM10326.pdf

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
* New patch in version 2.

 drivers/pwm/pwm-lpc32xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index a9b3cff..d1bd901 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -130,9 +130,13 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* When PWM is disable, configure the output to the default value */
+	/* When PWM is disable, configure the output correctly */
 	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
-	val &= ~PWM_PIN_LEVEL;
+	if (device_property_read_bool(&pdev->dev,
+				      "nxp,pwm-disabled-level-high"))
+		val |= PWM_PIN_LEVEL;
+	else
+		val &= ~PWM_PIN_LEVEL;
 	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
 
 	platform_set_drvdata(pdev, lpc32xx);
-- 
1.8.3.1

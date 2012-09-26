From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 26 Sep 2012 03:17:02 +0100
Subject: [PATCH] ARM: pxa: hx4700: Fix backlight PWM device number
In-Reply-To: <5062652A.8070603@yahoo.com>
References: <5062652A.8070603@yahoo.com>
Message-ID: <5062659E.6030104@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes to PXA PWM support changed the PXA27X PWM device
numbering scheme.

The linux-3.5 PXA PWM driver followed the hardware numbering scheme for
the 4 PWMs, while the linux-3.6-rc1 PXA PWM driver has adopted a linear
numbering scheme:

Address		Hardware	3.5 pwm_id	3.6-rc1 pwm_id
0x40b00000	PWM0		0		0
0x40b00010	PWM2		2		1
0x40c00000	PWM1		1		2
0x40c00010	PWM3		3		3

The hx4700 backlight uses PWM1 at 0x40c00000. Consequently the pwm_id
must be changed from 1 to 2.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
---
  arch/arm/mach-pxa/hx4700.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index e631198..3720f99 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -556,7 +556,7 @@ static struct platform_device hx4700_lcd = {
   */

  static struct platform_pwm_backlight_data backlight_data = {
-	.pwm_id         = 1,
+	.pwm_id         = 2,	/* PWM1 */
  	.max_brightness = 200,
  	.dft_brightness = 100,
  	.pwm_period_ns  = 30923,
-- 
1.7.8.6

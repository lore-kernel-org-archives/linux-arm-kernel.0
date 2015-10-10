From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 10 Oct 2015 17:11:34 +0200
Subject: [PATCH v3 pre-03/12] pwm: rcar: make use of pwm_is_enabled()
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1444489894-14035-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced a
new function to test whether a PWM device is enabled or not without
manipulating PWM internal fields.
Hiding this is necessary if we want to smoothly move to the atomic PWM
config approach without impacting PWM drivers.
Fix this driver to use pwm_is_enabled() instead of directly accessing the
->flags field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Hi Thierry,

I noticed you applied a few patches adding new PWM drivers in your
pwm-next tree, and one of them is directly testing the PWMF_ENABLED
flag which is removed by patch 3 of this series, which means you have to
apply this patch before patch 3.

I can resend the whole series if you want, but, unless you have a strong
reason to refuse it, I'd really like to get those changes in, so that I
don't have to rebase and fix the series each time a new driver is added.

Best Regards,

Boris

 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 6e99a63..70899c9 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -157,7 +157,7 @@ static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return div;
 
 	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
+	if (!pwm_is_enabled(pwm) && !duty_ns)
 		return 0;
 
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
-- 
2.1.4

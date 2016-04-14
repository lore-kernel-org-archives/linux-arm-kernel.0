From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:30 +0200
Subject: [PATCH v5 10/24] backlight: lp8788: explicitly apply PWM config
 extracted from pwm_args
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call pwm_apply_args() just after requesting the PWM device so that the
polarity and period are initialized according to the information provided
in pwm_args.

This is an intermediate state, and pwm_apply_args() should be dropped as
soon as the atomic PWM infrastructure is in place and the driver makes
use of it.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/video/backlight/lp8788_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index 5d583d7..cf869ec 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -145,6 +145,12 @@ static void lp8788_pwm_ctrl(struct lp8788_bl *bl, int br, int max_br)
 		}
 
 		bl->pwm = pwm;
+
+		/*
+		 * FIXME: pwm_apply_args() should be removed when switching to
+		 * the atomic PWM API.
+		 */
+		pwm_apply_args(pwm);
 	}
 
 	pwm_config(bl->pwm, duty, period);
-- 
2.5.0

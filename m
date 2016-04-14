From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:32 +0200
Subject: [PATCH v5 12/24] backlight: lm3630a: explicitly apply PWM config
 extracted from pwm_args
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-13-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/video/backlight/lm3630a_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 3d16bd6..60d6c2a 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -424,6 +424,12 @@ static int lm3630a_probe(struct i2c_client *client,
 			dev_err(&client->dev, "fail : get pwm device\n");
 			return PTR_ERR(pchip->pwmd);
 		}
+
+		/*
+		 * FIXME: pwm_apply_args() should be removed when switching to
+		 * the atomic PWM API.
+		 */
+		pwm_apply_args(pchip->pwmd);
 	}
 
 	/* interrupt enable  : irq 0 is not allowed */
-- 
2.5.0

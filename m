From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:34 +0200
Subject: [PATCH v5 14/24] input: misc: pwm-beeper: explicitly apply PWM config
 extracted from pwm_args
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-15-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/input/misc/pwm-beeper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index f2261ab..8d71332 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -87,6 +87,12 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(beeper->pwm);
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
-- 
2.5.0

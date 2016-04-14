From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:36 +0200
Subject: [PATCH v5 16/24] ARM: explicitly apply PWM config extracted from
 pwm_args
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1460661464-11216-17-git-send-email-boris.brezillon@free-electrons.com>
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
 arch/arm/mach-s3c24xx/mach-rx1950.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 774c982..25a139b 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -496,6 +496,12 @@ static int rx1950_backlight_init(struct device *dev)
 		return PTR_ERR(lcd_pwm);
 	}
 
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(lcd_pwm);
+
 	rx1950_lcd_power(1);
 	rx1950_bl_power(1);
 
-- 
2.5.0

From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 10 May 2010 23:43:14 +0300
Subject: [PATCH 5/5] rx1950: configure GPG13-15 as input before suspend
In-Reply-To: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
References: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1273524194-13346-6-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to datasheet GPG13-15 must be configured as input in NAND
boot mode, otherwise device will not be able to wake up

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/pm.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/pm.c b/arch/arm/mach-s3c2410/pm.c
index 6a61486..725636f 100644
--- a/arch/arm/mach-s3c2410/pm.c
+++ b/arch/arm/mach-s3c2410/pm.c
@@ -79,6 +79,17 @@ static void s3c2410_pm_prepare(void)
 	if ( machine_is_aml_m5900() )
 		s3c2410_gpio_setpin(S3C2410_GPF(2), 1);
 
+	if (machine_is_rx1950()) {
+		/* According to S3C2442 user's manual, page 7-17,
+		 * when the system is operating in NAND boot mode,
+		 * the hardware pin configuration - EINT[23:21] ???
+		 * must be set as input for starting up after
+		 * wakeup from sleep mode
+		 */
+		s3c_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPIO_INPUT);
+		s3c_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPIO_INPUT);
+		s3c_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPIO_INPUT);
+	}
 }
 
 static int s3c2410_pm_resume(struct sys_device *dev)
-- 
1.7.0.4

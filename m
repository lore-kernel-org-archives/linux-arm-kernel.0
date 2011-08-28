From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Aug 2011 02:46:18 +0200
Subject: [PATCH 3/5] ARM: Samsung: pwm: Exclude timer 3 on S3C64xx if generic
 time is enabled.
Message-ID: <mailman.112.1314794131.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch excludes PWM timer 3 from timers supported with the PWM driver
on S3C64xx when generic time is enabled.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/pwm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index 27b5353..8f0fad1 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -273,6 +273,13 @@ static int s3c_pwm_probe(struct platform_device *pdev)
 	unsigned int id = pdev->id;
 	int ret;
 
+#ifdef CONFIG_S3C64XX_GENERIC_CLOCKEVENTS
+	if (id == 3 &&
+	    platform_get_device_id(pdev)->driver_data == TYPE_S3C64XX) {
+		dev_err(dev, "TIMER3 is currently not supported\n");
+		return -ENXIO;
+	}
+#endif
 	if (id == 4) {
 		dev_err(dev, "TIMER4 is currently not supported\n");
 		return -ENXIO;
-- 
1.7.6.1

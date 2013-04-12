From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:30 +0200
Subject: [PATCH v5 14/14] clocksource: samsung-pwm: Prepare for
 clocksource_of_init
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-15-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for clocksource instantiation using
clocksource_of_init, by declaring OF clocksources with
CLOCKSOURCE_OF_DECLARE() macro.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index b816b65..a12ee08 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -590,12 +590,13 @@ static void __init samsung_timer_resources(void)
 	}
 }
 
-void __init samsung_pwm_clocksource_init(struct platform_device *pdev)
+static void __init __samsung_pwm_clocksource_init(
+			struct platform_device *pdev, struct device_node *np)
 {
 	u8 mask;
 	int channel;
 
-	pwm = samsung_pwm_get(pdev, NULL);
+	pwm = samsung_pwm_get(pdev, np);
 	if (IS_ERR(pwm))
 		panic("failed to get PWM device");
 
@@ -615,3 +616,21 @@ void __init samsung_pwm_clocksource_init(struct platform_device *pdev)
 	samsung_clockevent_init();
 	samsung_clocksource_init();
 }
+
+static void __init samsung_pwm_clocksource_init_of(struct device_node *np)
+{
+	__samsung_pwm_clocksource_init(NULL, np);
+}
+CLOCKSOURCE_OF_DECLARE(s3c2410_pwm, "samsung,s3c2410-pwm",
+					samsung_pwm_clocksource_init_of);
+CLOCKSOURCE_OF_DECLARE(s3c6400_pwm, "samsung,s3c6400-pwm",
+					samsung_pwm_clocksource_init_of);
+CLOCKSOURCE_OF_DECLARE(s5p6440_pwm, "samsung,s5p6440-pwm",
+					samsung_pwm_clocksource_init_of);
+CLOCKSOURCE_OF_DECLARE(s5pc100_pwm, "samsung,s5pc100-pwm",
+					samsung_pwm_clocksource_init_of);
+
+void __init samsung_pwm_clocksource_init(struct platform_device *pdev)
+{
+	__samsung_pwm_clocksource_init(pdev, NULL);
+}
-- 
1.8.1.5

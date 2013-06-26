From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Jun 2013 18:39:49 +0200
Subject: [linux-next PATCH] samsung_pwm: fix build for
 CONFIG_CLKSRC_SAMSUNG_PWM=n
Message-ID: <1913259.iCGtCKZW7f@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [linux-next PATCH] samsung_pwm: fix build for CONFIG_CLKSRC_SAMSUNG_PWM=n

If CONFIG_PWM_SAMSUNG=y and CONFIG_CLKSRC_SAMSUNG_PWM=n next-20130626
build fails with the following error:

drivers/pwm/pwm-samsung.c:89:19: error: static declaration of ?samsung_pwm_lock? follows non-static declaration
include/clocksource/samsung_pwm.h:23:19: note: previous declaration of ?samsung_pwm_lock? was here

It is caused by commit 9ebe293 ("pwm: Add new pwm-samsung driver").

Fix it by adding missing ifdef.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/clocksource/samsung_pwm.h |    2 ++
 1 file changed, 2 insertions(+)

Index: b/include/clocksource/samsung_pwm.h
===================================================================
--- a/include/clocksource/samsung_pwm.h	2013-06-21 12:05:51.329680497 +0200
+++ b/include/clocksource/samsung_pwm.h	2013-06-26 17:48:02.574187287 +0200
@@ -20,7 +20,9 @@
 
 #define SAMSUNG_PWM_NUM		5
 
+#ifdef CONFIG_CLKSRC_SAMSUNG_PWM
 extern spinlock_t samsung_pwm_lock;
+#endif
 
 struct samsung_pwm_variant {
 	u8 bits;

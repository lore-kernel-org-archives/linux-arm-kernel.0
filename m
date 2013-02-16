From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 17:44:00 +0100
Subject: [PATCH v2 08/12] ARM: SAMSUNG: devs: Drop unnecessary IRQ resources
 of timer devices
In-Reply-To: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361033044-27629-9-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devices from s3c_device_timer array are used only for PWM driver, which
does not need interrupts. This patch removes IRQ resources of those
devices.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/devs.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e1124d9..196aa68 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1137,34 +1137,22 @@ arch_initcall(s5p_pmu_init);
 
 #ifdef CONFIG_SAMSUNG_DEV_PWM
 
-#define TIMER_RESOURCE_SIZE (1)
-
-#define TIMER_RESOURCE(_tmr, _irq)			\
-	(struct resource [TIMER_RESOURCE_SIZE]) {	\
-		[0] = {					\
-			.start	= _irq,			\
-			.end	= _irq,			\
-			.flags	= IORESOURCE_IRQ	\
-		}					\
+#define DEFINE_S3C_TIMER(_tmr_no) {			\
+		.name		= "s3c24xx-pwm",	\
+		.id		= _tmr_no,		\
 	}
 
-#define DEFINE_S3C_TIMER(_tmr_no, _irq)			\
-	.name		= "s3c24xx-pwm",		\
-	.id		= _tmr_no,			\
-	.num_resources	= TIMER_RESOURCE_SIZE,		\
-	.resource	= TIMER_RESOURCE(_tmr_no, _irq),	\
-
 /*
  * since we already have an static mapping for the timer,
  * we do not bother setting any IO resource for the base.
  */
 
 struct platform_device s3c_device_timer[] = {
-	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
-	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
-	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
-	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
-	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
+	[0] = DEFINE_S3C_TIMER(0),
+	[1] = DEFINE_S3C_TIMER(1),
+	[2] = DEFINE_S3C_TIMER(2),
+	[3] = DEFINE_S3C_TIMER(3),
+	[4] = DEFINE_S3C_TIMER(4),
 };
 #endif /* CONFIG_SAMSUNG_DEV_PWM */
 
-- 
1.8.1.2

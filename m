From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  8 Nov 2012 14:01:54 -0700
Subject: [PATCH 09/11] ARM: samsung: register syscore_ops for timer resume
 directly
In-Reply-To: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1352408516-21988-11-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Instead of using struct sys_timer's resume function, register syscore_ops
directly in s3c2410_timer_init(). This will allow the sys_timer suspend/
resume fields to be removed, and eventually lead to a complete removal of
struct sys_timer.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/plat-samsung/time.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 67206df..773745a 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/mach-types.h>
 
@@ -271,6 +272,10 @@ static void __init s3c2410_timer_resources(void)
 	clk_enable(tin);
 }
 
+static struct syscore_ops s3c24xx_syscore_ops = {
+	.resume		= s3c2410_timer_setup,
+};
+
 static void __init s3c2410_timer_init(void)
 {
 	arch_gettimeoffset = s3c2410_gettimeoffset;
@@ -278,9 +283,9 @@ static void __init s3c2410_timer_init(void)
 	s3c2410_timer_resources();
 	s3c2410_timer_setup();
 	setup_irq(IRQ_TIMER4, &s3c2410_timer_irq);
+	register_syscore_ops(&s3c24xx_syscore_ops);
 }
 
 struct sys_timer s3c24xx_timer = {
 	.init		= s3c2410_timer_init,
-	.resume		= s3c2410_timer_setup
 };
-- 
1.7.0.4

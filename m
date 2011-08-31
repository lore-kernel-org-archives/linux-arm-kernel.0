From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 31 Aug 2011 19:12:39 +0530
Subject: [PATCH v6 23/25] gpio/omap: enable irq at the end of all
	configuration in restore
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1314798161-19523-24-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Setup the interrupt enable registers only after we have configured the
required edge and required configurations, not before, to prevent
spurious events as part of restore routine.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 67e08e9..db22df8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1323,10 +1323,6 @@ void omap2_gpio_resume_after_idle(void)
 
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	__raw_writel(bank->context.irqenable1,
-				bank->base + bank->regs->irqenable);
-	__raw_writel(bank->context.irqenable2,
-				bank->base + bank->regs->irqenable2);
 	__raw_writel(bank->context.wake_en,
 				bank->base + bank->regs->wkup_en);
 	__raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
@@ -1347,6 +1343,10 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 		__raw_writel(bank->context.debounce_en,
 					bank->base + bank->regs->debounce_en);
 	}
+	__raw_writel(bank->context.irqenable1,
+				bank->base + bank->regs->irqenable);
+	__raw_writel(bank->context.irqenable2,
+				bank->base + bank->regs->irqenable2);
 }
 #else
 #define omap_gpio_runtime_suspend NULL
-- 
1.7.0.4

From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 10:01:33 +0400
Subject: [PATCH 2/3] ARM: i.MX: tzic: Remove #ifdef CONFIG_PM
In-Reply-To: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401516095-31020-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend/Resume functions are not called by generic irqchip if PM
is not enabled. This patch removes excess #ifdef CONFIG_PM from
i.MX TZIC driver, so these functions will always be compiled in,
that increase compile coverage of this driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/tzic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index b5fc0c7..534431e 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -76,7 +76,6 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 #define tzic_set_irq_fiq NULL
 #endif
 
-#ifdef CONFIG_PM
 static void tzic_irq_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -93,11 +92,6 @@ static void tzic_irq_resume(struct irq_data *d)
 		     tzic_base + TZIC_WAKEUP0(idx));
 }
 
-#else
-#define tzic_irq_suspend NULL
-#define tzic_irq_resume NULL
-#endif
-
 static struct mxc_extra_irq tzic_extra_irq = {
 #ifdef CONFIG_FIQ
 	.set_irq_fiq = tzic_set_irq_fiq,
-- 
1.8.5.5

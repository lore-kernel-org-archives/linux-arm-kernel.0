From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 10:01:32 +0400
Subject: [PATCH 2/3] ARM: i.MX: avic: Remove #ifdef CONFIG_PM
In-Reply-To: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401516095-31020-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend/Resume functions are not called by generic irqchip if PM
is not enabled. This patch removes excess #ifdef CONFIG_PM from
i.MX AVIC driver, so these functions will always be compiled in,
that increase compile coverage of this driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/avic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 9adcad2..374be0c 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -86,7 +86,6 @@ static struct mxc_extra_irq avic_extra_irq = {
 #endif
 };
 
-#ifdef CONFIG_PM
 static u32 avic_saved_mask_reg[2];
 
 static void avic_irq_suspend(struct irq_data *d)
@@ -108,11 +107,6 @@ static void avic_irq_resume(struct irq_data *d)
 	__raw_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);
 }
 
-#else
-#define avic_irq_suspend NULL
-#define avic_irq_resume NULL
-#endif
-
 static __init void avic_init_gc(int idx, unsigned int irq_start)
 {
 	struct irq_chip_generic *gc;
-- 
1.8.5.5

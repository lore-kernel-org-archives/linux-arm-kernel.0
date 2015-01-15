From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 15 Jan 2015 13:09:31 +0300
Subject: [PATCH 2/5] ARM: sa1100: use sa11x0_sc_set_wake() in irq driver
In-Reply-To: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
References: <1421316574-10022-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1421316574-10022-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new function controlling PWER register in IRQ driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 65aebfa..7a5aa56 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -40,19 +40,9 @@ static void sa1100_unmask_irq(struct irq_data *d)
 	ICMR |= BIT(d->hwirq);
 }
 
-/*
- * Apart form GPIOs, only the RTC alarm can be a wakeup event.
- */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	if (BIT(d->hwirq) == IC_RTCAlrm) {
-		if (on)
-			PWER |= PWER_RTC;
-		else
-			PWER &= ~PWER_RTC;
-		return 0;
-	}
-	return -EINVAL;
+	return sa11x0_sc_set_wake(d->hwirq, on);
 }
 
 static struct irq_chip sa1100_normal_chip = {
-- 
2.1.4

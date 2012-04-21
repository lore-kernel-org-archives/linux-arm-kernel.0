From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:27 +0400
Subject: [PATCH 14/17] ARM clps711x: Do not mask interrupts in ack procedure
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-15-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have separate intX_mask procedure for it.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 3b6e6b8..b19fa92 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -66,12 +66,6 @@ static void int1_mask(struct irq_data *d)
 
 static void int1_ack(struct irq_data *d)
 {
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << d->irq);
-	clps_writel(intmr1, INTMR1);
-
 	switch (d->irq) {
 	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
 	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
@@ -108,12 +102,6 @@ static void int2_mask(struct irq_data *d)
 
 static void int2_ack(struct irq_data *d)
 {
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (d->irq - 16));
-	clps_writel(intmr2, INTMR2);
-
 	switch (d->irq) {
 	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
 	}
-- 
1.7.3.4

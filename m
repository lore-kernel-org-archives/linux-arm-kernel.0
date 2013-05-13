From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:33 +0400
Subject: [PATCH 11/15] ARM: clps711x: Optimize interrupt handling
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-14-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modify interrupt handler for processing all penging interrupts
at once.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index bd65839..f6d1746 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -215,7 +215,7 @@ void __init clps711x_init_irq(void)
 	}
 }
 
-inline u32 fls16(u32 x)
+static inline u32 fls16(u32 x)
 {
 	u32 r = 15;
 
@@ -239,18 +239,24 @@ inline u32 fls16(u32 x)
 
 asmlinkage void __exception_irq_entry clps711x_handle_irq(struct pt_regs *regs)
 {
-	u32 irqstat;
-	void __iomem *base = CLPS711X_VIRT_BASE;
+	do {
+		u32 irqstat;
+		void __iomem *base = CLPS711X_VIRT_BASE;
+
+		irqstat = readw_relaxed(base + INTSR1) &
+			  readw_relaxed(base + INTMR1);
+		if (irqstat)
+			handle_IRQ(fls16(irqstat), regs);
+
+		irqstat = readw_relaxed(base + INTSR2) &
+			  readw_relaxed(base + INTMR2);
+		if (irqstat) {
+			handle_IRQ(fls16(irqstat) + 16, regs);
+			continue;
+		}
 
-	irqstat = readl_relaxed(base + INTSR1) & readl_relaxed(base + INTMR1);
-	if (irqstat) {
-		handle_IRQ(fls16(irqstat), regs);
-		return;
-	}
-
-	irqstat = readl_relaxed(base + INTSR2) & readl_relaxed(base + INTMR2);
-	if (likely(irqstat))
-		handle_IRQ(fls16(irqstat) + 16, regs);
+		break;
+	} while (1);
 }
 
 static u32 notrace clps711x_sched_clock_read(void)
-- 
1.8.1.5

From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri,  9 May 2014 12:54:59 +0200
Subject: [PATCH v2] ARM: at91: fix startup rtc irq mask for sam9g25 and
 sam9g35 SoCs
Message-ID: <1399632899-2075-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sam9g25 and sam9g35 have the following errata:
"RTC: Interrupt Mask Register cannot be used
 Interrupt Mask Register read always returns 0."

Hence we should not rely on what IMR claims about already masked irqs
and just disable all the IRQs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
Changes since v1:
- use a macro to define IRQs bitmask
- read IMR register to ensure the write to IDR has been flushed
- quote atmel's datasheet errata in commit message
- comment the code to describe why we're not using IMR to disable
  the interrupts

 arch/arm/mach-at91/sysirq_mask.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/sysirq_mask.c b/arch/arm/mach-at91/sysirq_mask.c
index 2ba694f..4e2cd0d 100644
--- a/arch/arm/mach-at91/sysirq_mask.c
+++ b/arch/arm/mach-at91/sysirq_mask.c
@@ -25,8 +25,9 @@
 
 #include "generic.h"
 
-#define AT91_RTC_IDR	0x24	/* Interrupt Disable Register */
-#define AT91_RTC_IMR	0x28	/* Interrupt Mask Register */
+#define AT91_RTC_IDR		0x24	/* Interrupt Disable Register */
+#define AT91_RTC_IMR		0x28	/* Interrupt Mask Register */
+#define AT91_RTC_IRQ_MASK	0x1f	/* Available IRQs mask */
 
 void __init at91_sysirq_mask_rtc(u32 rtc_base)
 {
@@ -37,12 +38,16 @@ void __init at91_sysirq_mask_rtc(u32 rtc_base)
 	if (!base)
 		return;
 
-	mask = readl_relaxed(base + AT91_RTC_IMR);
-	if (mask) {
-		pr_info("AT91: Disabling rtc irq\n");
-		writel_relaxed(mask, base + AT91_RTC_IDR);
-		(void)readl_relaxed(base + AT91_RTC_IMR);	/* flush */
-	}
+	/*
+	 * The sam9g25 and sam9g35 have the following errata:
+	 * "RTC: Interrupt Mask Register cannot be used
+	 *  Interrupt Mask Register read always returns 0."
+	 *
+	 * Hence we're not relying on IMR values to disable
+	 * interrupts.
+	 */
+	writel_relaxed(AT91_RTC_IRQ_MASK, base + AT91_RTC_IDR);
+	(void)readl_relaxed(base + AT91_RTC_IMR);	/* flush */
 
 	iounmap(base);
 }
-- 
1.8.3.2

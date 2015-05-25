From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 25 May 2015 14:41:48 +0300
Subject: [PATCH v4 13/18] ARM: sa1100: don't preallocate IRQ space for locomo
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1432554113-26280-14-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As new locomo driver properly supports SPARSE_IRQ, stop playing with
NR_IRQS on sa1100 (locomo was the last chip requiring NR_IRQ tricks).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/include/mach/irqs.h | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index 734e30e..b4b9608 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -79,22 +79,7 @@
 #define IRQ_BOARD_START		61
 #define IRQ_BOARD_END		77
 
-/*
- * Figure out the MAX IRQ number.
- *
- * Neponset, SA1111 and UCB1x00 are sparse IRQ aware, so can dynamically
- * allocate their IRQs above NR_IRQS.
- *
- * LoCoMo has 4 additional IRQs, but is not sparse IRQ aware, and so has
- * to be included in the NR_IRQS calculation.
- */
-#ifdef CONFIG_SHARP_LOCOMO
-#define NR_IRQS_LOCOMO		4
-#else
-#define NR_IRQS_LOCOMO		0
-#endif
-
 #ifndef NR_IRQS
-#define NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
+#define NR_IRQS IRQ_BOARD_START
 #endif
-#define SA1100_NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
+#define SA1100_NR_IRQS IRQ_BOARD_START
-- 
2.1.4

From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Tue, 15 Nov 2011 10:06:21 +0800
Subject: [PATCH 2/6] ARM: gic: fix big endian support
In-Reply-To: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1321322785-2981-2-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq state from gic is in little-endian mode. We need do endian
conversion for it in big-endian machine. Usually byte swapping of
32-bits word needs 4 assembler instructions for arm machine which
arch < 6. But since the high order half word of the irq state is
zero, there is a way that can use lesser instrunctions to improve
the performance since we only need a bytes swaping of half word.
That's what swab16_low_half and swab16_high_half do.

Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 arch/arm/include/asm/assembler.h                |   27 +++++++++++++++++++++++
 arch/arm/include/asm/hardware/entry-macro-gic.S |    7 ++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 29035e8..3ddee22 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -302,4 +302,31 @@
 	.size \name , . - \name
 	.endm
 
+/*
+ * swab16_low_half is used to swap the bytes order of the low order
+ * half word, it assumes that the high order half word is zero.
+ * swab16_high_half is used to swap the bytes order of the high order
+ * half word, it assumes that the low order half word is zero.
+ */
+#if __LINUX_ARM_ARCH__ >= 6
+	.macro swab16_low_half, reg
+	rev \reg, \reg
+	.endm
+
+	.macro swab16_high_half, reg
+	rev \reg, \reg
+	.endm
+#else
+	.macro swab16_low_half, reg
+	mov \reg, \reg, ror #8
+	orr \reg, \reg, \reg, lsr #16
+	bic \reg, \reg, \reg, lsl #16
+	.endm
+
+	.macro swab16_high_half, reg
+	swab16_low_half \reg
+	mov \reg, \reg, lsl #16
+	.endm
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index 74ebc80..3453273 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -9,6 +9,7 @@
  */
 
 #include <asm/hardware/gic.h>
+#include <asm/assembler.h>
 
 #ifndef HAVE_GET_IRQNR_PREAMBLE
 	.macro	get_irqnr_preamble, base, tmp
@@ -35,6 +36,9 @@
 	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
 
 	ldr     \irqstat, [\base, #GIC_CPU_INTACK]
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	swab16_low_half \irqstat
+#endif
 	/* bits 12-10 = src CPU, 9-0 = int # */
 
 	ldr	\tmp, =1021
@@ -55,6 +59,9 @@
 	.macro test_for_ipi, irqnr, irqstat, base, tmp
 	bic	\irqnr, \irqstat, #0x1c00
 	cmp	\irqnr, #16
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	swab16_high_half \irqstat
+#endif
 	strcc	\irqstat, [\base, #GIC_CPU_EOI]
 	cmpcs	\irqnr, \irqnr
 	.endm
-- 
1.7.0.4

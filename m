From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:29 +0800
Subject: [PATCH 8/9] arm64: add the hardirq flags trace code for irq macros
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-9-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the hardirq flags trace code for irq macros.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/include/asm/assembler.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 10b017c..0be1d29 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -34,9 +34,15 @@
  */
 	.macro	disable_irq
 	msr	daifset, #2
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 	.endm
 
 	.macro	enable_irq
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_on
+#endif
 	msr	daifclr, #2
 	.endm
 
@@ -75,6 +81,9 @@
  * are self-synchronising.
  */
 	.macro	enable_dbg_and_irq
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_on
+#endif
 	msr	daifclr, #(8 | 2)
 	.endm
 
-- 
2.5.5

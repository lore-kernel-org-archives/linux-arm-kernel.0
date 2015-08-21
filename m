From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:48:20 +0100
Subject: [PATCH 2/4] ARM: entry: get rid of asm_trace_hardirqs_on_cond
In-Reply-To: <20150821134630.GW7557@n2100.arm.linux.org.uk>
References: <20150821134630.GW7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmg8-00044U-BD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need for this macro, it can use a default for the
condition argument.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/assembler.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 4abe57279c66..742495eb5526 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -116,7 +116,7 @@
 #endif
 	.endm
 
-	.macro asm_trace_hardirqs_on_cond, cond
+	.macro asm_trace_hardirqs_on, cond=al
 #if defined(CONFIG_TRACE_IRQFLAGS)
 	/*
 	 * actually the registers should be pushed and pop'd conditionally, but
@@ -128,10 +128,6 @@
 #endif
 	.endm
 
-	.macro asm_trace_hardirqs_on
-	asm_trace_hardirqs_on_cond al
-	.endm
-
 	.macro disable_irq
 	disable_irq_notrace
 	asm_trace_hardirqs_off
@@ -173,7 +169,7 @@
 
 	.macro restore_irqs, oldcpsr
 	tst	\oldcpsr, #PSR_I_BIT
-	asm_trace_hardirqs_on_cond eq
+	asm_trace_hardirqs_on cond=eq
 	restore_irqs_notrace \oldcpsr
 	.endm
 
-- 
2.1.0

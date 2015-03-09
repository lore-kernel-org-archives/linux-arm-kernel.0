From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:53:46 +0800
Subject: [PATCH v2.0 1/2] pm: at91: pm_suspend: add the WFI instruction
 support for ARMv7
In-Reply-To: <1425873187-8096-1-git-send-email-wenyou.yang@atmel.com>
References: <1425873187-8096-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425873226-8158-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the WFI instruction to make the cpu to the idle state.
In the meanwhile, disable the processor's clock.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm_suspend.S |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 0c520c3..95c3404 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -60,6 +60,24 @@ tmp2	.req	r5
 	beq	1b
 	.endm
 
+/*
+ * Put the processor to enter the idle state
+ */
+	.macro at91_cpu_idle
+
+#if defined(CONFIG_CPU_V7)
+	mov	tmp1, #AT91_PMC_PCK
+	str	tmp1, [pmc, #AT91_PMC_SCDR]
+
+	dsb
+
+	wfi		@ Wait For Interrupt
+#else
+	mcr	p15, 0, tmp1, c7, c0, 4
+#endif
+
+	.endm
+
 	.text
 
 /*
@@ -137,7 +155,7 @@ skip_disable_main_clock:
 	ldr	pmc, .pmc_base
 
 	/* Wait for interrupt */
-	mcr	p15, 0, tmp1, c7, c0, 4
+	at91_cpu_idle
 
 	ldr	r0, .pm_mode
 	tst	r0, #AT91_PM_SLOW_CLOCK
-- 
1.7.9.5

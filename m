From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:51:26 +0800
Subject: [PATCH 1/3] pm: at91: pm_suspend: add the WFI instruction support for
 ARMv7
In-Reply-To: <1423709441-8342-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709441-8342-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709486-8382-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the WFI instruction to make the cpu to the idle state.
In the meanwhile, disable the processor's clock.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm_suspend.S |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index bebe3de..1c7256a 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -51,6 +51,24 @@ tmp2	.req	r5
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
@@ -120,7 +138,7 @@ skip_disable_main_clock:
 	ldr	pmc, .pmc_base
 
 	/* Wait for interrupt */
-	mcr	p15, 0, tmp1, c7, c0, 4
+	at91_cpu_idle
 
 	ldr	r0, .pm_mode
 	tst	r0, #AT91_PM_SLOW_CLOCK
-- 
1.7.9.5

From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 18 Mar 2014 10:33:56 +0800
Subject: [PATCH 2/3] ARM: at91: pm_slowclock: add enter standby mode for ARMv7
In-Reply-To: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
References: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1395110037-23151-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm_slowclock.S |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 2001877..842ddaf 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -102,6 +102,20 @@ tmp2	.req	r5
 2:
 	.endm
 
+/*
+ * Put the processor to enter into Standby mode, wait for interrupt to wakeup
+ */
+	.macro _do_wfi
+
+#if defined(CONFIG_CPU_V7)
+	dsb
+	wfi		@ Wait For Interrupt
+#else
+	mcr	p15, 0, tmp1, c7, c0, 4
+#endif
+
+	.endm
+
 	.text
 
 /* void at91_slow_clock(void __iomem *pmc, void __iomem *sdramc,
@@ -220,7 +234,7 @@ sdr_sr_done:
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 	/* Wait for interrupt */
-	mcr	p15, 0, tmp1, c7, c0, 4
+	_do_wfi
 
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
-- 
1.7.9.5

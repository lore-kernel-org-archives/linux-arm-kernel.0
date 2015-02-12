From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:52:13 +0800
Subject: [PATCH 2/3] pm: at91: pm_suspend: MOR register KEY was missing
In-Reply-To: <1423709441-8342-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709441-8342-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709533-8416-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Vilchez <patrice.vilchez@atmel.com>

Because writing the MOR register requires the PASSWD(0x37),
if missed, the write operation will be aborted.

Signed-off-by: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/pm_suspend.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 1c7256a..5347ad4 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -132,6 +132,7 @@ ENTRY(at91_pm_suspend_in_sram)
 	/* Turn off the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 skip_disable_main_clock:
@@ -149,6 +150,7 @@ skip_disable_main_clock:
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 	wait_moscrdy
-- 
1.7.9.5

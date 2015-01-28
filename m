From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 28 Jan 2015 10:23:22 +0800
Subject: [PATCH v2 2/3] pm: at91: pm_suspend: MOR register KEY was missing
In-Reply-To: <1422411707-10945-1-git-send-email-wenyou.yang@atmel.com>
References: <1422411707-10945-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422411802-13207-1-git-send-email-wenyou.yang@atmel.com>
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
index aed6903..311cc23 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -224,6 +224,7 @@ sdr_sr_done:
 	/* Turn off the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 skip_disable_main_clock:
@@ -236,6 +237,7 @@ skip_disable_main_clock:
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 	wait_moscrdy
-- 
1.7.9.5

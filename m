From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:22 +0100
Subject: [PATCH 12/13] ARM: at91: pm: use C functions for standby
In-Reply-To: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
References: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170202144523.11706-13-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When going to standby, there is no point calling the assembly function
at91_pm_suspend_in_sram(). It does exactly the same operations as the C
standby functions.
This allows to remove a few loads and tests in the suspend/resume path.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c              |  8 +++++---
 arch/arm/mach-at91/pm.h              |  4 +---
 arch/arm/mach-at91/pm_data-offsets.c |  1 -
 arch/arm/mach-at91/pm_suspend.S      | 14 --------------
 4 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 553bcfc5545e..1992ad8b1c3d 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -125,12 +125,13 @@ extern u32 at91_pm_suspend_in_sram_sz;
 
 static void at91_pm_suspend(suspend_state_t state)
 {
-	pm_data.mode = (state == PM_SUSPEND_MEM) ? AT91_PM_SLOW_CLOCK : 0;
-
 	flush_cache_all();
 	outer_disable();
 
-	at91_suspend_sram_fn(&pm_data);
+	if (state == PM_SUSPEND_MEM)
+		at91_suspend_sram_fn(&pm_data);
+	else
+		pm_data.standby();
 
 	outer_resume();
 }
@@ -342,6 +343,7 @@ static __init void at91_dt_ramc(void)
 		ramc = of_id->data;
 		if (!standby)
 			standby = ramc->standby;
+		pm_data.standby = standby;
 		pm_data.memctrl = ramc->memctrl;
 
 		idx++;
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index fc0f7d048187..2317e39248b7 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -21,15 +21,13 @@
 #define AT91_MEMCTRL_SDRAMC	1
 #define AT91_MEMCTRL_DDRSDR	2
 
-#define	AT91_PM_SLOW_CLOCK	0x01
-
 #ifndef __ASSEMBLY__
 struct at91_pm_data {
 	void __iomem *pmc;
 	void __iomem *ramc[2];
 	unsigned long uhp_udp_mask;
 	unsigned int memctrl;
-	unsigned int mode;
+	void (*standby)(void);
 };
 #endif
 
diff --git a/arch/arm/mach-at91/pm_data-offsets.c b/arch/arm/mach-at91/pm_data-offsets.c
index 30302cb16df0..c4e6d648644f 100644
--- a/arch/arm/mach-at91/pm_data-offsets.c
+++ b/arch/arm/mach-at91/pm_data-offsets.c
@@ -8,6 +8,5 @@ int main(void)
 	DEFINE(PM_DATA_RAMC0,		offsetof(struct at91_pm_data, ramc[0]));
 	DEFINE(PM_DATA_RAMC1,		offsetof(struct at91_pm_data, ramc[1]));
 	DEFINE(PM_DATA_MEMCTRL,	offsetof(struct at91_pm_data, memctrl));
-	DEFINE(PM_DATA_MODE,		offsetof(struct at91_pm_data, mode));
 	return 0;
 }
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 3ee282c051e0..a8b32faaea5b 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -94,10 +94,6 @@ ENTRY(at91_pm_suspend_in_sram)
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
 
-	ldr	r0, [pm_data, #PM_DATA_MODE]
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_disable_main_clock
-
 	ldr	pmc, [pm_data, #PM_DATA_PMC]
 
 	/* Save Master clock setting */
@@ -126,18 +122,9 @@ ENTRY(at91_pm_suspend_in_sram)
 	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
-skip_disable_main_clock:
-	ldr	pmc, [pm_data, #PM_DATA_PMC]
-
 	/* Wait for interrupt */
 	at91_cpu_idle
 
-	ldr	r0, [pm_data, #PM_DATA_MODE]
-	tst	r0, #AT91_PM_SLOW_CLOCK
-	beq	skip_enable_main_clock
-
-	ldr	pmc, [pm_data, #PM_DATA_PMC]
-
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
@@ -166,7 +153,6 @@ skip_disable_main_clock:
 
 	wait_mckrdy
 
-skip_enable_main_clock:
 	/* Exit the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_EXIT
 	bl	at91_sramc_self_refresh
-- 
2.11.0

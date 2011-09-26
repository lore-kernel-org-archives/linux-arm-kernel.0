From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 26 Sep 2011 11:53:17 +0800
Subject: [PATCH 2/2] ARM: pxa/z2: fix building error of pxa27x_cpu_suspend()
	no longer available
In-Reply-To: <1317009197-12578-1-git-send-email-eric.y.miao@gmail.com>
References: <1317009197-12578-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1317009197-12578-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 6c9275a..6fa4e74 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -679,6 +679,8 @@ static inline void z2_pmic_init(void) {}
 #endif
 
 #ifdef CONFIG_PM
+extern void pxa27x_cpu_pm_enter(suspend_state_t state);
+
 static void z2_power_off(void)
 {
 	/* We're using deep sleep as poweroff, so clear PSPR to ensure that
@@ -686,7 +688,8 @@ static void z2_power_off(void)
 	 */
 	PSPR = 0x0;
 	local_irq_disable();
-	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	pxa27x_set_pwrmode(PWRMODE_DEEPSLEEP);
+	pxa27x_cpu_pm_enter(PM_SUSPEND_MEM);
 }
 #else
 #define z2_power_off   NULL
-- 
1.7.4.1

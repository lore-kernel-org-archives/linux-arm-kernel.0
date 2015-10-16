From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Oct 2015 11:22:06 -0500
Subject: [PATCH 07/11] arm: omap2: timer: always call clocksource_of_init()
 when DT
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Message-ID: <1445012530-14126-8-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting with DT, let's make sure to always
call clocksource_of_init() as this will make
it easier to move timer code to drivers/clocksource
in the future.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 8f2c75911179..851f3ad9e970 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -496,6 +496,9 @@ void __init omap_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
+
+	if (of_have_populated_dt())
+		clocksource_of_init();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
-- 
2.5.3

From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 11:03:52 +0100
Subject: [PATCH 15.2/15] ARM: ux500: Enable PRCMU Timer 4 (clocksource) for
 Device Tree
In-Reply-To: <CACRpkdaU+1XqXMRfv+3dTLCnw7J=dgFW394TNyAYuRUwupnD8w@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-16-git-send-email-lee.jones@linaro.org>
 <CACRpkdaU+1XqXMRfv+3dTLCnw7J=dgFW394TNyAYuRUwupnD8w@mail.gmail.com>
Message-ID: <4F967A88.10908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Apr 2012 10:04:46 +0100
Subject: [PATCH 16/16] ARM: ux500: Enable PRCMU Timer 4 (clocksource) for Device Tree

In dbx500 based devices the PRCMU Timer 4 is used as a clocksource
and sched_clock. Here we fetch all necessary addressing information
required for correct PRCMU initialisation from the Device Tree
instead of using hard-coded values.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/timer.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index d37df98..885c742 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/smp_twd.h>
 
@@ -43,10 +44,17 @@ static void __init ux500_twd_init(void)
 #define ux500_twd_init()	do { } while(0)
 #endif
 
+const static struct of_device_id prcmu_timer_of_match[] __initconst = {
+	{ .compatible = "stericsson,db8500-prcmu-timer-4", },
+	{ },
+};
+
 static void __init ux500_timer_init(void)
 {
 	void __iomem *mtu_timer_base;
 	void __iomem *prcmu_timer_base;
+	void __iomem *tmp_base;
+	struct device_node *np;
 
 	if (cpu_is_u5500()) {
 		mtu_timer_base = __io_address(U5500_MTU0_BASE);
@@ -58,6 +66,22 @@ static void __init ux500_timer_init(void)
 		ux500_unknown_soc();
 	}
 
+	/* TODO: Once MTU has been DT:ed place code above into else. */
+	if (of_have_populated_dt()) {
+		np = of_find_matching_node(NULL, prcmu_timer_of_match);
+		if (!np)
+			goto dt_fail;
+
+		tmp_base = of_iomap(np, 0);
+		if (!tmp_base)
+			goto dt_fail;
+
+		prcmu_timer_base = tmp_base;
+	}
+
+dt_fail:
+	/* Doing it the old fashioned way. */
+
 	/*
 	 * Here we register the timerblocks active in the system.
 	 * Localtimers (twd) is started when both cpu is up and running.
-- 
1.7.9.1

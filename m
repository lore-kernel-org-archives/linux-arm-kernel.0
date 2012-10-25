From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 25 Oct 2012 12:11:54 -0400
Subject: [PATCH v3 08/11] ARM: davinci - migrating to use common clock init
 code
In-Reply-To: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1351181518-11882-9-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A clk_init function pointer is added to davinci_soc_info to allow
SoC code to specify a clock init function for the SoC. Also
cpu_clks, psc_bases and psc_bases_num are being obsoleted as part
of the migration. clk_init() is now called from davinci_timer_init()
as the davinci_common_init() is too early to call this function.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/mach-davinci/common.c              |    6 ++++++
 arch/arm/mach-davinci/include/mach/common.h |    4 ++++
 arch/arm/mach-davinci/time.c                |    7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 64b0f65..039494e 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -20,7 +20,9 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 
+#ifndef CONFIG_COMMON_CLK
 #include "clock.h"
+#endif
 
 struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
@@ -105,12 +107,14 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 	if (ret < 0)
 		goto err;
 
+#ifndef CONFIG_COMMON_CLK
 	if (davinci_soc_info.cpu_clks) {
 		ret = davinci_clk_init(davinci_soc_info.cpu_clks);
 
 		if (ret != 0)
 			goto err;
 	}
+#endif
 
 	return;
 
@@ -122,5 +126,7 @@ void __init davinci_init_late(void)
 {
 	davinci_cpufreq_init();
 	davinci_pm_init();
+#ifndef CONFIG_COMMON_CLK
 	davinci_clk_disable_unused();
+#endif
 }
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index bdc4aa8..040db17 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -54,9 +54,13 @@ struct davinci_soc_info {
 	u32				jtag_id_reg;
 	struct davinci_id		*ids;
 	unsigned long			ids_num;
+#ifdef CONFIG_COMMON_CLK
+	void				(*clk_init)(void);
+#else
 	struct clk_lookup		*cpu_clks;
 	u32				*psc_bases;
 	unsigned long			psc_bases_num;
+#endif
 	u32				pinmux_base;
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 9847938..01467d8 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -27,7 +27,9 @@
 #include <mach/hardware.h>
 #include <mach/time.h>
 
+#ifndef CONFIG_COMMON_CLK
 #include "clock.h"
+#endif
 
 static struct clock_event_device clockevent_davinci;
 static unsigned int davinci_clock_tick_rate;
@@ -347,6 +349,11 @@ static void __init davinci_timer_init(void)
 		"%s: can't register clocksource!\n";
 	int i;
 
+#ifdef CONFIG_COMMON_CLK
+	/* invoke clk init function specific to a SoC */
+	if (davinci_soc_info.clk_init)
+		davinci_soc_info.clk_init();
+#endif
 	clockevent_id = soc_info->timer_info->clockevent_id;
 	clocksource_id = soc_info->timer_info->clocksource_id;
 
-- 
1.7.9.5

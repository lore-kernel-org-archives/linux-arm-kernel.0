From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:06:08 +0800
Subject: [PATCH v4 11/18] xtensa: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463054775-18170-12-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After patch "of/platform: Add common method to populate default bus",
it is possible for arch code to remove unnecessary callers about the
of_platform_populate with default match table.

Move of_clk_init() into time_init(), then drop xtensa_device_probe() fully.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/xtensa/kernel/setup.c | 11 -----------
 arch/xtensa/kernel/time.c  |  2 ++
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 9735691..18af563 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -22,10 +22,8 @@
 #include <linux/bootmem.h>
 #include <linux/kernel.h>
 #include <linux/percpu.h>
-#include <linux/clk-provider.h>
 #include <linux/cpu.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 # include <linux/console.h>
@@ -252,15 +250,6 @@ void __init early_init_devtree(void *params)
 		strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 }
 
-static int __init xtensa_device_probe(void)
-{
-	of_clk_init(NULL);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	return 0;
-}
-
-device_initcall(xtensa_device_probe);
-
 #endif /* CONFIG_OF */
 
 /*
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index b9ad9fe..6ec73c9 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -148,6 +149,7 @@ void __init time_init(void)
 	local_timer_setup(0);
 	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
+	of_clk_init(NULL);
 	clocksource_probe();
 }
 
-- 
1.7.12.4

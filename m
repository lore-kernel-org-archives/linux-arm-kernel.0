From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Apr 2012 17:13:30 +0100
Subject: [PATCH v3 6/6] ARM: vexpress: plug local timers into the DT code
In-Reply-To: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1334592810-4382-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-vexpress/v2m.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 47cdcca..fd62bfe 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -19,8 +19,10 @@
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
 
+#include <asm/arch_timer.h>
 #include <asm/mach-types.h>
 #include <asm/sizes.h>
+#include <asm/smp_twd.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
@@ -616,7 +618,6 @@ void __init v2m_dt_init_early(void)
 	}
 
 	clkdev_add_table(v2m_dt_lookups, ARRAY_SIZE(v2m_dt_lookups));
-	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
 }
 
 static  struct of_device_id vexpress_irq_match[] __initdata = {
@@ -643,6 +644,11 @@ static void __init v2m_dt_timer_init(void)
 		return;
 	node = of_find_node_by_path(path);
 	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
+	if (arch_timer_of_register())
+		twd_local_timer_of_register();
+
+	if (arch_timer_sched_clock_init())
+		versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
 }
 
 static struct sys_timer v2m_dt_timer = {
-- 
1.7.7.1

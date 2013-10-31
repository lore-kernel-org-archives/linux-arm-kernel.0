From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 31 Oct 2013 09:10:16 -0700
Subject: [PATCH 3/6] arm: zynq: Add support for zynq_cpu_kill function
In-Reply-To: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383235819-2552-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>

Use simple hook to slcr to stop cpu.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/platsmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index daed70682c54..4f592a7efc10 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -126,11 +126,20 @@ static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
 	scu_enable(zynq_scu_base);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int zynq_cpu_kill(unsigned cpu)
+{
+	zynq_slcr_cpu_stop(cpu);
+	return 1;
+}
+#endif
+
 struct smp_operations zynq_smp_ops __initdata = {
 	.smp_init_cpus		= zynq_smp_init_cpus,
 	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
 	.smp_boot_secondary	= zynq_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= zynq_platform_cpu_die,
+	.cpu_kill		= zynq_cpu_kill,
 #endif
 };
-- 
1.8.4.1

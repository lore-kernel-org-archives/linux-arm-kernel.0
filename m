From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 May 2013 18:27:22 +0800
Subject: [PATCH 4/6] ARM: tegra114: add power up sequence for warm boot CPU
In-Reply-To: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
Message-ID: <1368613644-11863-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Tegra114, once the CPUs were powered up by PMC in cold boot flow. The
flow controller will maintain the power state and control power sequence
for each CPU by setting event trigger (e.g. CPU hotplug ,idle and
suspend power down/up).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.h |  1 +
 arch/arm/mach-tegra/platsmp.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index 67eab56..7a29bae 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -25,6 +25,7 @@
 #define FLOW_CTRL_WAITEVENT		(2 << 29)
 #define FLOW_CTRL_WAIT_FOR_INTERRUPT	(4 << 29)
 #define FLOW_CTRL_JTAG_RESUME		(1 << 28)
+#define FLOW_CTRL_SCLK_RESUME		(1 << 27)
 #define FLOW_CTRL_HALT_CPU_IRQ		(1 << 10)
 #define	FLOW_CTRL_HALT_CPU_FIQ		(1 << 8)
 #define FLOW_CTRL_CPU0_CSR		0x8
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index fad4226..554aedc 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -140,8 +140,31 @@ remove_clamps:
 
 static int tegra114_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	int ret = 0;
+
 	cpu = cpu_logical_map(cpu);
-	return tegra_pmc_cpu_power_on(cpu);
+
+	if (cpumask_test_cpu(cpu, &tegra_cpu_init_mask)) {
+		/*
+		 * Warm boot flow
+		 * The flow controller in charge of the power state and
+		 * control for each CPU.
+		 */
+		/* set SCLK as event trigger for flow controller */
+		flowctrl_write_cpu_csr(cpu, 1);
+		flowctrl_write_cpu_halt(cpu,
+				FLOW_CTRL_WAITEVENT | FLOW_CTRL_SCLK_RESUME);
+	} else {
+		/*
+		 * Cold boot flow
+		 * The CPU is powered up by toggling PMC directly. It will
+		 * also initial power state in flow controller. After that,
+		 * the CPU's power state is maintained by flow controller.
+		 */
+		ret = tegra_pmc_cpu_power_on(cpu);
+	}
+
+	return ret;
 }
 
 static int __cpuinit tegra_boot_secondary(unsigned int cpu,
-- 
1.8.2.2

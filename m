From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Oct 2012 16:48:45 +0800
Subject: [PATCH V2 6/7] ARM: tegra30: flowctrl: add cpu_suspend_exter/exit
 function
In-Reply-To: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
References: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
Message-ID: <1350636526-25920-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flow controller can help CPU to go into suspend mode (deep power
saving mode). When CPU go into deep power saving mode, it needs some
careful settings before getting into and after leaving. The enter and
exit functions do that by configuring appropriate mode for flow
controller.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* same with V1

 arch/arm/mach-tegra/flowctrl.c |   47 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/flowctrl.h |    8 ++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index f07488e..5967b08 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/cpumask.h>
 
 #include <mach/iomap.h>
 
@@ -51,6 +52,14 @@ static void flowctrl_update(u8 offset, u32 value)
 	readl_relaxed(addr);
 }
 
+u32 flowctrl_read_cpu_csr(unsigned int cpuid)
+{
+	u8 offset = flowctrl_offset_cpu_csr[cpuid];
+	void __iomem *addr = IO_ADDRESS(TEGRA_FLOW_CTRL_BASE) + offset;
+
+	return readl(addr);
+}
+
 void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value)
 {
 	return flowctrl_update(flowctrl_offset_cpu_csr[cpuid], value);
@@ -60,3 +69,41 @@ void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value)
 {
 	return flowctrl_update(flowctrl_offset_halt_cpu[cpuid], value);
 }
+
+void flowctrl_cpu_suspend_enter(unsigned int cpuid)
+{
+	unsigned int reg;
+	int i;
+
+	reg = flowctrl_read_cpu_csr(cpuid);
+	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;	/* clear wfe bitmap */
+	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;	/* clear wfi bitmap */
+	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr flag */
+	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event flag */
+	reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;	/* pwr gating on wfi */
+	reg |= FLOW_CTRL_CSR_ENABLE;			/* pwr gating */
+	flowctrl_write_cpu_csr(cpuid, reg);
+
+	for (i = 0; i < num_possible_cpus(); i++) {
+		if (i == cpuid)
+			continue;
+		reg = flowctrl_read_cpu_csr(i);
+		reg |= FLOW_CTRL_CSR_EVENT_FLAG;
+		reg |= FLOW_CTRL_CSR_INTR_FLAG;
+		flowctrl_write_cpu_csr(i, reg);
+	}
+}
+
+void flowctrl_cpu_suspend_exit(unsigned int cpuid)
+{
+	unsigned int reg;
+
+	/* Disable powergating via flow controller for CPU0 */
+	reg = flowctrl_read_cpu_csr(cpuid);
+	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;	/* clear wfe bitmap */
+	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;	/* clear wfi bitmap */
+	reg &= ~FLOW_CTRL_CSR_ENABLE;			/* clear enable */
+	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr */
+	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event */
+	flowctrl_write_cpu_csr(cpuid, reg);
+}
diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index 1942817..0798dec 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -34,9 +34,17 @@
 #define FLOW_CTRL_HALT_CPU1_EVENTS	0x14
 #define FLOW_CTRL_CPU1_CSR		0x18
 
+#define TEGRA30_FLOW_CTRL_CSR_WFI_CPU0		(1 << 8)
+#define TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP	(0xF << 4)
+#define TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP	(0xF << 8)
+
 #ifndef __ASSEMBLY__
+u32 flowctrl_read_cpu_csr(unsigned int cpuid);
 void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value);
 void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
+
+void flowctrl_cpu_suspend_enter(unsigned int cpuid);
+void flowctrl_cpu_suspend_exit(unsigned int cpuid);
 #endif
 
 #endif
-- 
1.7.0.4

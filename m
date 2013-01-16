From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 16 Jan 2013 16:11:01 +0800
Subject: [PATCH V4 4/5] ARM: tegra20: flowctrl: add support for
 cpu_suspend_enter/exit
Message-ID: <1358323861-30455-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flow controller can help CPU to go into suspend mode (powered-down
state). When CPU go into powered-down state, it needs some careful
settings before getting into and after leaving. The enter and exit
functions do that by configuring appropriate mode for flow controller.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V4:
* no change
V3:
* no change
V2:
* no change
---
 arch/arm/mach-tegra/flowctrl.c | 38 +++++++++++++++++++++++++++++++++-----
 arch/arm/mach-tegra/flowctrl.h |  4 ++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index 5393eb2..b477ef3 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -25,6 +25,7 @@
 
 #include "flowctrl.h"
 #include "iomap.h"
+#include "fuse.h"
 
 static u8 flowctrl_offset_halt_cpu[] = {
 	FLOW_CTRL_HALT_CPU0_EVENTS,
@@ -75,11 +76,26 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
 	int i;
 
 	reg = flowctrl_read_cpu_csr(cpuid);
-	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;	/* clear wfe bitmap */
-	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;	/* clear wfi bitmap */
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
+		/* pwr gating on wfe */
+		reg |= TEGRA20_FLOW_CTRL_CSR_WFE_CPU0 << cpuid;
+		break;
+	case TEGRA30:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
+		/* pwr gating on wfi */
+		reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;
+		break;
+	}
 	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr flag */
 	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event flag */
-	reg |= TEGRA30_FLOW_CTRL_CSR_WFI_CPU0 << cpuid;	/* pwr gating on wfi */
 	reg |= FLOW_CTRL_CSR_ENABLE;			/* pwr gating */
 	flowctrl_write_cpu_csr(cpuid, reg);
 
@@ -99,8 +115,20 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 
 	/* Disable powergating via flow controller for CPU0 */
 	reg = flowctrl_read_cpu_csr(cpuid);
-	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;	/* clear wfe bitmap */
-	reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;	/* clear wfi bitmap */
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP;
+		break;
+	case TEGRA30:
+		/* clear wfe bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
+		/* clear wfi bitmap */
+		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP;
+		break;
+	}
 	reg &= ~FLOW_CTRL_CSR_ENABLE;			/* clear enable */
 	reg |= FLOW_CTRL_CSR_INTR_FLAG;			/* clear intr */
 	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event */
diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index 0798dec..67eab56 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -34,6 +34,10 @@
 #define FLOW_CTRL_HALT_CPU1_EVENTS	0x14
 #define FLOW_CTRL_CPU1_CSR		0x18
 
+#define TEGRA20_FLOW_CTRL_CSR_WFE_CPU0		(1 << 4)
+#define TEGRA20_FLOW_CTRL_CSR_WFE_BITMAP	(3 << 4)
+#define TEGRA20_FLOW_CTRL_CSR_WFI_BITMAP	0
+
 #define TEGRA30_FLOW_CTRL_CSR_WFI_CPU0		(1 << 8)
 #define TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP	(0xF << 4)
 #define TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP	(0xF << 8)
-- 
1.8.0.3

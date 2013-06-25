From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 25 Jun 2013 17:27:49 +0800
Subject: [PATCH 05/11] ARM: tegra114: shut off the CPU rail when the last CPU
 in suspend
In-Reply-To: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372152475-18617-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the last CPU core in suspend, the CPU power rail can be turned off
by setting flags to flow controller. Then the flow controller will inform
PMC to turn off the CPU rail when the last CPU goes into suspend.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.h |  5 +++++
 arch/arm/mach-tegra/pmc.c      | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index de0acb9..c89aac6 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -35,6 +35,11 @@
 #define FLOW_CTRL_CPU0_CSR		0x8
 #define	FLOW_CTRL_CSR_INTR_FLAG		(1 << 15)
 #define FLOW_CTRL_CSR_EVENT_FLAG	(1 << 14)
+#define FLOW_CTRL_CSR_ENABLE_EXT_CRAIL	(1 << 13)
+#define FLOW_CTRL_CSR_ENABLE_EXT_NCPU	(1 << 12)
+#define FLOW_CTRL_CSR_ENABLE_EXT_MASK ( \
+		FLOW_CTRL_CSR_ENABLE_EXT_NCPU | \
+		FLOW_CTRL_CSR_ENABLE_EXT_CRAIL)
 #define FLOW_CTRL_CSR_ENABLE		(1 << 0)
 #define FLOW_CTRL_HALT_CPU1_EVENTS	0x14
 #define FLOW_CTRL_CPU1_CSR		0x18
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 32360e5..4c2958f 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#include "flowctrl.h"
 #include "fuse.h"
 #include "pm.h"
 #include "pmc.h"
@@ -202,6 +203,15 @@ void tegra_pmc_pm_set(enum tegra_suspend_mode mode)
 	reg |= TEGRA_POWER_CPU_PWRREQ_OE;
 	reg &= ~TEGRA_POWER_EFFECT_LP0;
 
+	/* Turn off CRAIL */
+	if (tegra_chip_id == TEGRA114) {
+		u32 fc_reg;
+		fc_reg = flowctrl_read_cpu_csr(0);
+		fc_reg &= ~FLOW_CTRL_CSR_ENABLE_EXT_MASK;
+		fc_reg |= FLOW_CTRL_CSR_ENABLE_EXT_CRAIL;
+		flowctrl_write_cpu_csr(0, fc_reg);
+	}
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP2:
 		rate = clk_get_rate(tegra_pclk);
-- 
1.8.3.1

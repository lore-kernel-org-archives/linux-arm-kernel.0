From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 14:07:28 +0200
Subject: [PATCH v2 3/3] ARM: tegra: Initialize flow controller from DT
In-Reply-To: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
References: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403870848-1754-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Use a matching device tree node to initialize the flow controller driver
instead of hard-coding the I/O address. This is necessary to get rid of
the iomap.h include, which in turn make it easier to share this code
with 64-bit Tegra SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- implement fallback when the device tree node is missing
- while at it, reorder includes alphabetically

 arch/arm/mach-tegra/flowctrl.c | 48 ++++++++++++++++++++++++++++++++++--------
 arch/arm/mach-tegra/flowctrl.h |  2 ++
 arch/arm/mach-tegra/tegra.c    |  2 ++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index 4b31091f0d40..89d13b2fa0b5 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -18,14 +18,15 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/io.h>
-#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/tegra-soc.h>
 
 #include "flowctrl.h"
-#include "iomap.h"
 
 static u8 flowctrl_offset_halt_cpu[] = {
 	FLOW_CTRL_HALT_CPU0_EVENTS,
@@ -41,23 +42,22 @@ static u8 flowctrl_offset_cpu_csr[] = {
 	FLOW_CTRL_CPU1_CSR + 16,
 };
 
+static void __iomem *tegra_flowctrl_base;
+
 static void flowctrl_update(u8 offset, u32 value)
 {
-	void __iomem *addr = IO_ADDRESS(TEGRA_FLOW_CTRL_BASE) + offset;
-
-	writel(value, addr);
+	writel(value, tegra_flowctrl_base + offset);
 
 	/* ensure the update has reached the flow controller */
 	wmb();
-	readl_relaxed(addr);
+	readl_relaxed(tegra_flowctrl_base + offset);
 }
 
 u32 flowctrl_read_cpu_csr(unsigned int cpuid)
 {
 	u8 offset = flowctrl_offset_cpu_csr[cpuid];
-	void __iomem *addr = IO_ADDRESS(TEGRA_FLOW_CTRL_BASE) + offset;
 
-	return readl(addr);
+	return readl(tegra_flowctrl_base + offset);
 }
 
 void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value)
@@ -138,3 +138,33 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 	reg |= FLOW_CTRL_CSR_EVENT_FLAG;		/* clear event */
 	flowctrl_write_cpu_csr(cpuid, reg);
 }
+
+static const struct of_device_id matches[] __initconst = {
+	{ .compatible = "nvidia,tegra124-flowctrl" },
+	{ .compatible = "nvidia,tegra114-flowctrl" },
+	{ .compatible = "nvidia,tegra30-flowctrl" },
+	{ .compatible = "nvidia,tegra20-flowctrl" },
+	{ }
+};
+
+void __init tegra_flowctrl_init(void)
+{
+	/* hardcoded fallback if device tree node is missing */
+	unsigned long base = 0x60007000;
+	unsigned long size = SZ_4K;
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, matches);
+	if (np) {
+		struct resource res;
+
+		if (of_address_to_resource(np, 0, &res) == 0) {
+			size = resource_size(&res);
+			base = res.start;
+		}
+
+		of_node_put(np);
+	}
+
+	tegra_flowctrl_base = ioremap_nocache(base, size);
+}
diff --git a/arch/arm/mach-tegra/flowctrl.h b/arch/arm/mach-tegra/flowctrl.h
index c89aac60a143..73a9c5016c1a 100644
--- a/arch/arm/mach-tegra/flowctrl.h
+++ b/arch/arm/mach-tegra/flowctrl.h
@@ -59,6 +59,8 @@ void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value);
 
 void flowctrl_cpu_suspend_enter(unsigned int cpuid);
 void flowctrl_cpu_suspend_exit(unsigned int cpuid);
+
+void tegra_flowctrl_init(void);
 #endif
 
 #endif
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 76a6779c5f84..8e139e246526 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -46,6 +46,7 @@
 #include "board.h"
 #include "common.h"
 #include "cpuidle.h"
+#include "flowctrl.h"
 #include "iomap.h"
 #include "irq.h"
 #include "pmc.h"
@@ -78,6 +79,7 @@ static void __init tegra_init_early(void)
 	tegra_cpu_reset_handler_init();
 	tegra_powergate_init();
 	tegra_hotplug_init();
+	tegra_flowctrl_init();
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.0.0

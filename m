From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Jun 2014 13:58:11 +0200
Subject: [PATCH 2/2] ARM: tegra: Initialize flow controller from DT
In-Reply-To: <1402487891-6493-1-git-send-email-thierry.reding@gmail.com>
References: <1402487891-6493-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1402487891-6493-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Use a matching device tree node to initialize the flow controller driver
instead of hard-coding the I/O address. This is necessary to get rid of
the iomap.h include, which in turn make it easier to share this code
with 64-bit Tegra SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that this doesn't provide a fallback option for compatibility with
old device trees. Any kind of fallback would require either the iomap.h
file to remain included or copying out some parts verbatim, which to a
large degree defies the whole purpose of this patch. The ultimate goal
is to move this code into drivers/soc/tegra in order to allow sharing
between 32- and 64-bit Tegra SoCs.

If we absolutely must have backwards compatibility with device trees
that don't have the flow controller node and still want to share this
code with ARM64, I don't see any other way than moving iomap.h to
drivers/soc/tegra along with all the other code.

 arch/arm/mach-tegra/flowctrl.c | 36 +++++++++++++++++++++++++++---------
 arch/arm/mach-tegra/flowctrl.h |  2 ++
 arch/arm/mach-tegra/tegra.c    |  2 ++
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index ce8ab8abf061..5f84320a91d4 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -18,13 +18,14 @@
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
 
 #include "flowctrl.h"
-#include "iomap.h"
 #include "fuse.h"
 
 static u8 flowctrl_offset_halt_cpu[] = {
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
@@ -138,3 +138,21 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
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
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, matches);
+	BUG_ON(!np);
+
+	tegra_flowctrl_base = of_iomap(np, 0);
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
index 972fc87ec185..d008adf558b8 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -46,6 +46,7 @@
 #include "board.h"
 #include "common.h"
 #include "cpuidle.h"
+#include "flowctrl.h"
 #include "fuse.h"
 #include "iomap.h"
 #include "irq.h"
@@ -80,6 +81,7 @@ static void __init tegra_init_early(void)
 	tegra_cpu_reset_handler_init();
 	tegra_powergate_init();
 	tegra_hotplug_init();
+	tegra_flowctrl_init();
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
1.9.2

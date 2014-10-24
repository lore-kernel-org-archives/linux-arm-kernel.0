From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:20 +0200
Subject: [PATCH 07/17] bus: mvebu-mbus: suspend/resume support
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit extends the mvebu-mbus driver to provide suspend/resume
support. Since mvebu-mbus is not a platform_driver, the syscore_ops
mechanism is used to get ->suspend() and ->resume() hooks called into
the driver.

In those hooks, we save and restore the MBus windows state, to make
sure after resume all Mbus windows are properly restored. Note that
while the state of some windows could be gathered by looking again at
the Device Tree (for statically described windows), it is not the case
of dynamically described windows such as the PCIe memory and I/O
windows. Therefore, we take the simple approach of saving and
restoring the registers for all MBus windows.

In addition, the commit extends the Device Tree binding of the MBus
controller, to control the MBus bridge registers (which define which
parts of the physical address space is routed to MBus windows
vs. normal RAM memory). Those registers must be saved and restored
during suspend/resume. The Device Tree binding extension is made is a
backward compatible fashion, but of course, suspend/resume will not
work without the Device Tree update.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/bus/mvebu-mbus.txt         |  17 +--
 drivers/bus/mvebu-mbus.c                           | 125 ++++++++++++++++++++-
 2 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
index 5fa44f5..5e16c3c 100644
--- a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
+++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
@@ -48,9 +48,12 @@ Required properties:
 - compatible:	Should be set to "marvell,mbus-controller".
 
 - reg:          Device's register space.
-		Two entries are expected (see the examples below):
-		the first one controls the devices decoding window and
-		the second one controls the SDRAM decoding window.
+		Two or three entries are expected (see the examples below):
+		the first one controls the devices decoding window,
+		the second one controls the SDRAM decoding window and
+		the third controls the MBus bridge (only with the
+		marvell,armada370-mbus and marvell,armadaxp-mbus
+		compatible strings)
 
 Example:
 
@@ -67,7 +70,7 @@ Example:
 
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+				reg = <0x20000 0x100>, <0x20180 0x20>, <0x20250 0x8>;
 			};
 
 			/* more children ...*/
@@ -126,7 +129,7 @@ are skipped.
 
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+				reg = <0x20000 0x100>, <0x20180 0x20>, <0x20250 0x8>;
 			};
 
 			/* more children ...*/
@@ -170,7 +173,7 @@ Using this macro, the above example would be:
 
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+				reg = <0x20000 0x100>, <0x20180 0x20>, <0x20250 0x8>;
 			};
 
 			/* other children */
@@ -266,7 +269,7 @@ See the example below, where a more complete device tree is shown:
 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
 
 			mbusc: mbus-controller at 20000 {
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+				reg = <0x20000 0x100>, <0x20180 0x20>, <0x20250 0x8>;
 			};
 
 			interrupt-controller at 20000 {
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 26c3779d..25b5b35 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -57,6 +57,7 @@
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
 #include <linux/log2.h>
+#include <linux/syscore_ops.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -94,20 +95,39 @@
 
 #define DOVE_DDR_BASE_CS_OFF(n) ((n) << 4)
 
+/* Relative to mbusbridge_base */
+#define MBUS_BRIDGE_CTRL_OFF	0x0
+#define MBUS_BRIDGE_BASE_OFF	0x4
+
+/* Maximum number of windows, for all known platforms */
+#define MBUS_WINS_MAX           20
+
 struct mvebu_mbus_state;
 
 struct mvebu_mbus_soc_data {
 	unsigned int num_wins;
 	unsigned int num_remappable_wins;
+	bool has_mbus_bridge;
 	unsigned int (*win_cfg_offset)(const int win);
 	void (*setup_cpu_target)(struct mvebu_mbus_state *s);
 	int (*show_cpu_target)(struct mvebu_mbus_state *s,
 			       struct seq_file *seq, void *v);
 };
 
+/*
+ * Used to store the state of one MBus window accross suspend/resume.
+ */
+struct mvebu_mbus_win_data {
+	u32 ctrl;
+	u32 base;
+	u32 remap_lo;
+	u32 remap_hi;
+};
+
 struct mvebu_mbus_state {
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
+	void __iomem *mbusbridge_base;
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_sdram;
 	struct dentry *debugfs_devs;
@@ -115,6 +135,11 @@ struct mvebu_mbus_state {
 	struct resource pcie_io_aperture;
 	const struct mvebu_mbus_soc_data *soc;
 	int hw_io_coherency;
+
+	/* Used during suspend/resume */
+	u32 mbus_bridge_ctrl;
+	u32 mbus_bridge_base;
+	struct mvebu_mbus_win_data wins[MBUS_WINS_MAX];
 };
 
 static struct mvebu_mbus_state mbus_state;
@@ -549,6 +574,7 @@ mvebu_mbus_dove_setup_cpu_target(struct mvebu_mbus_state *mbus)
 static const struct mvebu_mbus_soc_data armada_370_xp_mbus_data = {
 	.num_wins            = 20,
 	.num_remappable_wins = 8,
+	.has_mbus_bridge     = true,
 	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
@@ -698,11 +724,74 @@ static __init int mvebu_mbus_debugfs_init(void)
 }
 fs_initcall(mvebu_mbus_debugfs_init);
 
+static int mvebu_mbus_suspend(void)
+{
+	struct mvebu_mbus_state *s = &mbus_state;
+	int win;
+
+	for (win = 0; win < s->soc->num_wins; win++) {
+		void __iomem *addr = s->mbuswins_base +
+			s->soc->win_cfg_offset(win);
+
+		s->wins[win].base = readl(addr + WIN_BASE_OFF);
+		s->wins[win].ctrl = readl(addr + WIN_CTRL_OFF);
+
+		if (win >= s->soc->num_remappable_wins)
+			continue;
+
+		s->wins[win].remap_lo = readl(addr + WIN_REMAP_LO_OFF);
+		s->wins[win].remap_hi = readl(addr + WIN_REMAP_HI_OFF);
+	}
+
+	if (s->mbusbridge_base) {
+		s->mbus_bridge_ctrl = readl(s->mbusbridge_base +
+					    MBUS_BRIDGE_CTRL_OFF);
+		s->mbus_bridge_base = readl(s->mbusbridge_base +
+					    MBUS_BRIDGE_BASE_OFF);
+	}
+
+	return 0;
+}
+
+static void mvebu_mbus_resume(void)
+{
+	struct mvebu_mbus_state *s = &mbus_state;
+	int win;
+
+	if (s->mbusbridge_base) {
+		writel(s->mbus_bridge_ctrl,
+		       s->mbusbridge_base + MBUS_BRIDGE_CTRL_OFF);
+		writel(s->mbus_bridge_base,
+		       s->mbusbridge_base + MBUS_BRIDGE_BASE_OFF);
+	}
+
+	for (win = 0; win < s->soc->num_wins; win++) {
+		void __iomem *addr = s->mbuswins_base +
+			s->soc->win_cfg_offset(win);
+
+		writel(s->wins[win].base, addr + WIN_BASE_OFF);
+		writel(s->wins[win].ctrl, addr + WIN_CTRL_OFF);
+
+		if (win >= s->soc->num_remappable_wins)
+			continue;
+
+		writel(s->wins[win].remap_lo, addr + WIN_REMAP_LO_OFF);
+		writel(s->wins[win].remap_hi, addr + WIN_REMAP_HI_OFF);
+	}
+}
+
+struct syscore_ops mvebu_mbus_syscore_ops = {
+	.suspend	= mvebu_mbus_suspend,
+	.resume		= mvebu_mbus_resume,
+};
+
 static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t mbuswins_phys_base,
 					 size_t mbuswins_size,
 					 phys_addr_t sdramwins_phys_base,
-					 size_t sdramwins_size)
+					 size_t sdramwins_size,
+					 phys_addr_t mbusbridge_phys_base,
+					 size_t mbusbridge_size)
 {
 	int win;
 
@@ -716,11 +805,24 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		return -ENOMEM;
 	}
 
+	if (mbusbridge_phys_base) {
+		mbus->mbusbridge_base = ioremap(mbusbridge_phys_base,
+						mbusbridge_size);
+		if (!mbus->mbusbridge_base) {
+			iounmap(mbus->sdramwins_base);
+			iounmap(mbus->mbuswins_base);
+			return -ENOMEM;
+		}
+	} else
+		mbus->mbusbridge_base = NULL;
+
 	for (win = 0; win < mbus->soc->num_wins; win++)
 		mvebu_mbus_disable_window(mbus, win);
 
 	mbus->soc->setup_cpu_target(mbus);
 
+	register_syscore_ops(&mvebu_mbus_syscore_ops);
+
 	return 0;
 }
 
@@ -746,7 +848,7 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 			mbuswins_phys_base,
 			mbuswins_size,
 			sdramwins_phys_base,
-			sdramwins_size);
+			sdramwins_size, 0, 0);
 }
 
 #ifdef CONFIG_OF
@@ -887,7 +989,7 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 
 int __init mvebu_mbus_dt_init(bool is_coherent)
 {
-	struct resource mbuswins_res, sdramwins_res;
+	struct resource mbuswins_res, sdramwins_res, mbusbridge_res;
 	struct device_node *np, *controller;
 	const struct of_device_id *of_id;
 	const __be32 *prop;
@@ -923,6 +1025,19 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 		return -EINVAL;
 	}
 
+	/*
+	 * Set the resource to 0 so that it can be left unmapped by
+	 * mvebu_mbus_common_init() if the DT doesn't carry the
+	 * necessary information. This is needed to preserve backward
+	 * compatibility.
+	 */
+	memset(&mbusbridge_res, 0, sizeof(mbusbridge_res));
+
+	if (mbus_state.soc->has_mbus_bridge) {
+		if (of_address_to_resource(controller, 2, &mbusbridge_res))
+			pr_warn(FW_WARN "deprecated mbus-mvebu Device Tree, suspend/resume will not work\n");
+	}
+
 	mbus_state.hw_io_coherency = is_coherent;
 
 	/* Get optional pcie-{mem,io}-aperture properties */
@@ -933,7 +1048,9 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 				     mbuswins_res.start,
 				     resource_size(&mbuswins_res),
 				     sdramwins_res.start,
-				     resource_size(&sdramwins_res));
+				     resource_size(&sdramwins_res),
+				     mbusbridge_res.start,
+				     resource_size(&mbusbridge_res));
 	if (ret)
 		return ret;
 
-- 
2.0.0

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:21 +0200
Subject: [PATCH 08/17] bus: mvebu-mbus: provide a mechanism to save SDRAM
 window configuration
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell EBU platforms, when doing suspend/resume, the SDRAM window
configuration must be saved on suspend, and restored on
resume. However, it needs to be restored on resume *before*
re-entering the kernel, because the SDRAM window configuration defines
the layout of the memory. For this reason, it cannot simply be done in
the ->suspend() and ->resume() hooks of the mvebu-mbus driver.

Instead, it needs to be restored by the bootloader "boot info"
mechanism used when resuming. This mechanism allows the kernel to
define a list of (address, value) pairs when suspending, that the
bootloader will restore on resume before jumping back into the kernel.

This commit therefore adds a new function to the mvebu-mbus driver,
called mvebu_mbus_save_cpu_target(), which will be called by the
platform code to make the mvebu-mbus driver save the SDRAM window
configuration in a way that can be understood by the bootloader "boot
info" mechanism.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mbus.h     |  1 +
 2 files changed, 57 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 25b5b35..1d354e7 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -110,6 +110,8 @@ struct mvebu_mbus_soc_data {
 	bool has_mbus_bridge;
 	unsigned int (*win_cfg_offset)(const int win);
 	void (*setup_cpu_target)(struct mvebu_mbus_state *s);
+	int (*save_cpu_target)(struct mvebu_mbus_state *s,
+			       u32 *store_addr);
 	int (*show_cpu_target)(struct mvebu_mbus_state *s,
 			       struct seq_file *seq, void *v);
 };
@@ -128,6 +130,7 @@ struct mvebu_mbus_state {
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
+	phys_addr_t sdramwins_phys_base;
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_sdram;
 	struct dentry *debugfs_devs;
@@ -541,6 +544,28 @@ mvebu_mbus_default_setup_cpu_target(struct mvebu_mbus_state *mbus)
 	mvebu_mbus_dram_info.num_cs = cs;
 }
 
+static int
+mvebu_mbus_default_save_cpu_target(struct mvebu_mbus_state *mbus,
+				   u32 *store_addr)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		u32 base = readl(mbus->sdramwins_base + DDR_BASE_CS_OFF(i));
+		u32 size = readl(mbus->sdramwins_base + DDR_SIZE_CS_OFF(i));
+
+		writel(mbus->sdramwins_phys_base + DDR_BASE_CS_OFF(i),
+		       store_addr++);
+		writel(base, store_addr++);
+		writel(mbus->sdramwins_phys_base + DDR_SIZE_CS_OFF(i),
+		       store_addr++);
+		writel(size, store_addr++);
+	}
+
+	/* We've written 16 words to the store address */
+	return 16;
+}
+
 static void __init
 mvebu_mbus_dove_setup_cpu_target(struct mvebu_mbus_state *mbus)
 {
@@ -571,11 +596,35 @@ mvebu_mbus_dove_setup_cpu_target(struct mvebu_mbus_state *mbus)
 	mvebu_mbus_dram_info.num_cs = cs;
 }
 
+static int
+mvebu_mbus_dove_save_cpu_target(struct mvebu_mbus_state *mbus,
+				u32 *store_addr)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		u32 map = readl(mbus->sdramwins_base + DOVE_DDR_BASE_CS_OFF(i));
+
+		writel(mbus->sdramwins_phys_base + DOVE_DDR_BASE_CS_OFF(i),
+		       store_addr++);
+		writel(map, store_addr++);
+	}
+
+	/* We've written 4 words to the store address */
+	return 4;
+}
+
+int mvebu_mbus_save_cpu_target(u32 *store_addr)
+{
+	return mbus_state.soc->save_cpu_target(&mbus_state, store_addr);
+}
+
 static const struct mvebu_mbus_soc_data armada_370_xp_mbus_data = {
 	.num_wins            = 20,
 	.num_remappable_wins = 8,
 	.has_mbus_bridge     = true,
 	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
+	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
@@ -584,6 +633,7 @@ static const struct mvebu_mbus_soc_data kirkwood_mbus_data = {
 	.num_wins            = 8,
 	.num_remappable_wins = 4,
 	.win_cfg_offset      = orion_mbus_win_offset,
+	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
@@ -592,6 +642,7 @@ static const struct mvebu_mbus_soc_data dove_mbus_data = {
 	.num_wins            = 8,
 	.num_remappable_wins = 4,
 	.win_cfg_offset      = orion_mbus_win_offset,
+	.save_cpu_target     = mvebu_mbus_dove_save_cpu_target,
 	.setup_cpu_target    = mvebu_mbus_dove_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_dove,
 };
@@ -604,6 +655,7 @@ static const struct mvebu_mbus_soc_data orion5x_4win_mbus_data = {
 	.num_wins            = 8,
 	.num_remappable_wins = 4,
 	.win_cfg_offset      = orion_mbus_win_offset,
+	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
@@ -612,6 +664,7 @@ static const struct mvebu_mbus_soc_data orion5x_2win_mbus_data = {
 	.num_wins            = 8,
 	.num_remappable_wins = 2,
 	.win_cfg_offset      = orion_mbus_win_offset,
+	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
@@ -620,6 +673,7 @@ static const struct mvebu_mbus_soc_data mv78xx0_mbus_data = {
 	.num_wins            = 14,
 	.num_remappable_wins = 8,
 	.win_cfg_offset      = mv78xx0_mbus_win_offset,
+	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
@@ -805,6 +859,8 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		return -ENOMEM;
 	}
 
+	mbus->sdramwins_phys_base = sdramwins_phys_base;
+
 	if (mbusbridge_phys_base) {
 		mbus->mbusbridge_base = ioremap(mbusbridge_phys_base,
 						mbusbridge_size);
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index 550c88f..611b69f 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -61,6 +61,7 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 }
 #endif
 
+int mvebu_mbus_save_cpu_target(u32 *store_addr);
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
 void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
 int mvebu_mbus_add_window_remap_by_id(unsigned int target,
-- 
2.0.0

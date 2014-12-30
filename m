From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Dec 2014 13:43:43 +0100
Subject: [PATCH 2/6] bus: mvebu-mbus: fix support of MBus window 13 on Armada
 XP/375/38x
In-Reply-To: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1419943428-18491-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Mazur <arg@semihalf.com>

On Armada XP, 375 and 38x the MBus window 13 has the remap capability,
like windows 0 to 7. However, the mvebu-mbus driver isn't currently
taking into account this special case, which means that when window 13
is actually used, the remap registers are left to 0, making the device
using this MBus window unavailable.

To make things even more fun, the hardware designers have chosen to
put the window 13 remap registers in a completely custom location,
using a logic that differs from the one used for all other remappable
windows.

To solve this problem, this commit:

 * Adds a SoC specific function to calculate offset of remap registers
   to the mvebu_mbus_soc_data structure. This function,
   ->win_remap_offset(), returns the offset of the remap registers, or
   MVEBU_MBUS_NO_REMAP if the window does not have the remap
   capability. This new function replaces the previous integer field
   num_remappable_wins, which was insufficient to encode the special
   case of window 13.

 * Adds an implementation of the ->win_remap_offset() function for the
   various SoC families. Some have 2 first windows that are remapable,
   some the 4 first, some the 8 first, and then the Armada XP/375/38x
   case where the 8 first are remapable plus the special window
   13. This is implemented in functions
   generic_mbus_win_remap_2_offset(),
   generic_mbus_win_remap_4_offset(),
   generic_mbus_win_remap_8_offset() and
   armada_xp_mbus_win_remap_offset() respectively.

 * Change the code to use the ->win_remap_offset() function when
   accessing the remap registers, and also to use a newly introduced
   mvebu_mbus_window_is_remappable() helper function that tells
   whether a given window is remapable or not.

 * Separate Armada 370 from XP/375/38X because the window 13 of Armada
   370 does not support the remap capability.

[Thomas: adapted for the mainline kernel, minor clarifications in the
code, reword the commit log.]

Fixes: fddddb52a6c ("bus: introduce an Marvell EBU MBus driver")
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Michal Mazur <arg@semihalf.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 153 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 116 insertions(+), 37 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index eb7682d..b6694df 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -106,9 +106,9 @@ struct mvebu_mbus_state;
 
 struct mvebu_mbus_soc_data {
 	unsigned int num_wins;
-	unsigned int num_remappable_wins;
 	bool has_mbus_bridge;
 	unsigned int (*win_cfg_offset)(const int win);
+	unsigned int (*win_remap_offset)(const int win);
 	void (*setup_cpu_target)(struct mvebu_mbus_state *s);
 	int (*save_cpu_target)(struct mvebu_mbus_state *s,
 			       u32 *store_addr);
@@ -154,6 +154,13 @@ const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 }
 EXPORT_SYMBOL_GPL(mv_mbus_dram_info);
 
+/* Checks whether the given window has remap capability */
+static bool mvebu_mbus_window_is_remappable(struct mvebu_mbus_state *mbus,
+					    const int win)
+{
+	return mbus->soc->win_remap_offset(win) != MVEBU_MBUS_NO_REMAP;
+}
+
 /*
  * Functions to manipulate the address decoding windows
  */
@@ -185,9 +192,12 @@ static void mvebu_mbus_read_window(struct mvebu_mbus_state *mbus,
 		*attr = (ctrlreg & WIN_CTRL_ATTR_MASK) >> WIN_CTRL_ATTR_SHIFT;
 
 	if (remap) {
-		if (win < mbus->soc->num_remappable_wins) {
-			u32 remap_low = readl(addr + WIN_REMAP_LO_OFF);
-			u32 remap_hi  = readl(addr + WIN_REMAP_HI_OFF);
+		if (mvebu_mbus_window_is_remappable(mbus, win)) {
+			u32 remap_low, remap_hi;
+			void __iomem *addr_rmp = mbus->mbuswins_base +
+				mbus->soc->win_remap_offset(win);
+			remap_low = readl(addr_rmp + WIN_REMAP_LO_OFF);
+			remap_hi  = readl(addr_rmp + WIN_REMAP_HI_OFF);
 			*remap = ((u64)remap_hi << 32) | remap_low;
 		} else
 			*remap = 0;
@@ -200,10 +210,11 @@ static void mvebu_mbus_disable_window(struct mvebu_mbus_state *mbus,
 	void __iomem *addr;
 
 	addr = mbus->mbuswins_base + mbus->soc->win_cfg_offset(win);
-
 	writel(0, addr + WIN_BASE_OFF);
 	writel(0, addr + WIN_CTRL_OFF);
-	if (win < mbus->soc->num_remappable_wins) {
+
+	if (mvebu_mbus_window_is_remappable(mbus, win)) {
+		addr = mbus->mbuswins_base + mbus->soc->win_remap_offset(win);
 		writel(0, addr + WIN_REMAP_LO_OFF);
 		writel(0, addr + WIN_REMAP_HI_OFF);
 	}
@@ -307,13 +318,17 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 
 	writel(base & WIN_BASE_LOW, addr + WIN_BASE_OFF);
 	writel(ctrl, addr + WIN_CTRL_OFF);
-	if (win < mbus->soc->num_remappable_wins) {
+
+	if (mvebu_mbus_window_is_remappable(mbus, win)) {
+		void __iomem *addr_rmp = mbus->mbuswins_base +
+			mbus->soc->win_remap_offset(win);
+
 		if (remap == MVEBU_MBUS_NO_REMAP)
 			remap_addr = base;
 		else
 			remap_addr = remap;
-		writel(remap_addr & WIN_REMAP_LOW, addr + WIN_REMAP_LO_OFF);
-		writel(0, addr + WIN_REMAP_HI_OFF);
+		writel(remap_addr & WIN_REMAP_LOW, addr_rmp + WIN_REMAP_LO_OFF);
+		writel(0, addr_rmp + WIN_REMAP_HI_OFF);
 	}
 
 	return 0;
@@ -327,19 +342,27 @@ static int mvebu_mbus_alloc_window(struct mvebu_mbus_state *mbus,
 	int win;
 
 	if (remap == MVEBU_MBUS_NO_REMAP) {
-		for (win = mbus->soc->num_remappable_wins;
-		     win < mbus->soc->num_wins; win++)
+		for (win = 0; win < mbus->soc->num_wins; win++) {
+			if (mvebu_mbus_window_is_remappable(mbus, win))
+				continue;
+
 			if (mvebu_mbus_window_is_free(mbus, win))
 				return mvebu_mbus_setup_window(mbus, win, base,
 							       size, remap,
 							       target, attr);
+		}
 	}
 
+	for (win = 0; win < mbus->soc->num_wins; win++) {
+		/* Skip window if need remap but is not supported */
+		if ((remap != MVEBU_MBUS_NO_REMAP) &&
+		    !mvebu_mbus_window_is_remappable(mbus, win))
+			continue;
 
-	for (win = 0; win < mbus->soc->num_wins; win++)
 		if (mvebu_mbus_window_is_free(mbus, win))
 			return mvebu_mbus_setup_window(mbus, win, base, size,
 						       remap, target, attr);
+	}
 
 	return -ENOMEM;
 }
@@ -451,7 +474,7 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 		    ((wbase & (u64)(wsize - 1)) != 0))
 			seq_puts(seq, " (Invalid base/size!!)");
 
-		if (win < mbus->soc->num_remappable_wins) {
+		if (mvebu_mbus_window_is_remappable(mbus, win)) {
 			seq_printf(seq, " (remap %016llx)\n",
 				   (unsigned long long)wremap);
 		} else
@@ -477,12 +500,12 @@ static const struct file_operations mvebu_devs_debug_fops = {
  * SoC-specific functions and definitions
  */
 
-static unsigned int orion_mbus_win_offset(int win)
+static unsigned int generic_mbus_win_cfg_offset(int win)
 {
 	return win << 4;
 }
 
-static unsigned int armada_370_xp_mbus_win_offset(int win)
+static unsigned int armada_370_xp_mbus_win_cfg_offset(int win)
 {
 	/* The register layout is a bit annoying and the below code
 	 * tries to cope with it.
@@ -502,7 +525,7 @@ static unsigned int armada_370_xp_mbus_win_offset(int win)
 		return 0x90 + ((win - 8) << 3);
 }
 
-static unsigned int mv78xx0_mbus_win_offset(int win)
+static unsigned int mv78xx0_mbus_win_cfg_offset(int win)
 {
 	if (win < 8)
 		return win << 4;
@@ -510,6 +533,40 @@ static unsigned int mv78xx0_mbus_win_offset(int win)
 		return 0x900 + ((win - 8) << 4);
 }
 
+static unsigned int generic_mbus_win_remap_2_offset(int win)
+{
+	if (win < 2)
+		return generic_mbus_win_cfg_offset(win);
+	else
+		return MVEBU_MBUS_NO_REMAP;
+}
+
+static unsigned int generic_mbus_win_remap_4_offset(int win)
+{
+	if (win < 4)
+		return generic_mbus_win_cfg_offset(win);
+	else
+		return MVEBU_MBUS_NO_REMAP;
+}
+
+static unsigned int generic_mbus_win_remap_8_offset(int win)
+{
+	if (win < 8)
+		return generic_mbus_win_cfg_offset(win);
+	else
+		return MVEBU_MBUS_NO_REMAP;
+}
+
+static unsigned int armada_xp_mbus_win_remap_offset(int win)
+{
+	if (win < 8)
+		return generic_mbus_win_cfg_offset(win);
+	else if (win == 13)
+		return 0xF0 - WIN_REMAP_LO_OFF;
+	else
+		return MVEBU_MBUS_NO_REMAP;
+}
+
 static void __init
 mvebu_mbus_default_setup_cpu_target(struct mvebu_mbus_state *mbus)
 {
@@ -619,30 +676,40 @@ int mvebu_mbus_save_cpu_target(u32 *store_addr)
 	return mbus_state.soc->save_cpu_target(&mbus_state, store_addr);
 }
 
-static const struct mvebu_mbus_soc_data armada_370_xp_mbus_data = {
+static const struct mvebu_mbus_soc_data armada_370_mbus_data = {
 	.num_wins            = 20,
-	.num_remappable_wins = 8,
 	.has_mbus_bridge     = true,
-	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
+	.win_cfg_offset      = armada_370_xp_mbus_win_cfg_offset,
+	.win_remap_offset    = generic_mbus_win_remap_8_offset,
+	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
+	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
+};
+
+static const struct mvebu_mbus_soc_data armada_xp_mbus_data = {
+	.num_wins            = 20,
+	.has_mbus_bridge     = true,
+	.win_cfg_offset      = armada_370_xp_mbus_win_cfg_offset,
+	.win_remap_offset    = armada_xp_mbus_win_remap_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
+	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
 };
 
 static const struct mvebu_mbus_soc_data kirkwood_mbus_data = {
 	.num_wins            = 8,
-	.num_remappable_wins = 4,
-	.win_cfg_offset      = orion_mbus_win_offset,
+	.win_cfg_offset      = generic_mbus_win_cfg_offset,
 	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
+	.win_remap_offset    = generic_mbus_win_remap_4_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
 
 static const struct mvebu_mbus_soc_data dove_mbus_data = {
 	.num_wins            = 8,
-	.num_remappable_wins = 4,
-	.win_cfg_offset      = orion_mbus_win_offset,
+	.win_cfg_offset      = generic_mbus_win_cfg_offset,
 	.save_cpu_target     = mvebu_mbus_dove_save_cpu_target,
+	.win_remap_offset    = generic_mbus_win_remap_4_offset,
 	.setup_cpu_target    = mvebu_mbus_dove_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_dove,
 };
@@ -653,36 +720,40 @@ static const struct mvebu_mbus_soc_data dove_mbus_data = {
  */
 static const struct mvebu_mbus_soc_data orion5x_4win_mbus_data = {
 	.num_wins            = 8,
-	.num_remappable_wins = 4,
-	.win_cfg_offset      = orion_mbus_win_offset,
+	.win_cfg_offset      = generic_mbus_win_cfg_offset,
 	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
+	.win_remap_offset    = generic_mbus_win_remap_4_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
 
 static const struct mvebu_mbus_soc_data orion5x_2win_mbus_data = {
 	.num_wins            = 8,
-	.num_remappable_wins = 2,
-	.win_cfg_offset      = orion_mbus_win_offset,
+	.win_cfg_offset      = generic_mbus_win_cfg_offset,
 	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
+	.win_remap_offset    = generic_mbus_win_remap_2_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
 
 static const struct mvebu_mbus_soc_data mv78xx0_mbus_data = {
 	.num_wins            = 14,
-	.num_remappable_wins = 8,
-	.win_cfg_offset      = mv78xx0_mbus_win_offset,
+	.win_cfg_offset      = mv78xx0_mbus_win_cfg_offset,
 	.save_cpu_target     = mvebu_mbus_default_save_cpu_target,
+	.win_remap_offset    = generic_mbus_win_remap_8_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
 };
 
 static const struct of_device_id of_mvebu_mbus_ids[] = {
 	{ .compatible = "marvell,armada370-mbus",
-	  .data = &armada_370_xp_mbus_data, },
+	  .data = &armada_370_mbus_data, },
+	{ .compatible = "marvell,armada375-mbus",
+	  .data = &armada_xp_mbus_data, },
+	{ .compatible = "marvell,armada380-mbus",
+	  .data = &armada_xp_mbus_data, },
 	{ .compatible = "marvell,armadaxp-mbus",
-	  .data = &armada_370_xp_mbus_data, },
+	  .data = &armada_xp_mbus_data, },
 	{ .compatible = "marvell,kirkwood-mbus",
 	  .data = &kirkwood_mbus_data, },
 	{ .compatible = "marvell,dove-mbus",
@@ -789,15 +860,19 @@ static int mvebu_mbus_suspend(void)
 	for (win = 0; win < s->soc->num_wins; win++) {
 		void __iomem *addr = s->mbuswins_base +
 			s->soc->win_cfg_offset(win);
+		void __iomem *addr_rmp;
 
 		s->wins[win].base = readl(addr + WIN_BASE_OFF);
 		s->wins[win].ctrl = readl(addr + WIN_CTRL_OFF);
 
-		if (win >= s->soc->num_remappable_wins)
+		if (!mvebu_mbus_window_is_remappable(s, win))
 			continue;
 
-		s->wins[win].remap_lo = readl(addr + WIN_REMAP_LO_OFF);
-		s->wins[win].remap_hi = readl(addr + WIN_REMAP_HI_OFF);
+		addr_rmp = s->mbuswins_base +
+			s->soc->win_remap_offset(win);
+
+		s->wins[win].remap_lo = readl(addr_rmp + WIN_REMAP_LO_OFF);
+		s->wins[win].remap_hi = readl(addr_rmp + WIN_REMAP_HI_OFF);
 	}
 
 	s->mbus_bridge_ctrl = readl(s->mbusbridge_base +
@@ -821,15 +896,19 @@ static void mvebu_mbus_resume(void)
 	for (win = 0; win < s->soc->num_wins; win++) {
 		void __iomem *addr = s->mbuswins_base +
 			s->soc->win_cfg_offset(win);
+		void __iomem *addr_rmp;
 
 		writel(s->wins[win].base, addr + WIN_BASE_OFF);
 		writel(s->wins[win].ctrl, addr + WIN_CTRL_OFF);
 
-		if (win >= s->soc->num_remappable_wins)
+		if (!mvebu_mbus_window_is_remappable(s, win))
 			continue;
 
-		writel(s->wins[win].remap_lo, addr + WIN_REMAP_LO_OFF);
-		writel(s->wins[win].remap_hi, addr + WIN_REMAP_HI_OFF);
+		addr_rmp = s->mbuswins_base +
+			s->soc->win_remap_offset(win);
+
+		writel(s->wins[win].remap_lo, addr_rmp + WIN_REMAP_LO_OFF);
+		writel(s->wins[win].remap_hi, addr_rmp + WIN_REMAP_HI_OFF);
 	}
 }
 
-- 
2.1.0

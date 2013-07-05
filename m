From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:23 -0300
Subject: [PATCH v6 12/21] bus: mvebu-mbus: Remove name -> target,
 attribute mapping tables
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-13-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This tables were used together with the name-based MBus window
creation API. Since that's has been removed, we can also remove
the tables.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 150 +++--------------------------------------------
 1 file changed, 7 insertions(+), 143 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index db68436..8240bd7 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -97,33 +97,6 @@
 
 #define DOVE_DDR_BASE_CS_OFF(n) ((n) << 4)
 
-struct mvebu_mbus_mapping {
-	const char *name;
-	u8 target;
-	u8 attr;
-	u8 attrmask;
-};
-
-/*
- * Masks used for the 'attrmask' field of mvebu_mbus_mapping. They
- * allow to get the real attribute value, discarding the special bits
- * used to select a PCI MEM region or a PCI WA region. This allows the
- * debugfs code to reverse-match the name of a device from its
- * target/attr values.
- *
- * For all devices except PCI, all bits of 'attr' must be
- * considered. For most SoCs, only bit 3 should be ignored (it allows
- * to select between PCI MEM and PCI I/O). On Orion5x however, there
- * is the special bit 5 to select a PCI WA region.
- */
-#define MAPDEF_NOMASK       0xff
-#define MAPDEF_PCIMASK      0xf7
-#define MAPDEF_ORIONPCIMASK 0xd7
-
-/* Macro used to define one mvebu_mbus_mapping entry */
-#define MAPDEF(__n, __t, __a, __m) \
-	{ .name = __n, .target = __t, .attr = __a, .attrmask = __m }
-
 struct mvebu_mbus_state;
 
 struct mvebu_mbus_soc_data {
@@ -133,7 +106,6 @@ struct mvebu_mbus_soc_data {
 	void (*setup_cpu_target)(struct mvebu_mbus_state *s);
 	int (*show_cpu_target)(struct mvebu_mbus_state *s,
 			       struct seq_file *seq, void *v);
-	const struct mvebu_mbus_mapping *map;
 };
 
 struct mvebu_mbus_state {
@@ -428,8 +400,7 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 		u64 wbase, wremap;
 		u32 wsize;
 		u8 wtarget, wattr;
-		int enabled, i;
-		const char *name;
+		int enabled;
 
 		mvebu_mbus_read_window(mbus, win,
 				       &enabled, &wbase, &wsize,
@@ -440,18 +411,9 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 			continue;
 		}
 
-
-		for (i = 0; mbus->soc->map[i].name; i++)
-			if (mbus->soc->map[i].target == wtarget &&
-			    mbus->soc->map[i].attr ==
-			    (wattr & mbus->soc->map[i].attrmask))
-				break;
-
-		name = mbus->soc->map[i].name ?: "unknown";
-
-		seq_printf(seq, "[%02d] %016llx - %016llx : %s",
+		seq_printf(seq, "[%02d] %016llx - %016llx : %04x:%04x\n",
 			   win, (unsigned long long)wbase,
-			   (unsigned long long)(wbase + wsize), name);
+			   (unsigned long long)(wbase + wsize), wtarget, wattr);
 
 		if (win < mbus->soc->num_remappable_wins) {
 			seq_printf(seq, " (remap %016llx)\n",
@@ -576,45 +538,12 @@ mvebu_mbus_dove_setup_cpu_target(struct mvebu_mbus_state *mbus)
 	mvebu_mbus_dram_info.num_cs = cs;
 }
 
-static const struct mvebu_mbus_mapping armada_370_map[] = {
-	MAPDEF("bootrom",     1, 0xe0, MAPDEF_NOMASK),
-	MAPDEF("devbus-boot", 1, 0x2f, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs0",  1, 0x3e, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs1",  1, 0x3d, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs2",  1, 0x3b, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs3",  1, 0x37, MAPDEF_NOMASK),
-	MAPDEF("pcie0.0",     4, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.0",     8, 0xe0, MAPDEF_PCIMASK),
-	{},
-};
-
 static const struct mvebu_mbus_soc_data armada_370_mbus_data = {
 	.num_wins            = 20,
 	.num_remappable_wins = 8,
 	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-	.map                 = armada_370_map,
-};
-
-static const struct mvebu_mbus_mapping armada_xp_map[] = {
-	MAPDEF("bootrom",     1, 0x1d, MAPDEF_NOMASK),
-	MAPDEF("devbus-boot", 1, 0x2f, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs0",  1, 0x3e, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs1",  1, 0x3d, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs2",  1, 0x3b, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs3",  1, 0x37, MAPDEF_NOMASK),
-	MAPDEF("pcie0.0",     4, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie0.1",     4, 0xd0, MAPDEF_PCIMASK),
-	MAPDEF("pcie0.2",     4, 0xb0, MAPDEF_PCIMASK),
-	MAPDEF("pcie0.3",     4, 0x70, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.0",     8, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.1",     8, 0xd0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.2",     8, 0xb0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.3",     8, 0x70, MAPDEF_PCIMASK),
-	MAPDEF("pcie2.0",     4, 0xf0, MAPDEF_PCIMASK),
-	MAPDEF("pcie3.0",     8, 0xf0, MAPDEF_PCIMASK),
-	{},
 };
 
 static const struct mvebu_mbus_soc_data armada_xp_mbus_data = {
@@ -623,15 +552,6 @@ static const struct mvebu_mbus_soc_data armada_xp_mbus_data = {
 	.win_cfg_offset      = armada_370_xp_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-	.map                 = armada_xp_map,
-};
-
-static const struct mvebu_mbus_mapping kirkwood_map[] = {
-	MAPDEF("pcie0.0", 4, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.0", 4, 0xd0, MAPDEF_PCIMASK),
-	MAPDEF("sram",    3, 0x01, MAPDEF_NOMASK),
-	MAPDEF("nand",    1, 0x2f, MAPDEF_NOMASK),
-	{},
 };
 
 static const struct mvebu_mbus_soc_data kirkwood_mbus_data = {
@@ -640,16 +560,6 @@ static const struct mvebu_mbus_soc_data kirkwood_mbus_data = {
 	.win_cfg_offset      = orion_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-	.map                 = kirkwood_map,
-};
-
-static const struct mvebu_mbus_mapping dove_map[] = {
-	MAPDEF("pcie0.0",    0x4, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.0",    0x8, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("cesa",       0x3, 0x01, MAPDEF_NOMASK),
-	MAPDEF("bootrom",    0x1, 0xfd, MAPDEF_NOMASK),
-	MAPDEF("scratchpad", 0xd, 0x0, MAPDEF_NOMASK),
-	{},
 };
 
 static const struct mvebu_mbus_soc_data dove_mbus_data = {
@@ -658,18 +568,6 @@ static const struct mvebu_mbus_soc_data dove_mbus_data = {
 	.win_cfg_offset      = orion_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_dove_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_dove,
-	.map                 = dove_map,
-};
-
-static const struct mvebu_mbus_mapping orion5x_map[] = {
-	MAPDEF("pcie0.0",     4, 0x51, MAPDEF_ORIONPCIMASK),
-	MAPDEF("pci0.0",      3, 0x51, MAPDEF_ORIONPCIMASK),
-	MAPDEF("devbus-boot", 1, 0x0f, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs0",  1, 0x1e, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs1",  1, 0x1d, MAPDEF_NOMASK),
-	MAPDEF("devbus-cs2",  1, 0x1b, MAPDEF_NOMASK),
-	MAPDEF("sram",        0, 0x00, MAPDEF_NOMASK),
-	{},
 };
 
 /*
@@ -682,7 +580,6 @@ static const struct mvebu_mbus_soc_data orion5x_4win_mbus_data = {
 	.win_cfg_offset      = orion_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-	.map                 = orion5x_map,
 };
 
 static const struct mvebu_mbus_soc_data orion5x_2win_mbus_data = {
@@ -691,21 +588,6 @@ static const struct mvebu_mbus_soc_data orion5x_2win_mbus_data = {
 	.win_cfg_offset      = orion_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-	.map                 = orion5x_map,
-};
-
-static const struct mvebu_mbus_mapping mv78xx0_map[] = {
-	MAPDEF("pcie0.0", 4, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie0.1", 4, 0xd0, MAPDEF_PCIMASK),
-	MAPDEF("pcie0.2", 4, 0xb0, MAPDEF_PCIMASK),
-	MAPDEF("pcie0.3", 4, 0x70, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.0", 8, 0xe0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.1", 8, 0xd0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.2", 8, 0xb0, MAPDEF_PCIMASK),
-	MAPDEF("pcie1.3", 8, 0x70, MAPDEF_PCIMASK),
-	MAPDEF("pcie2.0", 4, 0xf0, MAPDEF_PCIMASK),
-	MAPDEF("pcie3.0", 8, 0xf0, MAPDEF_PCIMASK),
-	{},
 };
 
 static const struct mvebu_mbus_soc_data mv78xx0_mbus_data = {
@@ -714,7 +596,6 @@ static const struct mvebu_mbus_soc_data mv78xx0_mbus_data = {
 	.win_cfg_offset      = mv78xx0_mbus_win_offset,
 	.setup_cpu_target    = mvebu_mbus_default_setup_cpu_target,
 	.show_cpu_target     = mvebu_sdram_debug_show_orion,
-	.map                 = mv78xx0_map,
 };
 
 /*
@@ -879,33 +760,16 @@ static int __init mbus_dt_setup_win(struct mvebu_mbus_state *mbus,
 				    u32 base, u32 size,
 				    u8 target, u8 attr)
 {
-	const struct mvebu_mbus_mapping *map = mbus->soc->map;
-	const char *name;
-	int i;
-
-	/* Search for a suitable window in the existing mappings */
-	for (i = 0; map[i].name; i++)
-		if (map[i].target == target &&
-		    map[i].attr == (attr & map[i].attrmask))
-			break;
-
-	name = map[i].name;
-	if (!name) {
-		pr_err("window 0x%x:0x%x is unknown, skipping\n",
-		       target, attr);
-		return -EINVAL;
-	}
-
 	if (!mvebu_mbus_window_conflicts(mbus, base, size, target, attr)) {
-		pr_err("cannot add window '%s', conflicts with another window\n",
-		       name);
+		pr_err("cannot add window '%04x:%04x', conflicts with another window\n",
+		       target, attr);
 		return -EBUSY;
 	}
 
 	if (mvebu_mbus_alloc_window(mbus, base, size, MVEBU_MBUS_NO_REMAP,
 				    target, attr)) {
-		pr_err("cannot add window '%s', too many windows\n",
-		       name);
+		pr_err("cannot add window '%04x:%04x', too many windows\n",
+		       target, attr);
 		return -ENOMEM;
 	}
 	return 0;
-- 
1.8.1.5

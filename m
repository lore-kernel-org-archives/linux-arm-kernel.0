From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 16:16:18 +0100
Subject: [PATCH 1/2] bus: mvebu-mbus: fix __iomem on register pointers
Message-ID: <1466522179-22198-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The save_cpu_target functions should take "u32 __iomem *", not a
plain "u32 *" as it is passed to register access functions. Fix
the following warnings by adding the annotation:

drivers/bus/mvebu-mbus.c:739:17: warning: incorrect type in argument 2 (different address spaces)
drivers/bus/mvebu-mbus.c:739:17:    expected void volatile [noderef] <asn:2>*addr
drivers/bus/mvebu-mbus.c:739:17:    got unsigned int [usertype] *
drivers/bus/mvebu-mbus.c:741:17: warning: incorrect type in argument 2 (different address spaces)
drivers/bus/mvebu-mbus.c:741:17:    expected void volatile [noderef] <asn:2>*addr
drivers/bus/mvebu-mbus.c:741:17:    got unsigned int [usertype] *
drivers/bus/mvebu-mbus.c:742:17: warning: incorrect type in argument 2 (different address spaces)
drivers/bus/mvebu-mbus.c:742:17:    expected void volatile [noderef] <asn:2>*addr
drivers/bus/mvebu-mbus.c:742:17:    got unsigned int [usertype] *
drivers/bus/mvebu-mbus.c:744:17: warning: incorrect type in argument 2 (different address spaces)
drivers/bus/mvebu-mbus.c:744:17:    expected void volatile [noderef] <asn:2>*addr
drivers/bus/mvebu-mbus.c:744:17:    got unsigned int [usertype] *
drivers/bus/mvebu-mbus.c:790:17: warning: incorrect type in argument 2 (different address spaces)
drivers/bus/mvebu-mbus.c:790:17:    expected void volatile [noderef] <asn:2>*addr
drivers/bus/mvebu-mbus.c:790:17:    got unsigned int [usertype] *
drivers/bus/mvebu-mbus.c:792:17: warning: incorrect type in argument 2 (different address spaces)
drivers/bus/mvebu-mbus.c:792:17:    expected void volatile [noderef] <asn:2>*addr
drivers/bus/mvebu-mbus.c:792:17:    got unsigned int [usertype] *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Evan Wang <xswang@marvell.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/bus/mvebu-mbus.c | 8 ++++----
 include/linux/mbus.h     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index ce54a01..8cac3b8 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -117,7 +117,7 @@ struct mvebu_mbus_soc_data {
 	unsigned int (*win_remap_offset)(const int win);
 	void (*setup_cpu_target)(struct mvebu_mbus_state *s);
 	int (*save_cpu_target)(struct mvebu_mbus_state *s,
-			       u32 *store_addr);
+			       u32 __iomem *store_addr);
 	int (*show_cpu_target)(struct mvebu_mbus_state *s,
 			       struct seq_file *seq, void *v);
 };
@@ -728,7 +728,7 @@ mvebu_mbus_default_setup_cpu_target(struct mvebu_mbus_state *mbus)
 
 static int
 mvebu_mbus_default_save_cpu_target(struct mvebu_mbus_state *mbus,
-				   u32 *store_addr)
+				   u32 __iomem *store_addr)
 {
 	int i;
 
@@ -780,7 +780,7 @@ mvebu_mbus_dove_setup_cpu_target(struct mvebu_mbus_state *mbus)
 
 static int
 mvebu_mbus_dove_save_cpu_target(struct mvebu_mbus_state *mbus,
-				u32 *store_addr)
+				u32 __iomem *store_addr)
 {
 	int i;
 
@@ -796,7 +796,7 @@ mvebu_mbus_dove_save_cpu_target(struct mvebu_mbus_state *mbus,
 	return 4;
 }
 
-int mvebu_mbus_save_cpu_target(u32 *store_addr)
+int mvebu_mbus_save_cpu_target(u32 __iomem *store_addr)
 {
 	return mbus_state.soc->save_cpu_target(&mbus_state, store_addr);
 }
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index ea34a86..d610232 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -66,7 +66,7 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(vo
 }
 #endif
 
-int mvebu_mbus_save_cpu_target(u32 *store_addr);
+int mvebu_mbus_save_cpu_target(u32 __iomem *store_addr);
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
 void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
 int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr);
-- 
2.8.1

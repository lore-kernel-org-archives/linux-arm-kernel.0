From: sr@denx.de (Stefan Roese)
Date: Thu,  1 Sep 2016 11:39:03 +0200
Subject: [PATCH 1/2 v2] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
Message-ID: <20160901093904.26564-1-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides a stub function for mvebu_mbus_get_io_win_info(),
which will be used for all non-Orion (ARM32 MVEBU) platforms for
compile test coverage.

On such platforms this function will return an error so that drivers
might detect a potential problem.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Marcin Wojtas <mw@semihalf.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>
---
v2:
- Return error code in stub function. This may be useful on Armada 3700
  boards. As Armada 3700 does not implement the MBus driver but some
  device driver might call into these functions anyways (e.g. mvneta).

 include/linux/mbus.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index d610232..ad0c7f2 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -55,6 +55,8 @@ struct mbus_dram_target_info
 #ifdef CONFIG_PLAT_ORION
 extern const struct mbus_dram_target_info *mv_mbus_dram_info(void);
 extern const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(void);
+int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size, u8 *target,
+			       u8 *attr);
 #else
 static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 {
@@ -64,14 +66,24 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info_nooverlap(vo
 {
 	return NULL;
 }
+static inline int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size,
+					     u8 *target, u8 *attr)
+{
+	/*
+	 * On all ARM32 MVEBU platforms with MBus support, this stub
+	 * function will not get called. The real function from the
+	 * MBus driver is called instead. ARM64 MVEBU platforms like
+	 * the Armada 3700 could do use the mv_xor device which calls
+	 * into this function
+	 */
+	return -EINVAL;
+}
 #endif
 
 int mvebu_mbus_save_cpu_target(u32 __iomem *store_addr);
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
 void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
 int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr);
-int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size, u8 *target,
-			       u8 *attr);
 int mvebu_mbus_add_window_remap_by_id(unsigned int target,
 				      unsigned int attribute,
 				      phys_addr_t base, size_t size,
-- 
2.9.3

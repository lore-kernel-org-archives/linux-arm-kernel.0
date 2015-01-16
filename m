From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Jan 2015 17:11:28 +0100
Subject: [PATCHv2 2/3] bus: mvebu-mbus: use automatic I/O synchronization
 barriers
In-Reply-To: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1421424689-5971-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1421424689-5971-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using explicit I/O synchronization barriers shoehorned
inside the streaming DMA mappings API (in
arch/arm/mach-mvebu/coherency.c), we are switching to use automatic
I/O synchronization barrier.

The primary motivation for this change is that explicit I/O
synchronization barriers are not only needed for streaming DMA
mappings (which can easily be done by overriding the dma_map_ops), but
also for coherent DMA mappings (which is a lot less easy to do, since
the kernel assumes such mappings are coherent and don't require any
sort of cache maintenance operation to ensure the consistency of the
buffers).

Switching to automatic I/O synchronization barriers will also allow us
to use the existing arm_coherent_dma_ops instead of our custom
arm_dma_ops.

In order to use automatic I/O synchronization barriers, this commit
changes mvebu-mbus in two ways:

 - It enables automatic I/O synchronization barriers in the 0x84
   register of the MBus bridge, by enabling such barriers for all MBus
   units. This enables automatic barriers for the on-SoC peripherals
   that are doing DMA.

 - It enables the SyncEnable bit in the MBus windows, so that PCIe
   devices also use automatic I/O synchronization barrier.

This automatic synchronization barrier relies on the assumption that
at least one register of a given hardware unit is read before the
driver accesses the DMA mappings modified by this unit. This
assumption is guaranteed for PCI devices by vertue of the PCI
standard, and we can reasonably verify that this assumption is also
true for the limited number of platform drivers doing DMA used on
Marvell EBU platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index eb7682d..398f0ee 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -69,6 +69,7 @@
  */
 #define WIN_CTRL_OFF		0x0000
 #define   WIN_CTRL_ENABLE       BIT(0)
+#define   WIN_CTRL_SYNCBARRIER  BIT(1)
 #define   WIN_CTRL_TGT_MASK     0xf0
 #define   WIN_CTRL_TGT_SHIFT    4
 #define   WIN_CTRL_ATTR_MASK    0xff00
@@ -82,6 +83,9 @@
 #define   WIN_REMAP_LOW         0xffff0000
 #define WIN_REMAP_HI_OFF	0x000c
 
+#define UNIT_SYNC_BARRIER_OFF   0x84
+#define   UNIT_SYNC_BARRIER_ALL 0xFFFF
+
 #define ATTR_HW_COHERENCY	(0x1 << 4)
 
 #define DDR_BASE_CS_OFF(n)	(0x0000 + ((n) << 3))
@@ -303,6 +307,7 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
+		WIN_CTRL_SYNCBARRIER             |
 		WIN_CTRL_ENABLE;
 
 	writel(base & WIN_BASE_LOW, addr + WIN_BASE_OFF);
@@ -844,7 +849,8 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t sdramwins_phys_base,
 					 size_t sdramwins_size,
 					 phys_addr_t mbusbridge_phys_base,
-					 size_t mbusbridge_size)
+					 size_t mbusbridge_size,
+					 bool is_coherent)
 {
 	int win;
 
@@ -876,6 +882,10 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 
 	mbus->soc->setup_cpu_target(mbus);
 
+	if (is_coherent)
+		writel(UNIT_SYNC_BARRIER_ALL,
+		       mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
+
 	register_syscore_ops(&mvebu_mbus_syscore_ops);
 
 	return 0;
@@ -903,7 +913,7 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 			mbuswins_phys_base,
 			mbuswins_size,
 			sdramwins_phys_base,
-			sdramwins_size, 0, 0);
+			sdramwins_size, 0, 0, false);
 }
 
 #ifdef CONFIG_OF
@@ -1105,7 +1115,8 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 				     sdramwins_res.start,
 				     resource_size(&sdramwins_res),
 				     mbusbridge_res.start,
-				     resource_size(&mbusbridge_res));
+				     resource_size(&mbusbridge_res),
+				     is_coherent);
 	if (ret)
 		return ret;
 
-- 
2.1.0

From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:46 +0100
Subject: [PATCH v1 01/24] net: emaclite: Fix OF initialization
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <b8e85e23bced9484736ce557d4f0d97d24f6beb4.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add xilinx_emaclite_of_init to netdev.h
- Remove global data pointer from the driver
- Add better handling for error state.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 drivers/net/xilinx_emaclite.c | 15 ++++++++-------
 include/netdev.h              |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/xilinx_emaclite.c b/drivers/net/xilinx_emaclite.c
index 0a5209d..a607098 100644
--- a/drivers/net/xilinx_emaclite.c
+++ b/drivers/net/xilinx_emaclite.c
@@ -14,8 +14,6 @@
 #include <asm/io.h>
 #include <fdtdec.h>

-DECLARE_GLOBAL_DATA_PTR;
-
 #undef DEBUG

 #define ENET_ADDR_LENGTH	6
@@ -364,24 +362,27 @@ int xilinx_emaclite_initialize(bd_t *bis, unsigned long base_addr,
 }

 #ifdef CONFIG_OF_CONTROL
-int xilinx_emaclite_init(bd_t *bis)
+int xilinx_emaclite_of_init(const void *blob)
 {
 	int offset = 0;
 	u32 ret = 0;
 	u32 reg;

 	do {
-		offset = fdt_node_offset_by_compatible(gd->fdt_blob, offset,
+		offset = fdt_node_offset_by_compatible(blob, offset,
 					"xlnx,xps-ethernetlite-1.00.a");
 		if (offset != -1) {
-			reg = fdtdec_get_addr(gd->fdt_blob, offset, "reg");
+			reg = fdtdec_get_addr(blob, offset, "reg");
 			if (reg != FDT_ADDR_T_NONE) {
-				u32 rxpp = fdtdec_get_int(gd->fdt_blob, offset,
+				u32 rxpp = fdtdec_get_int(blob, offset,
 							"xlnx,rx-ping-pong", 0);
-				u32 txpp = fdtdec_get_int(gd->fdt_blob, offset,
+				u32 txpp = fdtdec_get_int(blob, offset,
 							"xlnx,tx-ping-pong", 0);
 				ret |= xilinx_emaclite_initialize(bis, reg,
 								txpp, rxpp);
+			} else {
+				debug("EMACLITE: Can't get base address\n");
+				return -1;
 			}
 		}
 	} while (offset != -1);
diff --git a/include/netdev.h b/include/netdev.h
index 47fa80d..25d1e46 100644
--- a/include/netdev.h
+++ b/include/netdev.h
@@ -86,6 +86,7 @@ int uli526x_initialize(bd_t *bis);
 int armada100_fec_register(unsigned long base_addr);
 int xilinx_axiemac_initialize(bd_t *bis, unsigned long base_addr,
 							unsigned long dma_addr);
+int xilinx_emaclite_of_init(const void *blob);
 int xilinx_emaclite_initialize(bd_t *bis, unsigned long base_addr,
 							int txpp, int rxpp);
 int xilinx_ll_temac_eth_init(bd_t *bis, unsigned long base_addr, int flags,
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/15c83014/attachment-0001.sig>

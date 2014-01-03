From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:49 +0100
Subject: [PATCH v1 04/24] zynq: Add OF ram initialization support
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <f928d7027756f3d5bc5d1a1f277dce3b2dadb864.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read ram size directly from DTB.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 board/xilinx/zynq/board.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 5119c09..6b691f3 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -5,6 +5,7 @@
  */

 #include <common.h>
+#include <fdtdec.h>
 #include <netdev.h>
 #include <zynqpl.h>
 #include <asm/arch/hardware.h>
@@ -115,8 +116,27 @@ int board_mmc_init(bd_t *bd)

 int dram_init(void)
 {
+#ifdef CONFIG_OF_CONTROL
+	int node;
+	fdt_addr_t addr;
+	fdt_size_t size;
+	const void *blob = gd->fdt_blob;
+
+	node = fdt_node_offset_by_prop_value(blob, -1, "device_type",
+					     "memory", 7);
+	if (node == -FDT_ERR_NOTFOUND) {
+		debug("ZYNQ DRAM: Can't get memory node\n");
+		return -1;
+	}
+	addr = fdtdec_get_addr_size(blob, node, "reg", &size);
+	if (addr == FDT_ADDR_T_NONE || size == 0) {
+		debug("ZYNQ DRAM: Can't get base address or size\n");
+		return -1;
+	}
+	gd->ram_size = size;
+#else
 	gd->ram_size = CONFIG_SYS_SDRAM_SIZE;
-
+#endif
 	zynq_ddrc_init();

 	return 0;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/455dd9e4/attachment.sig>

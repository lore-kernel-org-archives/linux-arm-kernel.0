From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:47 +0100
Subject: [PATCH v1 02/24] net: gem: Add OF initialization support
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <3033ad4cfeb6d552e5b1b7fc55599efff3e816d2.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gem can be directly initialized from DTB.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 drivers/net/zynq_gem.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/netdev.h       |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 6a017a8..a673fa7 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -12,6 +12,8 @@
 #include <common.h>
 #include <net.h>
 #include <config.h>
+#include <fdtdec.h>
+#include <libfdt.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <phy.h>
@@ -527,3 +529,43 @@ int zynq_gem_initialize(bd_t *bis, int base_addr, int phy_addr, u32 emio)

 	return 1;
 }
+
+#ifdef CONFIG_OF_CONTROL
+int zynq_gem_of_init(const void *blob)
+{
+	int offset = 0;
+	u32 ret = 0;
+	u32 reg, phy_reg;
+
+	debug("ZYNQ GEM: Initialization\n");
+
+	do {
+		offset = fdt_node_offset_by_compatible(blob, offset,
+					"xlnx,ps7-ethernet-1.00.a");
+		if (offset != -1) {
+			reg = fdtdec_get_addr(blob, offset, "reg");
+			if (reg != FDT_ADDR_T_NONE) {
+				offset = fdtdec_lookup_phandle(blob, offset,
+							       "phy-handle");
+				if (offset != -1)
+					phy_reg = fdtdec_get_addr(blob, offset,
+								  "reg");
+				else
+					phy_reg = 0;
+
+				debug("ZYNQ GEM: addr %x, phyaddr %x\n",
+				      reg, phy_reg);
+
+				ret |= zynq_gem_initialize(NULL, reg,
+							   phy_reg, 0);
+
+			} else {
+				debug("ZYNQ GEM: Can't get base address\n");
+				return -1;
+			}
+		}
+	} while (offset != -1);
+
+	return ret;
+}
+#endif
diff --git a/include/netdev.h b/include/netdev.h
index 25d1e46..b9eab0e 100644
--- a/include/netdev.h
+++ b/include/netdev.h
@@ -91,6 +91,7 @@ int xilinx_emaclite_initialize(bd_t *bis, unsigned long base_addr,
 							int txpp, int rxpp);
 int xilinx_ll_temac_eth_init(bd_t *bis, unsigned long base_addr, int flags,
 						unsigned long ctrl_addr);
+int zynq_gem_of_init(const void *blob);
 int zynq_gem_initialize(bd_t *bis, int base_addr, int phy_addr, u32 emio);
 /*
  * As long as the Xilinx xps_ll_temac ethernet driver has not its own interface
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/4b6b0366/attachment.sig>

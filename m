From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:48 +0100
Subject: [PATCH v1 03/24] mmc: zynq: Add OF initialization support
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <fffd8c3dc4caa1eee612c04f888f4af6fc5a75cf.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable initialize sdhci from DTB.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 arch/arm/include/asm/arch-zynq/sys_proto.h |  1 +
 drivers/mmc/zynq_sdhci.c                   | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/arch-zynq/sys_proto.h b/arch/arm/include/asm/arch-zynq/sys_proto.h
index 110de90..bb089b6 100644
--- a/arch/arm/include/asm/arch-zynq/sys_proto.h
+++ b/arch/arm/include/asm/arch-zynq/sys_proto.h
@@ -18,5 +18,6 @@ extern void zynq_ddrc_init(void);

 /* Driver extern functions */
 extern int zynq_sdhci_init(u32 regbase);
+extern int zynq_sdhci_of_init(const void *blob);

 #endif /* _SYS_PROTO_H_ */
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 610bef5..d39cbf0 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -7,6 +7,8 @@
  */

 #include <common.h>
+#include <fdtdec.h>
+#include <libfdt.h>
 #include <malloc.h>
 #include <sdhci.h>
 #include <asm/arch/sys_proto.h>
@@ -31,3 +33,30 @@ int zynq_sdhci_init(u32 regbase)
 	add_sdhci(host, 52000000, 52000000 >> 9);
 	return 0;
 }
+
+#ifdef CONFIG_OF_CONTROL
+int zynq_sdhci_of_init(const void *blob)
+{
+	int offset = 0;
+	u32 ret = 0;
+	u32 reg;
+
+	debug("ZYNQ SDHCI: Initialization\n");
+
+	do {
+		offset = fdt_node_offset_by_compatible(blob, offset,
+					"arasan,sdhci-8.9a");
+		if (offset != -1) {
+			reg = fdtdec_get_addr(blob, offset, "reg");
+			if (reg != FDT_ADDR_T_NONE) {
+				ret |= zynq_sdhci_init(reg);
+			} else {
+				debug("ZYNQ SDHCI: Can't get base address\n");
+				return -1;
+			}
+		}
+	} while (offset != -1);
+
+	return ret;
+}
+#endif
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/c40a8863/attachment.sig>

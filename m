From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 23 Jul 2013 10:31:14 -0300
Subject: [PATCH v8 10/28] bus: mvebu-mbus: Add new API for the PCIe memory and
 IO aperture
In-Reply-To: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374586292-4941-11-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We add two optional properties to the MBus DT binding, to encode
the PCIe memory and IO aperture. This allows such information to
be retrieved by -for instance- the pci driver to allocate the
MBus decoding windows.

Correspondingly, and in order to retrieve this information,
we add two new APIs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/bus/mvebu-mbus.txt         | 14 +++++++
 drivers/bus/mvebu-mbus.c                           | 49 ++++++++++++++++++++++
 include/linux/mbus.h                               |  4 ++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
index cce863f..960186f 100644
--- a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
+++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
@@ -20,6 +20,18 @@ Required properties:
 		 registers that control the MBus, which is typically contained
 		 within the internal register window (see below).
 
+Optional properties:
+
+- pcie-mem-aperture:	This optional property contains the aperture for
+			the memory region of the PCIe driver.
+			If it's defined, it must encode the base address and
+			size for the address decoding windows allocated for
+			the PCIe memory region.
+
+- pcie-io-aperture:	Just as explained for the above property, this
+			optional property contains the aperture for the
+			I/O region of the PCIe driver.
+
 * Marvell MBus controller
 
 Required properties:
@@ -38,6 +50,8 @@ Example:
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
+		pcie-mem-aperture = <0xe0000000 0x8000000>;
+		pcie-io-aperture  = <0xe8000000 0x100000>;
 
 		internal-regs {
 			compatible = "simple-bus";
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 78b8c04..929fed1 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -142,6 +142,8 @@ struct mvebu_mbus_state {
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_sdram;
 	struct dentry *debugfs_devs;
+	struct resource pcie_mem_aperture;
+	struct resource pcie_io_aperture;
 	const struct mvebu_mbus_soc_data *soc;
 	int hw_io_coherency;
 };
@@ -821,6 +823,20 @@ int mvebu_mbus_del_window(phys_addr_t base, size_t size)
 	return 0;
 }
 
+void mvebu_mbus_get_pcie_mem_aperture(struct resource *res)
+{
+	if (!res)
+		return;
+	*res = mbus_state.pcie_mem_aperture;
+}
+
+void mvebu_mbus_get_pcie_io_aperture(struct resource *res)
+{
+	if (!res)
+		return;
+	*res = mbus_state.pcie_io_aperture;
+}
+
 static __init int mvebu_mbus_debugfs_init(void)
 {
 	struct mvebu_mbus_state *s = &mbus_state;
@@ -1023,6 +1039,35 @@ static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
 	return 0;
 }
 
+static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
+						 struct resource *mem,
+						 struct resource *io)
+{
+	u32 reg[2];
+	int ret;
+
+	/*
+	 * These are optional, so we clear them and they'll
+	 * be zero if they are missing from the DT.
+	 */
+	memset(mem, 0, sizeof(struct resource));
+	memset(io, 0, sizeof(struct resource));
+
+	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
+	if (!ret) {
+		mem->start = reg[0];
+		mem->end = mem->start + reg[1];
+		mem->flags = IORESOURCE_MEM;
+	}
+
+	ret = of_property_read_u32_array(np, "pcie-io-aperture", reg, ARRAY_SIZE(reg));
+	if (!ret) {
+		io->start = reg[0];
+		io->end = io->start + reg[1];
+		io->flags = IORESOURCE_IO;
+	}
+}
+
 int __init mvebu_mbus_dt_init(void)
 {
 	struct resource mbuswins_res, sdramwins_res;
@@ -1062,6 +1107,10 @@ int __init mvebu_mbus_dt_init(void)
 		return -EINVAL;
 	}
 
+	/* Get optional pcie-{mem,io}-aperture properties */
+	mvebu_mbus_get_pcie_resources(np, &mbus_state.pcie_mem_aperture,
+					  &mbus_state.pcie_io_aperture);
+
 	ret = mvebu_mbus_common_init(&mbus_state,
 				     mbuswins_res.start,
 				     resource_size(&mbuswins_res),
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index eadefd6..650bc15 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -11,6 +11,8 @@
 #ifndef __LINUX_MBUS_H
 #define __LINUX_MBUS_H
 
+struct resource;
+
 struct mbus_dram_target_info
 {
 	/*
@@ -59,6 +61,8 @@ static inline const struct mbus_dram_target_info *mv_mbus_dram_info(void)
 }
 #endif
 
+void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
+void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
 int mvebu_mbus_add_window_remap_flags(const char *devname, phys_addr_t base,
 				      size_t size, phys_addr_t remap,
 				      unsigned int flags);
-- 
1.8.1.5

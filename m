From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 31 May 2017 15:33:35 +0200
Subject: [PATCH v5 2/3] PCI: Add tango PCIe host bridge support
In-Reply-To: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
Message-ID: <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is required to work around several hardware bugs
in the PCIe controller.

NB: Revision 1 does not support legacy interrupts, or IO space.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/pci/host/Kconfig      |   8 +++
 drivers/pci/host/Makefile     |   1 +
 drivers/pci/host/pcie-tango.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h       |   2 +
 4 files changed, 175 insertions(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a827c3..5183d9095c3a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -285,6 +285,14 @@ config PCIE_ROCKCHIP
 	  There is 1 internal PCIe port available to support GEN2 with
 	  4 slots.
 
+config PCIE_TANGO
+	bool "Tango PCIe controller"
+	depends on ARCH_TANGO && PCI_MSI && OF
+	select PCI_HOST_COMMON
+	help
+	  Say Y here to enable PCIe controller support for Sigma Designs
+	  Tango systems, such as SMP8759 and later chips.
+
 config VMD
 	depends on PCI_MSI && X86_64
 	tristate "Intel Volume Management Device Driver"
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 084cb4983645..fc7ea90196f3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -32,4 +32,5 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
+obj-$(CONFIG_PCIE_TANGO) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
new file mode 100644
index 000000000000..67aaadcc1c5e
--- /dev/null
+++ b/drivers/pci/host/pcie-tango.c
@@ -0,0 +1,164 @@
+#include <linux/pci-ecam.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#define MSI_MAX 256
+
+#define SMP8759_MUX		0x48
+#define SMP8759_TEST_OUT	0x74
+
+struct tango_pcie {
+	void __iomem *mux;
+};
+
+/*** HOST BRIDGE SUPPORT ***/
+
+static int smp8759_config_read(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 *val)
+{
+	int ret;
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
+
+	/*
+	 * QUIRK #1
+	 * Reads in configuration space outside devfn 0 return garbage.
+	 */
+	if (devfn != 0)
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+	/*
+	 * QUIRK #2
+	 * Unfortunately, config and mem spaces are muxed.
+	 * Linux does not support such a setting, since drivers are free
+	 * to access mem space directly, at any time.
+	 * Therefore, we can only PRAY that config and mem space accesses
+	 * NEVER occur concurrently.
+	 */
+	writel_relaxed(1, pcie->mux);
+	ret = pci_generic_config_read(bus, devfn, where, size, val);
+	writel_relaxed(0, pcie->mux);
+
+	return ret;
+}
+
+static int smp8759_config_write(struct pci_bus *bus,
+		unsigned int devfn, int where, int size, u32 val)
+{
+	int ret;
+	struct pci_config_window *cfg = bus->sysdata;
+	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
+
+	writel_relaxed(1, pcie->mux);
+	ret = pci_generic_config_write(bus, devfn, where, size, val);
+	writel_relaxed(0, pcie->mux);
+
+	return ret;
+}
+
+static struct pci_ecam_ops smp8759_ecam_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= smp8759_config_read,
+		.write		= smp8759_config_write,
+	}
+};
+
+static const struct of_device_id tango_pcie_ids[] = {
+	{ .compatible = "sigma,smp8759-pcie" },
+	{ /* sentinel */ },
+};
+
+static int tango_check_pcie_link(void __iomem *test_out)
+{
+	int i;
+
+	writel_relaxed(16, test_out);
+	for (i = 0; i < 10; ++i) {
+		u32 ltssm_state = readl_relaxed(test_out) >> 8;
+		if ((ltssm_state & 0x1f) == 0xf) /* L0 */
+			return 0;
+		usleep_range(3000, 4000);
+	}
+
+	return -ENODEV;
+}
+
+static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
+{
+	pcie->mux		= base + SMP8759_MUX;
+
+	return tango_check_pcie_link(base + SMP8759_TEST_OUT);
+}
+
+static int tango_pcie_probe(struct platform_device *pdev)
+{
+	int ret = -EINVAL;
+	void __iomem *base;
+	struct resource *res;
+	struct tango_pcie *pcie;
+	struct device *dev = &pdev->dev;
+
+	pr_err("MAJOR ISSUE: PCIe config and mem spaces are muxed\n");
+	pr_err("Tainting kernel... Use driver at your own risk\n");
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pcie);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (of_device_is_compatible(dev->of_node, "sigma,smp8759-pcie"))
+		ret = smp8759_init(pcie, base);
+
+	if (ret)
+		return ret;
+
+	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
+}
+
+static struct platform_driver tango_pcie_driver = {
+	.probe	= tango_pcie_probe,
+	.driver	= {
+		.name = KBUILD_MODNAME,
+		.of_match_table = tango_pcie_ids,
+	},
+};
+
+builtin_platform_driver(tango_pcie_driver);
+
+/*
+ * QUIRK #3
+ * The root complex advertizes the wrong device class.
+ * Header Type 1 is for PCI-to-PCI bridges.
+ */
+static void tango_fixup_class(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x24, tango_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x28, tango_fixup_class);
+
+/*
+ * QUIRK #4
+ * The root complex exposes a "fake" BAR, which is used to filter
+ * bus-to-system accesses. Only accesses within the range defined
+ * by this BAR are forwarded to the host, others are ignored.
+ *
+ * By default, the DMA framework expects an identity mapping,
+ * and DRAM0 is mapped@0x80000000.
+ */
+static void tango_fixup_bar(struct pci_dev *dev)
+{
+	dev->non_compliant_bars = true;
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x24, tango_fixup_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x28, tango_fixup_bar);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f020ab4079d3..b577dbe46f8f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1369,6 +1369,8 @@
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
 #define PCI_DEVICE_ID_TTI_HPT372N	0x0009	/* apparently a 372N variant? */
 
+#define PCI_VENDOR_ID_SIGMA		0x1105
+
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8763_0	0x0198
 #define PCI_DEVICE_ID_VIA_8380_0	0x0204
-- 
2.11.0

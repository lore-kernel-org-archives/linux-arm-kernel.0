From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Mar 2013 09:54:21 -0300
Subject: [PATCH 1/5] drivers: memory: Introduce Marvell EBU Device Bus driver
In-Reply-To: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1362660865-2755-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell EBU SoCs such as Armada 370/XP, Orion5x (88f5xxx) and
Discovery (mv78xx0) supports a Device Bus controller to access several
kinds of memories and I/O devices (NOR, NAND, SRAM, FPGA).

This commit adds a driver to handle this controller. So far only
Armada 370, Armada XP and Discovery SoCs are supported.

The driver must be registered through a device tree node;
as explained in the binding document.
This driver is in charge of setting timing parameters for each
device, create the address decoding window for it and register
the child device.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../bindings/memory-controllers/orion-devbus.txt   |  150 ++++++++++
 drivers/memory/Kconfig                             |   11 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/mvebu-devbus.c                      |  296 ++++++++++++++++++++
 4 files changed, 458 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/orion-devbus.txt
 create mode 100644 drivers/memory/mvebu-devbus.c

diff --git a/Documentation/devicetree/bindings/memory-controllers/orion-devbus.txt b/Documentation/devicetree/bindings/memory-controllers/orion-devbus.txt
new file mode 100644
index 0000000..854d0da
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/orion-devbus.txt
@@ -0,0 +1,150 @@
+Device tree bindings for MVEBU Device Bus controllers
+
+The Device Bus controller available in some Marvell's SoC allows to control
+different types of standard memory and I/O devices such as NOR, NAND, and FPGA.
+The actual devices are instantiated from the child nodes of a Device Bus node.
+
+Required properties:
+
+ - compatible:          Should be set to one of the following:
+
+                        marvell,armada370-devbus
+                        marvell,armadaxp-devbus
+                        marvell,mv78xx0-devbus
+
+ - reg:                 A resource specifier for the register space
+                        (see the example below)
+ - #address-cells:      Must be set to 2 to allow memory address translation
+ - #size-cells:         Must be set to 1 to allow CS address passing
+ - ranges:              Must be set up to reflect the memory layout with four
+                        integer values for each chip-select line in use:
+                        <cs-number> 0 <physical address of mapping> <size>
+
+Optional timing properties for child nodes:
+(these are all optional and default to the SoC initial value)
+
+Read parameters:
+
+ - devbus,turn-off:     Defines the number of TCLK cycles that the SoC does not
+                        drive the AD bus after the completion of a device read.
+                        This prevents contentions on the Device Bus after a read
+                        cycle from a slow device.
+                        The minimum setting of this parameter is 0x2.
+
+ - devbus,dev-width:    0x0 = 8-bit
+                        0x1 = 16-bit
+                        0x2 = 32-bit
+                        0x3 = Reserved
+
+ - devbus,badr-skew:    Defines the number of TCLK cycles from A[2:0] toggle,
+                        to read data sample. This parameter is useful for
+                        synchronous pipelined devices, where the address
+                        precedes the read data by one or two cycles.
+
+ - devbus,acc-first:    Defines the number of TCLK cycles from the negation of
+                        ALE[0] to the cycle that the first read data is sampled
+                        by the SoC. The number of TCLK cycles is this
+                        parameter's setting minus three (<acc-first> - 3).
+                        The minimum setting of this parameter is 0x6.
+
+ - devbus,acc-next:     Defines the number of TCLK cycles between the cycle that
+                        samples data N to the cycle that samples data N+1
+                        (in burst accesses).
+                        The minimum setting for this parameter is 0x2.
+
+ - devbus,rd-setup:     Defines the number of TCLK cycles between DEV_CSn
+                        assertion to DEV_OEn assertion. If set to 0 (default),
+                        DEV_OEn and DEV_CSn are asserted at the same cycle.
+                        This parameter has no affect on <acc-first> parameter
+                        (no affect on first data sample). Set <rd-setup>
+                        to a value smaller than <acc-first>.
+
+ - devbus,rd-hold:      Defines the number of TCLK cycles between the last data
+                        sample to the de-assertion of DEV_CSn.
+                        If set to 0 (default), DEV_OEn and DEV_CSn are
+                        de-asserted at the same cycle (the cycle of the
+                        last data sample).
+                        This parameter has no affect on DEV_OEn de-assertion.
+                        DEV_OEn is always de-asserted the next cycle after
+                        last data sampled. Also this parameter has no
+                        affect on <turn-off> parameter.
+                        Set <rd-hold> to a value smaller than <turn-off>.
+
+Write parameters:
+
+ - devbus,ale-wr:       Defines the number of TCLK cycles from the ALE[0]
+                        negation cycle to the DEV_WEn assertion. The number of
+                        cycles is <ale-wr> - 3.
+                        The minimum setting of this parameter is 0x4.
+
+ - devbus,wr-low:       Defines the number of TCLKs that DEV_WEn is active.
+                        A[2:0] and Data are kept valid as long as DEV_WEn
+                        is active. This parameter defines the setup time of
+                        address and data to DEV_WEn rise.
+                        The minimum setting of this parameter is 0x1.
+
+ - devbus,wr-high:      Defines the number of TCLK cycles that DEV_WEn is kept
+                        inactive (high) between data beats of a burst write.
+                        DEV_A[2:0] and Data are kept valid (do not toggle) for
+                        <wr-high> - 1 periods. This parameter defines the hold
+                        time of address and data after DEV_WEn rise.
+                        The minimum setting of this parameter is 0x1.
+
+ - devbus,sync-enable: Synchronous device enable.
+                       1: True
+                       0: False
+
+An example for an Armada XP GP board, with a 16 MiB NOR device as child
+is showed below. Note that the Device Bus driver is in charge of allocating
+the mbus address decoding window for each of its child devices.
+The window is created using the chip select specified in the child
+device node together with the base address and size specified in the ranges
+property. For instance, in the example below the allocated decoding window
+will start at base address 0xf0000000, with a size 0x1000000 (16 MiB)
+for chip select 0 (a.k.a DEV_BOOTCS).
+
+The reg property must specify the chip select as:
+
+  0: DEV_BOOTCS
+  1: DEV_CS0
+  2: DEV_CS1
+  3: DEV_CS2
+  4: DEV_CS3
+
+Example:
+
+	device-bus at d0010400 {
+		status = "okay";
+		ranges = <0 0 0xf0000000 0x1000000>; /* CS0 @addr 0xf0000000, size 0x1000000 */
+
+		nor at 0 {
+			compatible = "cfi-flash";
+
+			/* CS0, 16 MiB */
+			reg = <0 0 0x1000000>;
+			bank-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Read parameters */
+			devbus,turn-off = <0x3f>;
+			devbus,acc-first = <0x1f>;
+			devbus,acc-next = <0x1f>;
+			devbus,rd-setup = <0x1f>;
+			devbus,rd-hold = <0x3e>;
+
+			/*
+			 * We split the 16 MiB in two partitions,
+			 * just as an example.
+			 */
+			partition at 0 {
+				label = "First";
+				reg = <0 0x800000>;
+			};
+
+			partition at 800000 {
+				label = "Second";
+				reg = <0x800000 0x800000>;
+			};
+		};
+	};
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 067f311..f246f7e 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -40,4 +40,15 @@ config TEGRA30_MC
 	  analysis, especially for IOMMU/SMMU(System Memory Management
 	  Unit) module.
 
+config MVEBU_DEVBUS
+	tristate "Marvell EBU Device Bus Controller"
+	default y
+	depends on PLAT_ORION && OF
+	help
+	  This driver is for the Device Bus controller available in some
+	  Marvell EBU SoCs such as Discovery (mv78xx0), Orion (88f5xxx) and
+	  Armada 370 and Armada XP. This controller allows to handle flash
+	  devices such as NOR, NAND, SRAM, and FPGA.
+
+
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 9cce5d7..156c264 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -8,3 +8,4 @@ endif
 obj-$(CONFIG_TI_EMIF)		+= emif.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
+obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
new file mode 100644
index 0000000..de6ab32
--- /dev/null
+++ b/drivers/memory/mvebu-devbus.c
@@ -0,0 +1,296 @@
+/*
+ * Marvell EBU SoC Device Bus Controller
+ * (memory controller for NOR/NAND/SRAM/FPGA devices)
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+
+#include <linux/mbus.h>
+
+/* Register definitions */
+#define DEV_WIDTH_BIT		30
+#define BADR_SKEW_BIT		28
+#define RD_HOLD_BIT		23
+#define ACC_NEXT_BIT		17
+#define RD_SETUP_BIT		12
+#define ACC_FIRST_BIT		6
+
+#define SYNC_ENABLE_BIT		24
+#define WR_HIGH_BIT		16
+#define WR_LOW_BIT		8
+
+#define READ_PARAM_OFFSET(cs)	(0x0 + (cs << 3))
+#define WRITE_PARAM_OFFSET(cs)	(0x4 + (cs << 3))
+
+static const char * const devbus_wins[] = {
+	"devbus-boot",
+	"devbus-cs0",
+	"devbus-cs1",
+	"devbus-cs2",
+	"devbus-cs3",
+};
+
+struct devbus_read_params {
+	u32 dev_width;
+	u32 badr_skew;
+	u32 turn_off;
+	u32 acc_first;
+	u32 acc_next;
+	u32 rd_setup;
+	u32 rd_hold;
+};
+
+struct devbus_write_params {
+	u32 sync_enable;
+	u32 wr_high;
+	u32 wr_low;
+	u32 ale_wr;
+};
+
+static void __iomem *devbus_base;
+
+static inline void
+devbus_get_read_params(int cs, struct devbus_read_params *r)
+{
+	void __iomem *addr;
+	u32 value;
+
+	addr = devbus_base + READ_PARAM_OFFSET(cs);
+
+	value = readl(addr);
+
+	r->dev_width = (value >> DEV_WIDTH_BIT) & 0x03;
+	r->badr_skew = (value >> BADR_SKEW_BIT) & 0x03;
+	r->rd_hold   = (value >> RD_HOLD_BIT)   & 0x1f;
+	r->acc_next  = (value >> ACC_NEXT_BIT)  & 0x3f;
+	r->rd_setup  = (value >> RD_SETUP_BIT)  & 0x1f;
+	r->acc_first = (value >> ACC_FIRST_BIT) & 0x3f;
+	r->turn_off  = value & 0x3f;
+}
+
+static inline void
+devbus_get_write_params(int cs, struct devbus_write_params *w)
+{
+	void __iomem *addr;
+	u32 value;
+
+	addr = devbus_base + WRITE_PARAM_OFFSET(cs);
+
+	value = readl(addr);
+
+	w->sync_enable = (value >> SYNC_ENABLE_BIT) & 0x01;
+	w->wr_high     = (value >> WR_HIGH_BIT)     & 0x3f;
+	w->wr_low      = (value >> WR_LOW_BIT)      & 0x3f;
+	w->ale_wr      = value & 0x3f;
+}
+
+static inline void devbus_set_read_params(
+		struct device *dev, int cs, struct devbus_read_params *r)
+{
+	u32 value;
+
+	value = r->dev_width << DEV_WIDTH_BIT |
+		r->badr_skew << BADR_SKEW_BIT |
+		r->rd_hold   << RD_HOLD_BIT   |
+		r->acc_next  << ACC_NEXT_BIT  |
+		r->rd_setup  << RD_SETUP_BIT  |
+		r->acc_first << ACC_FIRST_BIT |
+		r->turn_off;
+
+	dev_dbg(dev,
+		"CS%d read parameters register: %x\n"
+		"dev_width = %x\n"
+		"badr_skew = %x\n"
+		"rd_hold = %x\n"
+		"acc_next = %x\n"
+		"rd_setup = %x\n"
+		"acc_first = %x\n"
+		"turn_off = %x\n",
+		cs, value, r->dev_width, r->badr_skew, r->rd_hold,
+		r->acc_next, r->rd_setup, r->acc_first, r->turn_off);
+
+	writel(value, devbus_base + READ_PARAM_OFFSET(cs));
+}
+
+static inline void devbus_set_write_params(struct device *dev,
+		int cs, struct devbus_write_params *w)
+{
+	u32 value;
+
+	value = w->sync_enable  << SYNC_ENABLE_BIT |
+		w->wr_low       << WR_LOW_BIT      |
+		w->wr_high      << WR_HIGH_BIT     |
+		w->ale_wr;
+
+	dev_dbg(dev,
+		"CS%d write parameters register: %x\n"
+		"sync_enable = %x\n"
+		"wr_low = %x\n"
+		"wr_high = %x\n"
+		"ale_wr = %x\n",
+		cs, value, w->sync_enable, w->wr_low, w->wr_high, w->ale_wr);
+
+	writel(value, devbus_base + WRITE_PARAM_OFFSET(cs));
+}
+
+static void devbus_get_params_dt(struct device_node *node,
+				 struct devbus_read_params *r,
+				 struct devbus_write_params *w)
+{
+	/* Reading timings */
+	of_property_read_u32(node, "devbus,dev-width", &r->dev_width);
+	of_property_read_u32(node, "devbus,badr-skew", &r->badr_skew);
+	of_property_read_u32(node, "devbus,turn-off", &r->turn_off);
+	of_property_read_u32(node, "devbus,acc-first", &r->acc_first);
+	of_property_read_u32(node, "devbus,acc-next", &r->acc_next);
+	of_property_read_u32(node, "devbus,rd-setup", &r->rd_setup);
+	of_property_read_u32(node, "devbus,rd-hold", &r->rd_hold);
+
+	/* Writing timings */
+	of_property_read_u32(node, "devbus,ale-wr", &w->ale_wr);
+	of_property_read_u32(node, "devbus,wr-low", &w->wr_low);
+	of_property_read_u32(node, "devbus,wr-high", &w->wr_high);
+	of_property_read_u32(node, "devbus,sync-enable", &w->sync_enable);
+}
+
+static int devbus_probe_nor_child(struct platform_device *pdev,
+				 struct device_node *node)
+{
+	struct platform_device *child;
+	struct device *dev = &pdev->dev;
+	struct resource mem_res;
+	struct devbus_read_params read_params;
+	struct devbus_write_params write_params;
+	int err;
+	int bank_width;
+	u32 cs;
+
+	/* Read chip select and size */
+	if (of_property_read_u32(node, "reg", &cs) < 0) {
+		dev_err(dev, "%s has no 'reg' property\n", node->full_name);
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(node, 0, &mem_res)) {
+		dev_err(dev, "%s has malformed 'reg' property\n",
+			node->full_name);
+		return -ENODEV;
+	}
+
+	err = of_property_read_u32(node, "bank-width", &bank_width);
+	if (err) {
+		dev_err(dev, "error %d reading bank-width property\n", err);
+		return err;
+	}
+
+	/*
+	 * Allocate an address window for this device.
+	 * If the device probing fails, then we won't be able to
+	 * remove the allocated address decoding window.
+	 */
+	err = mvebu_mbus_add_window(devbus_wins[cs], mem_res.start,
+				    resource_size(&mem_res));
+	if (err < 0)
+		return -EBUSY;
+
+	/*
+	 * First we read current parameter value, in order to have
+	 * a default value for each parameter in case it's not defined
+	 * by the device tree file.
+	 */
+	devbus_get_read_params(cs, &read_params);
+	devbus_get_write_params(cs, &write_params);
+
+	/* Read the device tree child node and set the new parameters */
+	devbus_get_params_dt(node, &read_params, &write_params);
+	devbus_set_read_params(dev, cs, &read_params);
+	devbus_set_write_params(dev, cs, &write_params);
+
+	/*
+	 * If we manage to set 'simple-bus' compatible string
+	 * to device-bus node, then we don't really need this.
+	 */
+	child = of_platform_device_create(node, NULL, &pdev->dev);
+	if (!child) {
+		dev_warn(dev, "cannot create child device %s\n", node->name);
+		/* Remove the allocated window */
+		mvebu_mbus_del_window(mem_res.start, resource_size(&mem_res));
+	}
+
+	return 0;
+}
+
+static int mvebu_devbus_probe(struct platform_device *pdev)
+{
+	struct device_node *child;
+	struct resource *res;
+	int err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	devbus_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(devbus_base))
+		return PTR_ERR(devbus_base);
+
+	/*
+	 * We probe NOR/NAND with different functions, because
+	 * we expect them to have some different parameters.
+	 * If this turns out not to be the case, we'll be able
+	 * to use any name for the child, and rename to devbus_probe_child().
+	 */
+	for_each_node_by_name(child, "nor") {
+		err = devbus_probe_nor_child(pdev, child);
+		if (err < 0) {
+			of_node_put(child);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mvebu_devbus_of_match[] = {
+	{ .compatible = "marvell,armada370-devbus"	 },
+	{ .compatible = "marvell,armadaxp-devbus"	 },
+	{ .compatible = "marvell,mv78xx0-devbus"	 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvebu_devbus_of_match);
+
+static struct platform_driver mvebu_devbus_driver = {
+	.probe		= mvebu_devbus_probe,
+	.remove		= NULL, /* Thanks to managed functions! */
+	.driver		= {
+		.name	= "mvebu-devbus",
+		.owner	= THIS_MODULE,
+		.of_match_table = mvebu_devbus_of_match,
+	},
+};
+
+module_platform_driver(mvebu_devbus_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell EBU SoC Device Bus controller");
-- 
1.7.8.6

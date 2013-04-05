From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Apr 2013 18:11:56 -0300
Subject: [PATCH v2 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1365196320-15084-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell EBU SoCs such as Armada 370/XP, Orion5x (88f5xxx) and
Discovery (mv78xx0) supports a Device Bus controller to access several
kinds of memories and I/O devices (NOR, NAND, SRAM, FPGA).

This commit adds a driver to handle this controller. So far only
Armada 370, Armada XP SoCs are supported.

The driver must be registered through a device tree node;
as explained in the binding document.

For each child node in the device tree, this driver will:
  * set timing parameters
  * register a child device
  * setup an address decoding window, using the mbus driver

Keep in mind the address decoding window setup is only a temporary hack.
This code will be removed from this devbus driver as soon as a proper device
tree binding for the mbus driver is added.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../bindings/memory-controllers/mvebu-devbus.txt   | 151 ++++++++++
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mvebu-devbus.c                      | 330 +++++++++++++++++++++
 4 files changed, 492 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
 create mode 100644 drivers/memory/mvebu-devbus.c

diff --git a/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt b/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
new file mode 100644
index 0000000..5b78940
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
@@ -0,0 +1,151 @@
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
+Mandatory timing properties for child nodes:
+
+Read parameters:
+
+ - devbus,turn-off-ps:  Defines the time during which the controller does not
+                        drive the AD bus after the completion of a device read.
+                        This prevents contentions on the Device Bus after a read
+                        cycle from a slow device.
+
+ - devbus,dev-width:    0x0 = 8-bit
+                        0x1 = 16-bit
+                        0x2 = 32-bit
+                        0x3 = Reserved
+
+ - devbus,badr-skew-ps: Defines the time delay from from A[2:0] toggle,
+                        to read data sample. This parameter is useful for
+                        synchronous pipelined devices, where the address
+                        precedes the read data by one or two cycles.
+
+ - devbus,acc-first-ps: Defines the time delay from the negation of
+                        ALE[0] to the cycle that the first read data is sampled
+                        by the controller.
+
+ - devbus,acc-next-ps:  Defines the time delay between the cycle that
+                        samples data N and the cycle that samples data N+1
+                        (in burst accesses).
+
+ - devbus,rd-setup-ps:  Defines the time delay between DEV_CSn assertion to
+			DEV_OEn assertion. If set to 0 (default),
+                        DEV_OEn and DEV_CSn are asserted at the same cycle.
+                        This parameter has no affect on <acc-first-ps> parameter
+                        (no affect on first data sample). Set <rd-setup-ps>
+                        to a value smaller than <acc-first-ps>.
+
+ - devbus,rd-hold-ps:   Defines the time between the last data sample to the
+			de-assertion of DEV_CSn. If set to 0 (default),
+			DEV_OEn and DEV_CSn are de-asserted at the same cycle
+			(the cycle of the last data sample).
+                        This parameter has no affect on DEV_OEn de-assertion.
+                        DEV_OEn is always de-asserted the next cycle after
+                        last data sampled. Also this parameter has no
+                        affect on <turn-off-ps> parameter.
+                        Set <rd-hold-ps> to a value smaller than <turn-off-ps>.
+
+Write parameters:
+
+ - devbus,ale-wr-ps:    Defines the time delay from the ALE[0] negation cycle
+			to the DEV_WEn assertion.
+
+ - devbus,wr-low-ps:    Defines the time during which DEV_WEn is active.
+                        A[2:0] and Data are kept valid as long as DEV_WEn
+                        is active. This parameter defines the setup time of
+                        address and data to DEV_WEn rise.
+
+ - devbus,wr-high-ps:   Defines the time during which DEV_WEn is kept
+                        inactive (high) between data beats of a burst write.
+                        DEV_A[2:0] and Data are kept valid (do not toggle) for
+                        <wr-high-ps> - <tick> ps.
+			This parameter defines the hold time of address and
+			data after DEV_WEn rise.
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
+This address window handling is done in this mvebu-devbus only as a temporary
+solution. It will be removed when the support for mbus device tree binding is
+added.
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
+		#address-cells = <2>;
+		#size-cells = <1>;
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
+			/* Device Bus parameters are required */
+			devbus,dev-width = <1>;
+
+			/* Read parameters */
+			devbus,turn-off-ps  = <60000>;
+			devbus,badr-skew-ps = <0>;
+			devbus,acc-first-ps = <124000>;
+			devbus,acc-next-ps  = <248000>;
+			devbus,rd-setup-ps  = <0>;
+			devbus,rd-hold-ps   = <0>;
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
index 067f311..9a81ab3 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -20,6 +20,16 @@ config TI_EMIF
 	  parameters and other settings during frequency, voltage and
 	  temperature changes
 
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
 config TEGRA20_MC
 	bool "Tegra20 Memory Controller(MC) driver"
 	default y
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 9cce5d7..969d923 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -6,5 +6,6 @@ ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
 obj-$(CONFIG_TI_EMIF)		+= emif.o
+obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
new file mode 100644
index 0000000..2a4c455
--- /dev/null
+++ b/drivers/memory/mvebu-devbus.c
@@ -0,0 +1,330 @@
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
+#include <linux/clk.h>
+#include <linux/mbus.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
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
+#define DEVBUS_MAXCHILDS_NR	5
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
+struct devbus_child {
+	struct platform_device *pdev;
+	struct resource mem_res;
+};
+
+struct devbus {
+	struct device *dev;
+	void __iomem *base;
+	unsigned long tick_ps;
+
+	struct devbus_child childs[DEVBUS_MAXCHILDS_NR];
+};
+
+static void get_timing_param_ps(struct devbus *devbus,
+				struct device_node *node,
+				const char *name,
+				u32 *ticks)
+{
+	u32 time_ps;
+
+	of_property_read_u32(node, name, &time_ps);
+
+	*ticks = (time_ps + devbus->tick_ps - 1) / devbus->tick_ps;
+
+	dev_dbg(devbus->dev, "%s: %u ps -> 0x%x\n",
+		name, time_ps, *ticks);
+}
+
+static void devbus_set_timing_params(struct devbus *devbus,
+				     struct device_node *node,
+				     int cs)
+{
+	struct devbus_read_params r;
+	struct devbus_write_params w;
+	u32 value;
+
+	dev_dbg(devbus->dev, "Setting timing parameter, tick is %lu ps\n",
+		devbus->tick_ps);
+
+	of_property_read_u32(node, "devbus,dev-width", &r.dev_width);
+
+	/* Get read timings */
+	get_timing_param_ps(devbus, node, "devbus,badr-skew-ps", &r.badr_skew);
+	get_timing_param_ps(devbus, node, "devbus,turn-off-ps", &r.turn_off);
+	get_timing_param_ps(devbus, node, "devbus,acc-first-ps", &r.acc_first);
+	get_timing_param_ps(devbus, node, "devbus,acc-next-ps", &r.acc_next);
+	get_timing_param_ps(devbus, node, "devbus,rd-setup-ps", &r.rd_setup);
+	get_timing_param_ps(devbus, node, "devbus,rd-hold-ps", &r.rd_hold);
+
+	/* Get write timings */
+	get_timing_param_ps(devbus, node, "devbus,ale-wr-ps", &w.ale_wr);
+	get_timing_param_ps(devbus, node, "devbus,wr-low-ps", &w.wr_low);
+	get_timing_param_ps(devbus, node, "devbus,wr-high-ps", &w.wr_high);
+
+	of_property_read_u32(node, "devbus,sync-enable", &w.sync_enable);
+
+	/* Set read timings */
+	value = r.dev_width << DEV_WIDTH_BIT |
+		r.badr_skew << BADR_SKEW_BIT |
+		r.rd_hold   << RD_HOLD_BIT   |
+		r.acc_next  << ACC_NEXT_BIT  |
+		r.rd_setup  << RD_SETUP_BIT  |
+		r.acc_first << ACC_FIRST_BIT |
+		r.turn_off;
+
+	dev_dbg(devbus->dev, "CS%d read parameters register 0x%p = 0x%x\n",
+		cs, devbus->base + READ_PARAM_OFFSET(cs),
+		value);
+
+	writel(value, devbus->base + READ_PARAM_OFFSET(cs));
+
+	/* Set write timings */
+	value = w.sync_enable  << SYNC_ENABLE_BIT |
+		w.wr_low       << WR_LOW_BIT      |
+		w.wr_high      << WR_HIGH_BIT     |
+		w.ale_wr;
+
+	dev_dbg(devbus->dev, "CS%d write parameters register: 0x%p = 0x%x\n",
+		cs, devbus->base + WRITE_PARAM_OFFSET(cs),
+		value);
+
+	writel(value, devbus->base + WRITE_PARAM_OFFSET(cs));
+}
+
+static int devbus_probe_nor_child(struct devbus *devbus,
+				  struct platform_device *pdev,
+				  struct device_node *node)
+{
+	struct device *dev = &pdev->dev;
+	struct devbus_child *child;
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
+	/* Sanity checks */
+	if (cs >= DEVBUS_MAXCHILDS_NR)
+		return -ENODEV;
+
+	if (devbus->childs[cs].pdev)
+		return -EBUSY;
+
+	child = &devbus->childs[cs];
+
+	if (of_address_to_resource(node, 0, &child->mem_res)) {
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
+	 *
+	 * FIXME: This is only a temporary hack! We need to do this here
+	 * because we still don't have device tree bindings for mbus.
+	 * Once that support is added, we will declare these address windows
+	 * statically in the device tree, and remove the window configuration
+	 * from here.
+	 */
+	err = mvebu_mbus_add_window(devbus_wins[cs], child->mem_res.start,
+				    resource_size(&child->mem_res));
+	if (err < 0)
+		return err;
+
+	/* Read the device tree child node and set the new parameters */
+	devbus_set_timing_params(devbus, node, cs);
+
+	/*
+	 * If we manage to set 'simple-bus' compatible string
+	 * to device-bus node, then we don't really need this.
+	 */
+	child->pdev = of_platform_device_create(node, NULL, &pdev->dev);
+	if (!child->pdev) {
+		dev_warn(dev, "cannot create child device %s\n", node->name);
+		/* Remove the allocated window */
+		mvebu_mbus_del_window(child->mem_res.start,
+				      resource_size(&child->mem_res));
+	}
+
+	return 0;
+}
+
+static int mvebu_devbus_probe(struct platform_device *pdev)
+{
+	struct device_node *child;
+	struct devbus *devbus;
+	struct resource *res;
+	struct clk *clk;
+	unsigned long rate;
+	int err;
+
+	devbus = devm_kzalloc(&pdev->dev, sizeof(struct devbus), GFP_KERNEL);
+	if (!devbus)
+		return -ENOMEM;
+
+	devbus->dev = &pdev->dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	devbus->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(devbus->base))
+		return PTR_ERR(devbus->base);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	clk_prepare_enable(clk);
+
+	/*
+	 * Obtain clock period in picoseconds,
+	 * we need this in order to convert timing
+	 * parameters from cycles to picoseconds.
+	 */
+	rate = clk_get_rate(clk) / 1000;
+	devbus->tick_ps = 1000000000 / rate;
+
+	/*
+	 * We probe NOR/NAND with different functions, because
+	 * we expect them to have some different parameters.
+	 * If this turns out not to be the case, we'll be able
+	 * to use any name for the child, and rename to devbus_probe_child().
+	 */
+	for_each_node_by_name(child, "nor") {
+		err = devbus_probe_nor_child(devbus, pdev, child);
+		if (err < 0) {
+			of_node_put(child);
+			return err;
+		}
+	}
+
+	platform_set_drvdata(pdev, devbus);
+
+	return 0;
+}
+
+static int mvebu_devbus_remove(struct platform_device *pdev)
+{
+	int i;
+	struct devbus *devbus = platform_get_drvdata(pdev);
+
+	for (i = 0; i < DEVBUS_MAXCHILDS_NR; i++) {
+		struct devbus_child *child;
+
+		if (!devbus->childs[i].pdev)
+			continue;
+
+		child = &devbus->childs[i];
+
+		/* Release device */
+		of_device_unregister(child->pdev);
+
+		/* Release window */
+		mvebu_mbus_del_window(child->mem_res.start,
+				      resource_size(&child->mem_res));
+
+		child->pdev = NULL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+/* Perhaps it makes sense to unify both compatible strins? */
+static const struct of_device_id mvebu_devbus_of_match[] = {
+	{ .compatible = "marvell,armada370-devbus"	 },
+	{ .compatible = "marvell,armadaxp-devbus"	 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvebu_devbus_of_match);
+
+static struct platform_driver mvebu_devbus_driver = {
+	.probe		= mvebu_devbus_probe,
+	.remove		= mvebu_devbus_remove,
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
1.8.1.5

From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:41 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to the DT
 binding
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds static window allocation to the device tree binding.
Each first-child of the mbus-compatible node, with a suitable 'ranges'
property, declaring an address translation, will trigger an address
decoding window allocation.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/bus/mvebu-mbus.txt         | 152 +++++++++++++++++++++
 drivers/bus/mvebu-mbus.c                           | 110 ++++++++++++++-
 2 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
new file mode 100644
index 0000000..2b0303e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
@@ -0,0 +1,152 @@
+
+* Marvell MBus controller
+
+Required properties:
+
+- compatible:	Should be set to one of the following:
+		marvell,armada370-mbus
+		marvell,armadaxp-mbus
+
+- reg:		Device's register space.
+		Two entries are expected, see the examples below.
+		The first one controls the devices decoding window and
+		the second one controls the SDRAM decoding window.
+
+Example:
+
+	soc {
+		compatible = "marvell,armada370-mbus", "simple-bus";
+		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
+	};
+
+** How does it work?
+
+The MBus driver controls the allocation and release of the addresses
+decoding windows needed to access devices.
+
+Each window, is identified by its target ID and attribute ID. In order
+to represent this, each of mbus-node first-level child has to declare
+a suitable 'ranges' translation entry for the MBus to allocate a window
+for it. This entry will encode the target and attribute in a 'windowid'
+ad-hoc cell, like this:
+
+	soc {
+		bootrom {
+			ranges = <0 0x01e00000 0xfff00000 0x100000>;
+		};
+	};
+
+In this case, the MBus driver will allocate a window with target ID = 0x01,
+attribute ID = 0xe0, base address 0xfff00000, and size 0x100000.
+The windowid cell encodes the target and attribute in the upper bytes.
+
+Note that, the above 'ranges' property is creating a fictitious 2-cell address
+space with the windowid and the base address. We need to get rid of this
+2-cell address space, translating it into a real address space consisting of
+just the base address.
+
+The obvious way is to add a translation at the mbus-node level, like this:
+
+	soc {
+		ranges = <0x01e00000 0xfff00000 0xfff00000 0x100000>;
+		bootrom {
+			ranges = <0 0x01e00000 0xfff00000 0x100000>;
+		};
+	};
+
+This would lead to a lot of 'ranges' properties duplication because
+when you need to declare a new translation for a given device, you have
+to do it at the per-board DTS file. But since 'ranges' entries are not
+inherited from included dtsi files, you would have to go through each of the
+included dtsi files, making sure you duplicate each of the previous entries.
+
+So to avoid this duplication, the MBus driver is capable of adding the
+required translation entry to the device tree programatically. In other
+words, when writing the device tree you don't need to extend the mbus-node
+translation entry list; the driver will do it dynamically.
+
+So for instance, if you want to add support for a NOR device, that sits
+behind the Device Bus controller, you would have this device tree:
+(Note that the windowid cell is encoding the target ID = 0x01 and attribute
+ID = 0x2f, and the selected base address for the window is 0xe8000000).
+
+	soc {
+		devbus-bootcs {
+			status = "okay";
+			ranges = <0 0x012f0000 0xe8000000 0x8000000>;
+
+			/* Device Bus parameters are required but not shown */
+			/* ... */
+
+			/* NOR 128 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0x8000000>;
+				bank-width = <2>;
+			};
+		};
+	};
+
+** About the window base address
+
+Remember the MBus controller allows a great deal of flexibility for choosing
+the decoding window base address. When planning the device tree layout it's
+possible to choose any address as the base address, provided of course there's
+a region large enough available, and with the required alignment.
+
+Yet in other words: there's nothing preventing us from setting a base address
+of 0xf0000000, or 0xd0000000 for the NOR device shown above, if such region is
+unused.
+
+** About the special target ID and attribute ID
+
+As stated above, for each 'ranges' translation entry in mbus-node first-level
+children, the MBus driver will allocate a decoding window.
+However, in some cases it's desirable to declare a translation entry but have
+the MBus driver skip it.
+
+This is currently the case for the internal-regs and the pcie-controller
+nodes.
+
+In the former, a dummy translation entry is needed to map the regular device
+nodes into the {windowid / base address} address space, using a zeroed windowid
+(target = 0x0, attribute = 0x0). The MBus driver will skip entries with such
+windowid.
+
+	soc {
+		/* ... */
+		internal-regs {
+			compatible = "simple-bus";
+			ranges = <0 0 0 0x100000>;  /* Dummy translation */
+			serial at 12000 {
+				reg = <0x12000 0x100>;
+				/* ... */
+			};
+		};
+	};
+
+In the pcie-controller case, we have two kinds of entries we need to skip.
+The first one is identical to the internal-regs case; in fact it's declaring a
+translation into the internal-regs address space.
+
+The second one is identified by a target ID = 0xff and attribute ID = 0xff.
+We use this to create the mapping into the large region where the PCIe
+controller will request decoding window allocations from the MBus driver.
+
+	soc {
+		pcie-controller {
+			ranges =
+			       <0x82000000 0 0x40000    0          0x40000    0 0x00002000
+				0x82000000 0 0x80000    0          0x80000    0 0x00002000
+				0x82000000 0 0xe0000000 0xffff0000 0xe0000000 0 0x08000000
+				0x81000000 0 0          0xffff0000 0xe8000000 0 0x00100000>;
+
+			pcie at 1,0 {
+				/* ... */
+			};
+		};
+	};
+
+We don't want the MBus driver to statically allocate windows for this region,
+because the PCIe controller itself will make such requests depending on what
+kind of PCIe devices are detected.
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 23f6ae6..ac4115a 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -885,6 +885,110 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
 }
 
 #ifdef CONFIG_OF
+/*
+ * The window IDs in the ranges DT property have the following format:
+ *  - bits 24 to 31: window target ID
+ *  - bits 16 to 23: window attribute ID
+ *  - bits  0 to 15: unused
+ */
+#define TARGET(id) (((id) & 0xFF000000) >> 24)
+#define ATTR(id)   (((id) & 0x00FF0000) >> 16)
+
+static int __init mbus_dt_setup_win(struct mvebu_mbus_state *mbus,
+				    u32 windowid, u32 base, u32 size,
+				    u8 target, u8 attr)
+{
+	const struct mvebu_mbus_mapping *map = mbus->soc->map;
+	const char *name;
+	int i;
+
+	/* Special case for the identity mapping */
+	if (target == 0xff && attr == 0xff)
+		return 0;
+
+	/* Special case for the internal registers */
+	if (target == 0x00 && attr == 0x00)
+		return 0;
+
+	/* Search for a suitable window in the existing mappings */
+	for (i = 0; map[i].name; i++)
+		if (map[i].target == target &&
+		    map[i].attr == (attr & map[i].attrmask))
+			break;
+
+	name = map[i].name;
+	if (!name) {
+		pr_err("window 0x%x:0x%x is unknown, skipping\n",
+		       target, attr);
+		return -EINVAL;
+	}
+
+	if (!mvebu_mbus_window_conflicts(mbus, base, size, target, attr)) {
+		pr_err("cannot add window '%s', conflicts with another window\n",
+		       name);
+		return -EBUSY;
+	}
+
+	if (mvebu_mbus_alloc_window(mbus, base, size, MVEBU_MBUS_NO_REMAP,
+				    target, attr)) {
+		pr_err("cannot add window '%s', too many windows\n",
+		       name);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
+				struct device_node *np)
+{
+	struct device_node *child;
+	int ranges_len, tuple_len;
+	int addr_cells, c_addr_cells, c_size_cells;
+	int cell_count;
+	const __be32 *r, *ranges_start, *ranges_end, *prop;
+
+	for_each_available_child_of_node(np, child) {
+
+		addr_cells = of_n_addr_cells(child);
+
+		prop = of_get_property(child, "#address-cells", NULL);
+		c_addr_cells = be32_to_cpup(prop);
+
+		prop = of_get_property(child, "#size-cells", NULL);
+		c_size_cells = be32_to_cpup(prop);
+
+		cell_count = addr_cells + c_addr_cells + c_size_cells;
+		tuple_len = cell_count * sizeof(__be32);
+
+		ranges_start = of_get_property(child, "ranges", &ranges_len);
+		ranges_end = ranges_start + ranges_len / sizeof(__be32);
+
+		if (ranges_start == NULL || ranges_len % tuple_len) {
+			pr_warn("malformed ranges entry '%s'\n", child->name);
+			continue;
+		}
+
+		for (r = ranges_start; r < ranges_end; r += cell_count) {
+			u32 windowid, base, size;
+			u8 target, attr;
+			int ret;
+
+			windowid = of_read_number(r + c_addr_cells, 1);
+			base = of_read_number(r + c_addr_cells + 1, 1);
+			size = of_read_number(r + addr_cells + c_addr_cells,
+					      c_size_cells);
+			target = TARGET(windowid);
+			attr = ATTR(windowid);
+
+			ret = mbus_dt_setup_win(mbus, windowid, base, size,
+						target, attr);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 int __init mvebu_mbus_dt_init(void)
 {
 	struct resource mbuswins_res, sdramwins_res;
@@ -916,6 +1020,10 @@ int __init mvebu_mbus_dt_init(void)
 				     resource_size(&mbuswins_res),
 				     sdramwins_res.start,
 				     resource_size(&sdramwins_res));
-	return ret;
+	if (ret)
+		return ret;
+
+	/* Setup statically declared windows in the DT */
+	return mbus_dt_setup(&mbus_state, np);
 }
 #endif
-- 
1.8.1.5

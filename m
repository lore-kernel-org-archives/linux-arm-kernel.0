From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 10:17:59 +0100
Subject: [net-next: PATCH 3/8] mdio_bus: Introduce fwnode MDIO helpers
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <1513588684-15647-4-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces fwnode helper for registering MDIO
bus, as well as one for finding the PHY, basing on its
firmware node pointer. Comparing to existing OF equivalent,
fwnode_mdiobus_register() does not support:
 * deprecated bindings (device whitelist, nor the PHY ID embedded
   in the compatible string)
 * MDIO bus auto scanning

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/phy/mdio_bus.c | 218 ++++++++++++++++++++
 include/linux/mdio.h       |   3 +
 2 files changed, 221 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a0f34c3..f2b2a94 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -27,6 +27,7 @@
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
@@ -662,6 +663,223 @@ static int mdio_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int fwnode_mdiobus_register_phy(struct mii_bus *bus,
+				       struct fwnode_handle *child, u32 addr)
+{
+	struct phy_device *phy;
+	bool is_c45 = false;
+	int rc;
+
+	rc = fwnode_property_match_string(child, "compatible",
+					  "ethernet-phy-ieee802.3-c45");
+	if (!rc)
+		is_c45 = true;
+
+	phy = get_phy_device(bus, addr, is_c45);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy->irq = bus->irq[addr];
+
+	if (to_of_node(child)) {
+		rc = of_irq_get(to_of_node(child), 0);
+		if (rc == -EPROBE_DEFER) {
+			phy_device_free(phy);
+			return rc;
+		} else if (rc > 0) {
+			phy->irq = rc;
+			bus->irq[addr] = rc;
+		}
+	}
+
+	if (fwnode_property_read_bool(child, "broken-turn-around"))
+		bus->phy_ignore_ta_mask |= 1 << addr;
+
+	/* Associate the fwnode with the device structure so it
+	 * can be looked up later.
+	 */
+	phy->mdio.dev.fwnode = child;
+
+	/* All data is now stored in the phy struct, so register it */
+	rc = phy_device_register(phy);
+	if (rc) {
+		phy_device_free(phy);
+		fwnode_handle_put(child);
+		return rc;
+	}
+
+	dev_dbg(&bus->dev, "registered phy at address %i\n", addr);
+
+	return 0;
+}
+
+static int fwnode_mdiobus_register_device(struct mii_bus *bus,
+					  struct fwnode_handle *child, u32 addr)
+{
+	struct mdio_device *mdiodev;
+	int rc;
+
+	mdiodev = mdio_device_create(bus, addr);
+	if (IS_ERR(mdiodev))
+		return PTR_ERR(mdiodev);
+
+	/* Associate the fwnode with the device structure so it
+	 * can be looked up later.
+	 */
+	mdiodev->dev.fwnode = child;
+
+	/* All data is now stored in the mdiodev struct; register it. */
+	rc = mdio_device_register(mdiodev);
+	if (rc) {
+		mdio_device_free(mdiodev);
+		fwnode_handle_put(child);
+		return rc;
+	}
+
+	dev_dbg(&bus->dev, "registered mdio device at address %i\n", addr);
+
+	return 0;
+}
+
+static int fwnode_mdio_parse_addr(struct device *dev,
+				  const struct fwnode_handle *fwnode)
+{
+	u32 addr;
+	int ret;
+
+	ret = fwnode_property_read_u32(fwnode, "reg", &addr);
+	if (ret < 0) {
+		dev_err(dev, "PHY node has no 'reg' property\n");
+		return ret;
+	}
+
+	/* A PHY must have a reg property in the range [0-31] */
+	if (addr < 0 || addr >= PHY_MAX_ADDR) {
+		dev_err(dev, "PHY address %i is invalid\n", addr);
+		return -EINVAL;
+	}
+
+	return addr;
+}
+
+/**
+ * fwnode_mdiobus_child_is_phy - Return true if the child is a PHY node.
+ * It must either:
+ * o Compatible string of "ethernet-phy-ieee802.3-c45"
+ * o Compatible string of "ethernet-phy-ieee802.3-c22"
+ * Checking "compatible" property is done, in order to follow the DT binding.
+ */
+static bool fwnode_mdiobus_child_is_phy(struct fwnode_handle *child)
+{
+	int ret;
+
+	ret = fwnode_property_match_string(child, "compatible",
+					   "ethernet-phy-ieee802.3-c45");
+	if (!ret)
+		return true;
+
+	ret = fwnode_property_match_string(child, "compatible",
+					   "ethernet-phy-ieee802.3-c22");
+	if (!ret)
+		return true;
+
+	if (!fwnode_property_present(child, "compatible"))
+		return true;
+
+	return false;
+}
+
+/**
+ * fwnode_mdiobus_register - Register mii_bus and create PHYs from the fwnode
+ * @bus: pointer to mii_bus structure
+ * @fwnode: pointer to fwnode_handle of MDIO bus.
+ *
+ * This function registers the mii_bus structure and registers a phy_device
+ * for each child node of @fwnode.
+ */
+int fwnode_mdiobus_register(struct mii_bus *bus, struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child;
+	int addr, rc;
+	int default_gpio_reset_delay_ms = 10;
+
+	/* Do not continue if the node is disabled */
+	if (!fwnode_device_is_available(fwnode))
+		return -ENODEV;
+
+	/* Mask out all PHYs from auto probing. Instead the PHYs listed in
+	 * the firmware nodes are populated after the bus has been registered.
+	 */
+	bus->phy_mask = ~0;
+
+	bus->dev.fwnode = fwnode;
+
+	/* Get bus level PHY reset GPIO details */
+	bus->reset_delay_us = default_gpio_reset_delay_ms;
+	fwnode_property_read_u32(fwnode, "reset-delay-us",
+				 &bus->reset_delay_us);
+
+	/* Register the MDIO bus */
+	rc = mdiobus_register(bus);
+	if (rc)
+		return rc;
+
+	/* Loop over the child nodes and register a phy_device for each PHY */
+	fwnode_for_each_child_node(fwnode, child) {
+		addr = fwnode_mdio_parse_addr(&bus->dev, child);
+		if (addr < 0)
+			continue;
+
+		if (fwnode_mdiobus_child_is_phy(child))
+			rc = fwnode_mdiobus_register_phy(bus, child, addr);
+		else
+			rc = fwnode_mdiobus_register_device(bus, child, addr);
+		if (rc)
+			goto unregister;
+	}
+
+	return 0;
+
+unregister:
+	mdiobus_unregister(bus);
+
+	return rc;
+}
+EXPORT_SYMBOL(fwnode_mdiobus_register);
+
+/* Helper function for fwnode_phy_find_device */
+static int fwnode_phy_match(struct device *dev, void *phy_fwnode)
+{
+	return dev->fwnode == phy_fwnode;
+}
+
+/**
+ * fwnode_phy_find_device - find the phy_device associated to fwnode
+ * @phy_fwnode: Pointer to the PHY's fwnode
+ *
+ * If successful, returns a pointer to the phy_device with the embedded
+ * struct device refcount incremented by one, or NULL on failure.
+ */
+struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode)
+{
+	struct device *d;
+	struct mdio_device *mdiodev;
+
+	if (!phy_fwnode)
+		return NULL;
+
+	d = bus_find_device(&mdio_bus_type, NULL, phy_fwnode, fwnode_phy_match);
+	if (d) {
+		mdiodev = to_mdio_device(d);
+		if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY)
+			return to_phy_device(d);
+		put_device(d);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(fwnode_phy_find_device);
+
 #ifdef CONFIG_PM
 static int mdio_bus_suspend(struct device *dev)
 {
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index e37c21d..286ec12 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -272,6 +272,9 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev);
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr);
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
 
+int fwnode_mdiobus_register(struct mii_bus *bus, struct fwnode_handle *fwnode);
+struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
+
 /**
  * mdio_module_driver() - Helper macro for registering mdio drivers
  *
-- 
2.7.4

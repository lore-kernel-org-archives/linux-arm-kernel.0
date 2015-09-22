From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 22 Sep 2015 17:18:02 +0100
Subject: [PATCH 1/9] phy: fix of_mdio_find_bus() device refcount leak
In-Reply-To: <20150922161710.GA21084@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
Message-ID: <E1ZeQGY-0006UR-Mo@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_mdio_find_bus() leaks a struct device refcount, caused by using
class_find_device() and not realising that the device reference has
its refcount incremented:

 * Note, you will need to drop the reference with put_device() after use.
...
        while ((dev = class_dev_iter_next(&iter))) {
                if (match(dev, data)) {
                        get_device(dev);
                        break;
                }

Update the comment, and arrange for the phy code to drop this refcount
when disposing of a reference to it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/phy/mdio-mux.c | 19 +++++++++++++------
 drivers/net/phy/mdio_bus.c |  4 +++-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/mdio-mux.c b/drivers/net/phy/mdio-mux.c
index 4d4d25efc1e1..280c7c311f72 100644
--- a/drivers/net/phy/mdio-mux.c
+++ b/drivers/net/phy/mdio-mux.c
@@ -113,18 +113,18 @@ int mdio_mux_init(struct device *dev,
 	if (!parent_bus_node)
 		return -ENODEV;
 
-	parent_bus = of_mdio_find_bus(parent_bus_node);
-	if (parent_bus == NULL) {
-		ret_val = -EPROBE_DEFER;
-		goto err_parent_bus;
-	}
-
 	pb = devm_kzalloc(dev, sizeof(*pb), GFP_KERNEL);
 	if (pb == NULL) {
 		ret_val = -ENOMEM;
 		goto err_parent_bus;
 	}
 
+	parent_bus = of_mdio_find_bus(parent_bus_node);
+	if (parent_bus == NULL) {
+		ret_val = -EPROBE_DEFER;
+		goto err_parent_bus;
+	}
+
 	pb->switch_data = data;
 	pb->switch_fn = switch_fn;
 	pb->current_child = -1;
@@ -173,6 +173,10 @@ int mdio_mux_init(struct device *dev,
 		dev_info(dev, "Version " DRV_VERSION "\n");
 		return 0;
 	}
+
+	/* balance the reference of_mdio_find_bus() took */
+	put_device(&pb->mii_bus->dev);
+
 err_parent_bus:
 	of_node_put(parent_bus_node);
 	return ret_val;
@@ -189,6 +193,9 @@ void mdio_mux_uninit(void *mux_handle)
 		mdiobus_free(cb->mii_bus);
 		cb = cb->next;
 	}
+
+	/* balance the reference of_mdio_find_bus() in mdio_mux_init() took */
+	put_device(&pb->mii_bus->dev);
 }
 EXPORT_SYMBOL_GPL(mdio_mux_uninit);
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 02a4615b65f8..67553e13bd36 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -167,7 +167,9 @@ static int of_mdio_bus_match(struct device *dev, const void *mdio_bus_np)
  * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
  * @mdio_bus_np: Pointer to the mii_bus.
  *
- * Returns a pointer to the mii_bus, or NULL if none found.
+ * Returns a reference to the mii_bus, or NULL if none found.  The
+ * embedded struct device will have its reference count incremented,
+ * and this must be put once the bus is finished with.
  *
  * Because the association of a device_node and mii_bus is made via
  * of_mdiobus_register(), the mii_bus cannot be found before it is
-- 
2.1.0

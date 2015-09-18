From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 18 Sep 2015 10:47:24 +0100
Subject: [PATCH 3/7] phy: add proper phy struct device refcounting
In-Reply-To: <20150918094625.GB21084@n2100.arm.linux.org.uk>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
Message-ID: <E1ZcsGK-0000uR-Fr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take a refcount on the phy struct device when the phy device is attached
to a network device, and drop it after it's detached.  This ensures that
a refcount is held on the phy device while the device is being used by
a network device, thereby preventing the phy_device from being
unexpectedly kfree()'d by phy_device_release().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/phy/phy_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 03adf328f49b..97a4f52addac 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -578,6 +578,7 @@ EXPORT_SYMBOL(phy_init_hw);
  *     generic driver is used.  The phy_device is given a ptr to
  *     the attaching device, and given a callback for link status
  *     change.  The phy_device is returned to the attaching driver.
+ *     This function takes a reference on the phy device.
  */
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface)
@@ -591,6 +592,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		return -EIO;
 	}
 
+	get_device(d);
+
 	/* Assume that if there is no driver, that it doesn't
 	 * exist, and we should use the genphy driver.
 	 */
@@ -636,6 +639,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	return err;
 
 error:
+	put_device(d);
 	module_put(bus->owner);
 	return err;
 }
@@ -679,6 +683,9 @@ EXPORT_SYMBOL(phy_attach);
 /**
  * phy_detach - detach a PHY device from its network device
  * @phydev: target phy_device struct
+ *
+ * This detaches the phy device from its network device and the phy
+ * driver, and drops the reference count taken in phy_attach_direct().
  */
 void phy_detach(struct phy_device *phydev)
 {
@@ -701,8 +708,13 @@ void phy_detach(struct phy_device *phydev)
 		}
 	}
 
+	/*
+	 * The phydev might go away on the put_device() below, so avoid
+	 * a use-after-free bug by reading the underlying bus first.
+	 */
 	bus = phydev->bus;
 
+	put_device(&phydev->dev);
 	module_put(bus->owner);
 }
 EXPORT_SYMBOL(phy_detach);
-- 
2.1.0

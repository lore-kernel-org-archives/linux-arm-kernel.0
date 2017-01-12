From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Jan 2017 19:41:18 -0800
Subject: [PATCH net-next v2 07/10] net: Relocate dev_to_net_device() into core
In-Reply-To: <20170112034121.27697-1-f.fainelli@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
Message-ID: <20170112034121.27697-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev_to_net_device() is moved from net/dsa/dsa.c to net/core/dev.c since
it going to be used by net/dsa/dsa2.c and the namespace of the function
justifies making it available to other users potentially.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 19 +++++++++++++++++++
 net/dsa/dsa.c             | 18 ------------------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ebd9e2c12f44..d532c070163f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4378,4 +4378,6 @@ do {								\
 #define PTYPE_HASH_SIZE	(16)
 #define PTYPE_HASH_MASK	(PTYPE_HASH_SIZE - 1)
 
+struct net_device *dev_to_net_device(struct device *dev);
+
 #endif	/* _LINUX_NETDEVICE_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index e98cc06d2577..643e4a4491c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8150,6 +8150,25 @@ const char *netdev_drivername(const struct net_device *dev)
 	return empty;
 }
 
+struct net_device *dev_to_net_device(struct device *dev)
+{
+	struct device *d;
+
+	d = device_find_class(dev, "net");
+	if (d) {
+		struct net_device *nd;
+
+		nd = to_net_dev(d);
+		dev_hold(nd);
+		put_device(d);
+
+		return nd;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(dev_to_net_device);
+
 static void __netdev_printk(const char *level, const struct net_device *dev,
 			    struct va_format *vaf)
 {
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 77fa4c4f5828..6c264f92fec5 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -473,24 +473,6 @@ struct mii_bus *dsa_host_dev_to_mii_bus(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dsa_host_dev_to_mii_bus);
 
-static struct net_device *dev_to_net_device(struct device *dev)
-{
-	struct device *d;
-
-	d = device_find_class(dev, "net");
-	if (d != NULL) {
-		struct net_device *nd;
-
-		nd = to_net_dev(d);
-		dev_hold(nd);
-		put_device(d);
-
-		return nd;
-	}
-
-	return NULL;
-}
-
 #ifdef CONFIG_OF
 static int dsa_of_setup_routing_table(struct dsa_platform_data *pd,
 					struct dsa_chip_data *cd,
-- 
2.9.3

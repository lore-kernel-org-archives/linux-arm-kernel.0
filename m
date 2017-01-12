From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Jan 2017 19:41:17 -0800
Subject: [PATCH net-next v2 06/10] net: dsa: Migrate to device_find_class()
In-Reply-To: <20170112034121.27697-1-f.fainelli@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
Message-ID: <20170112034121.27697-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the base device driver code provides an identical
implementation of dev_find_class() utilize device_find_class() instead
of our own version of it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 2306d1b87c83..77fa4c4f5828 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -455,29 +455,11 @@ EXPORT_SYMBOL_GPL(dsa_switch_resume);
 #endif
 
 /* platform driver init and cleanup *****************************************/
-static int dev_is_class(struct device *dev, void *class)
-{
-	if (dev->class != NULL && !strcmp(dev->class->name, class))
-		return 1;
-
-	return 0;
-}
-
-static struct device *dev_find_class(struct device *parent, char *class)
-{
-	if (dev_is_class(parent, class)) {
-		get_device(parent);
-		return parent;
-	}
-
-	return device_find_child(parent, class, dev_is_class);
-}
-
 struct mii_bus *dsa_host_dev_to_mii_bus(struct device *dev)
 {
 	struct device *d;
 
-	d = dev_find_class(dev, "mdio_bus");
+	d = device_find_class(dev, "mdio_bus");
 	if (d != NULL) {
 		struct mii_bus *bus;
 
@@ -495,7 +477,7 @@ static struct net_device *dev_to_net_device(struct device *dev)
 {
 	struct device *d;
 
-	d = dev_find_class(dev, "net");
+	d = device_find_class(dev, "net");
 	if (d != NULL) {
 		struct net_device *nd;
 
-- 
2.9.3

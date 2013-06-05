From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  5 Jun 2013 08:40:07 +0200
Subject: [PATCH 3/5] of: net: introduce a of_set_mac_address() helper function
In-Reply-To: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1370414409-29991-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM MXS code already has some code to allocate and setup a
property that contains the MAC address, and the Marvell Armada 370/XP
code is going to gain a similar copy of this code. Therefore, let's
add a small helper function that does that, in drivers/of/of_net.c.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/of/of_net.c    | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/of_net.h |  6 ++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index ffab033..02af898 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -92,3 +92,39 @@ const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_mac_address);
+
+/**
+ * Set a MAC address of a given network interface device tree node, if
+ * none was already defined.
+ */
+int of_set_mac_address(struct device_node *np, const void *mac)
+{
+	struct property *pp;
+	int ret;
+
+	if (of_get_mac_address(np))
+		return 0;
+
+	pp = kzalloc(sizeof(struct property) + ETH_ALEN, GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pp->value = pp + 1;
+	pp->length = ETH_ALEN;
+	memcpy(pp->value, mac, ETH_ALEN);
+	pp->name = kstrdup("local-mac-address", GFP_KERNEL);
+	if (!pp->name) {
+		kfree(pp);
+		return -ENOMEM;
+	}
+
+	ret = of_update_property(np, pp);
+	if (ret < 0) {
+		kfree(pp->name);
+		kfree(pp);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(of_set_mac_address);
diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 61bf53b..a5086d9 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 extern const int of_get_phy_mode(struct device_node *np);
 extern const void *of_get_mac_address(struct device_node *np);
+extern int of_set_mac_address(struct device_node *np, const void *mac);
 #else
 static inline const int of_get_phy_mode(struct device_node *np)
 {
@@ -21,6 +22,11 @@ static inline const void *of_get_mac_address(struct device_node *np)
 {
 	return NULL;
 }
+
+static inline int of_set_mac_address(struct device_node *np, const void *mac)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __LINUX_OF_NET_H */
-- 
1.8.1.2

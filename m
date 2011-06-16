From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Jun 2011 22:41:36 -0600
Subject: [RFC PATCH 02/11] of/address: Add of_find_matching_node_by_address
	helper
In-Reply-To: <20110616042653.29371.2052.stgit@ponder>
References: <20110616042653.29371.2052.stgit@ponder>
Message-ID: <20110616044130.29371.31242.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_matching_node_by_address() can be used to find a device tree
node for a device at a specific address.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/of/address.c       |   18 ++++++++++++++++++
 include/linux/of_address.h |    4 ++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index b4559c5..da1f4b9 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -577,6 +577,24 @@ int of_address_to_resource(struct device_node *dev, int index,
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
 
+struct device_node *of_find_matching_node_by_address(struct device_node *from,
+					const struct of_device_id *matches,
+					u64 base_address)
+{
+	struct device_node *dn = of_find_matching_node(from, matches);
+	struct resource res;
+
+	while (dn) {
+		if (of_address_to_resource(dn, 0, &res))
+			continue;
+		if (res.start == base_address)
+			return dn;
+		dn = of_find_matching_node(dn, matches);
+	}
+
+	return NULL;
+}
+
 
 /**
  * of_iomap - Maps the memory mapped IO for a given device_node
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 2feda6e..bdfc20d 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -6,6 +6,10 @@
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
+extern struct device_node *of_find_matching_node_by_address(
+					struct device_node *from,
+					const struct of_device_id *matches,
+					u64 base_address);
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
 /* Extract an address from a device, returns the region size and

From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 29 Sep 2014 15:29:24 +0100
Subject: [PATCH v13 05/12] of/pci: Move of_pci_range_to_resources() to
 of/address.c
In-Reply-To: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1412000971-9242-6-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to enhance of_pci_range_to_resources() enough that it won't make
sense for it to be inline anymore.  Move it to drivers/of/address.c,
keeping it under #ifdef CONFIG_PCI.

[bhelgaas: drop extra detail from changelog, move def under CONFIG_PCI]
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
---
 drivers/of/address.c       |  9 +++++++++
 include/linux/of_address.h | 15 +++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 758d4f0..327a574 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -295,6 +295,15 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 }
 EXPORT_SYMBOL_GPL(of_pci_range_parser_one);
 
+void of_pci_range_to_resource(struct of_pci_range *range,
+			      struct device_node *np, struct resource *res)
+{
+	res->flags = range->flags;
+	res->start = range->cpu_addr;
+	res->end = range->cpu_addr + range->size - 1;
+	res->parent = res->child = res->sibling = NULL;
+	res->name = np->full_name;
+}
 #endif /* CONFIG_PCI */
 
 /*
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index ecf913c..fa20aa1 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -129,18 +129,9 @@ extern const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
 			       u64 *size, unsigned int *flags);
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
-
-static inline void of_pci_range_to_resource(struct of_pci_range *range,
-					    struct device_node *np,
-					    struct resource *res)
-{
-	res->flags = range->flags;
-	res->start = range->cpu_addr;
-	res->end = range->cpu_addr + range->size - 1;
-	res->parent = res->child = res->sibling = NULL;
-	res->name = np->full_name;
-}
-
+extern void of_pci_range_to_resource(struct of_pci_range *range,
+				     struct device_node *np,
+				     struct resource *res);
 #else /* CONFIG_OF_ADDRESS && CONFIG_PCI */
 static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
 				             struct resource *r)
-- 
2.1.1

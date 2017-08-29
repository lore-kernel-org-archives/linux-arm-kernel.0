From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 29 Aug 2017 16:25:55 +0200
Subject: [PATCH 1/3] of/pci: Add dma-ranges parsing support
In-Reply-To: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Message-ID: <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several host bridge drivers duplicate of_pci_range_parser_init()
in order to parse their dma-ranges property.

Provide of_pci_dma_range_parser_init() for that use-case.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/of/address.c       | 19 ++++++++++++++++---
 include/linux/of_address.h | 10 +++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 580bbf6ca2b1..4cfd29e4ee1b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -232,8 +232,8 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
-int of_pci_range_parser_init(struct of_pci_range_parser *parser,
-				struct device_node *node)
+static int parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node, const char *name)
 {
 	const int na = 3, ns = 2;
 	int rlen;
@@ -242,7 +242,7 @@ int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 	parser->pna = of_n_addr_cells(node);
 	parser->np = parser->pna + na + ns;
 
-	parser->range = of_get_property(node, "ranges", &rlen);
+	parser->range = of_get_property(node, name, &rlen);
 	if (parser->range == NULL)
 		return -ENOENT;
 
@@ -250,8 +250,21 @@ int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 
 	return 0;
 }
+
+int of_pci_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	return parser_init(parser, node, "ranges");
+}
 EXPORT_SYMBOL_GPL(of_pci_range_parser_init);
 
+int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	return parser_init(parser, node, "dma-ranges");
+}
+EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
+
 struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 						struct of_pci_range *range)
 {
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 37864734ca50..8beed2de98e9 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -49,6 +49,8 @@ extern const __be32 *of_get_address(struct device_node *dev, int index,
 
 extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
+extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node);
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
@@ -85,7 +87,13 @@ static inline const __be32 *of_get_address(struct device_node *dev, int index,
 static inline int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node)
 {
-	return -1;
+	return -ENOSYS;
+}
+
+static inline int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node)
+{
+	return -ENOSYS;
 }
 
 static inline struct of_pci_range *of_pci_range_parser_one(
-- 
2.11.0

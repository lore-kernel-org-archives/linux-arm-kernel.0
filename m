From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Oct 2017 22:08:53 -0700
Subject: [PATCH v4 1/5] of/platform: Generalize /reserved-memory handling
In-Reply-To: <20171011050857.7588-1-bjorn.andersson@linaro.org>
References: <20171011050857.7588-1-bjorn.andersson@linaro.org>
Message-ID: <20171011050857.7588-2-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By iterating over all /reserved-memory child nodes and match each one to
a list of compatibles that we want to treat specially, we can easily
extend the list of compatibles to handle - without having to resort to
of_platform_populate() that would create unnecessary platform_devices.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Picked up Rob's R-b

Changes since v2:
- Simplify logic per Rob's suggestion.

Changes since v1:
- New patch
 drivers/of/platform.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b19524623498..ee89f096f0f3 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -497,6 +497,11 @@ int of_platform_default_populate(struct device_node *root,
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
 #ifndef CONFIG_PPC
+static const struct of_device_id reserved_mem_matches[] = {
+	{ .compatible = "ramoops" },
+	{}
+};
+
 static int __init of_platform_default_populate_init(void)
 {
 	struct device_node *node;
@@ -505,15 +510,12 @@ static int __init of_platform_default_populate_init(void)
 		return -ENODEV;
 
 	/*
-	 * Handle ramoops explicitly, since it is inside /reserved-memory,
-	 * which lacks a "compatible" property.
+	 * Handle certain compatibles explicitly, since we don't want to create
+	 * platform_devices for every node in /reserved-memory with a
+	 * "compatible",
 	 */
-	node = of_find_node_by_path("/reserved-memory");
-	if (node) {
-		node = of_find_compatible_node(node, NULL, "ramoops");
-		if (node)
-			of_platform_device_create(node, NULL, NULL);
-	}
+	for_each_matching_node(node, reserved_mem_matches)
+		of_platform_device_create(node, NULL, NULL);
 
 	/* Populate everything else. */
 	of_platform_default_populate(NULL, NULL, NULL);
-- 
2.12.0

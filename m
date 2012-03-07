From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:50 +0000
Subject: [PATCH 09/14] ARM: kirkwood: mv_cesa devicetree bindings
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <65fc66fea1c3d768f27eb8613518ae2c8ae74e40.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Walle <michael@walle.cc>

Written by Michael Walle, modified by Jason Cooper to use Marvell ticker
symbol in compatible property.  Also, changed patch subject to conform
to standard convention.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Changes from previous version:

* s/marvell,/mrvl,/g for compatible properties
* split into binding patch and a use patch.

 .../devicetree/bindings/crypto/mv_cesa.txt         |   18 ++++++++++++++++++
 drivers/crypto/mv_cesa.c                           |   13 +++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt

diff --git a/Documentation/devicetree/bindings/crypto/mv_cesa.txt b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
new file mode 100644
index 0000000..aa7135b
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
@@ -0,0 +1,18 @@
+Marvell Cryptographic Engines And Security Accelerator
+
+Required properties:
+- compatible : should be "mrvl,orion-crypto"
+- reg : base physical address of the engine and length of memory mapped
+        region, followed by base physical address of sram and its memory
+		length
+- interrupts : interrupt number
+
+Examples:
+
+crypto at f1030000 {
+	compatible = "mrvl,orion-crypto";
+	reg = <0xf1030000 0x10000
+	       0xf5000000 0x800>;    /* sram */
+	interrupts = <22>;
+};
+
diff --git a/drivers/crypto/mv_cesa.c b/drivers/crypto/mv_cesa.c
index 597235a..457f69f 100644
--- a/drivers/crypto/mv_cesa.c
+++ b/drivers/crypto/mv_cesa.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sha.h>
+#include <linux/of_platform.h>
 
 #include "mv_cesa.h"
 
@@ -1000,6 +1001,8 @@ static int mv_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
 		return -ENXIO;
 
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
@@ -1015,6 +1018,8 @@ static int mv_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
 		ret = -ENXIO;
 		goto err_unmap_reg;
@@ -1118,12 +1123,20 @@ static int mv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id mv_cesa_dt_ids[] = {
+	{ .compatible = "mrvl,orion-crypto", },
+	{},
+};
+#endif
+
 static struct platform_driver marvell_crypto = {
 	.probe		= mv_probe,
 	.remove		= mv_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "mv_crypto",
+		.of_match_table = of_match_ptr(mv_cesa_dt_ids),
 	},
 };
 MODULE_ALIAS("platform:mv_crypto");
-- 
1.7.3.4

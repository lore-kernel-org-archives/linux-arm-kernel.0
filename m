From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Feb 2017 03:27:13 +0800
Subject: [PATCH v5 1/3] nvmem: sunxi-sid: read NVMEM size from device
 compatible
Message-ID: <20170227192715.50198-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes the SID device have more memory address space than the real
NVMEM size (for the registers used to read/write the SID).

Fetch the NVMEM size from device compatible, rather than the memory
address space's length, in order to prepare for adding some
registers-based read support.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
Changes in v4:
- Added Maxime's ACK.

 drivers/nvmem/sunxi_sid.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 1567ccca8de3..69524b67007f 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/random.h>
@@ -32,6 +33,10 @@ static struct nvmem_config econfig = {
 	.owner = THIS_MODULE,
 };
 
+struct sunxi_sid_cfg {
+	u32	size;
+};
+
 struct sunxi_sid {
 	void __iomem		*base;
 };
@@ -72,18 +77,24 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	struct sunxi_sid *sid;
 	int ret, i, size;
 	char *randomness;
+	const struct sunxi_sid_cfg *cfg;
 
 	sid = devm_kzalloc(dev, sizeof(*sid), GFP_KERNEL);
 	if (!sid)
 		return -ENOMEM;
 
+	cfg = of_device_get_match_data(dev);
+	if (!cfg)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sid->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-	size = resource_size(res) - 1;
-	econfig.size = resource_size(res);
+	size = cfg->size;
+
+	econfig.size = size;
 	econfig.dev = dev;
 	econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
@@ -119,9 +130,17 @@ static int sunxi_sid_remove(struct platform_device *pdev)
 	return nvmem_unregister(nvmem);
 }
 
+static const struct sunxi_sid_cfg sun4i_a10_cfg = {
+	.size = 0x10,
+};
+
+static const struct sunxi_sid_cfg sun7i_a20_cfg = {
+	.size = 0x200,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-sid" },
-	{ .compatible = "allwinner,sun7i-a20-sid" },
+	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
+	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.11.1

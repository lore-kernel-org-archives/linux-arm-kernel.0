From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 29 Jan 2017 09:56:40 +0800
Subject: [PATCH v2 1/2] nvmem: sunxi-sid: add support for H3 and A64's SID
 controller
Message-ID: <20170129015641.54281-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 and A64 SoCs have a bigger SID controller, which has its direct read
address at 0x200 position in the SID block, not 0x0.

Also, H3 SID controller has some silicon bug that makes the direct read
value wrong at first, add code to workaround the bug. (This bug has
already been fixed on A64 and later SoCs)

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Set the size of SID in per-of-compatible config, not in the reg property
  of device tree.
- use 0x400 (1K, as the datasheet advised) as the size of the SID block on
  H3.
- Removed the code that skips the SID space after 0x10.

 .../bindings/nvmem/allwinner,sunxi-sid.txt         |  17 +++-
 drivers/nvmem/sunxi_sid.c                          | 106 ++++++++++++++++++++-
 2 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d543ed3f5363..a3c07450d056 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -1,7 +1,12 @@
 Allwinner sunxi-sid
 
 Required properties:
-- compatible: "allwinner,sun4i-a10-sid" or "allwinner,sun7i-a20-sid"
+- compatible: Should be one of the following (depending on your SoC):
+  "allwinner,sun4i-a10-sid"
+  "allwinner,sun7i-a20-sid"
+  "allwinner,sun8i-h3-sid"
+  "allwinner,sun50i-a64-sid"
+
 - reg: Should contain registers location and length
 
 = Data cells =
@@ -11,11 +16,17 @@ bindings/nvmem/nvmem.txt
 Example for sun4i:
 	sid at 01c23800 {
 		compatible = "allwinner,sun4i-a10-sid";
-		reg = <0x01c23800 0x10>
+		reg = <0x01c23800 0x10>;
 	};
 
 Example for sun7i:
 	sid at 01c23800 {
 		compatible = "allwinner,sun7i-a20-sid";
-		reg = <0x01c23800 0x200>
+		reg = <0x01c23800 0x200>;
+	};
+
+Example for sun8i-h3:
+	sid at 01c14000 {
+		compatible = "allwinner,sun8i-h3-sid";
+		reg = <0x01c14000 0x400>;
 	};
diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 1567ccca8de3..962db79ea8d2 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -20,10 +20,21 @@
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/random.h>
 
+/* Registers and special values for doing register-based SID readout on H3 */
+#define SUN8I_SID_PRCTL		0x40
+#define SUN8I_SID_RDKEY		0x60
+
+#define SUN8I_SID_OP_LOCK	0xAC
+#define SUN8I_SID_OFFSET_MASK	0x1FF
+#define SUN8I_SID_OFFSET_SHIFT	16
+#define SUN8I_SID_LOCK_SHIFT	8
+#define SUN8I_SID_READ		BIT(1)
+
 static struct nvmem_config econfig = {
 	.name = "sunxi-sid",
 	.read_only = true,
@@ -32,8 +43,15 @@ static struct nvmem_config econfig = {
 	.owner = THIS_MODULE,
 };
 
+struct sunxi_sid_cfg {
+	u32	value_offset;
+	u32	size;
+	bool	need_register_readout;
+};
+
 struct sunxi_sid {
 	void __iomem		*base;
+	u32			value_offset;
 };
 
 /* We read the entire key, due to a 32 bit read alignment requirement. Since we
@@ -46,7 +64,8 @@ static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
 {
 	u32 sid_key;
 
-	sid_key = ioread32be(sid->base + round_down(offset, 4));
+	sid_key = ioread32be(sid->base + sid->value_offset +
+			     round_down(offset, 4));
 	sid_key >>= (offset % 4) * 8;
 
 	return sid_key; /* Only return the last byte */
@@ -64,6 +83,33 @@ static int sunxi_sid_read(void *context, unsigned int offset,
 	return 0;
 }
 
+static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
+				      const unsigned int word,
+				      u32 *out)
+{
+	u32 reg_val;
+	unsigned long expire = jiffies + msecs_to_jiffies(250);
+
+	/* Set word, lock access, and set read command */
+	reg_val = (word & SUN8I_SID_OFFSET_MASK)
+		  << SUN8I_SID_OFFSET_SHIFT;
+	reg_val |= SUN8I_SID_OP_LOCK << SUN8I_SID_LOCK_SHIFT;
+	reg_val |= SUN8I_SID_READ;
+	writel(reg_val, sid->base + SUN8I_SID_PRCTL);
+
+	do {
+		reg_val = readl(sid->base + SUN8I_SID_PRCTL);
+	} while (time_before(jiffies, expire) && (reg_val & SUN8I_SID_READ));
+
+	if (reg_val & SUN8I_SID_READ)
+		return -EIO;
+
+	if (out)
+		*out = readl(sid->base + SUN8I_SID_RDKEY);
+	writel(0, sid->base + SUN8I_SID_PRCTL);
+	return 0;
+}
+
 static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -72,18 +118,42 @@ static int sunxi_sid_probe(struct platform_device *pdev)
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
+	sid->value_offset = cfg->value_offset;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sid->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(sid->base))
 		return PTR_ERR(sid->base);
 
-	size = resource_size(res) - 1;
-	econfig.size = resource_size(res);
+	size = cfg->size;
+
+	if (cfg->need_register_readout) {
+		/*
+		 * H3's SID controller have a bug that the value at 0x200
+		 * offset is not the correct value when the hardware is reset.
+		 * However, after doing a register-based read operation, the
+		 * value become right.
+		 * Do a full read operation here, but ignore its value
+		 * (as it's more fast to read by direct MMIO value than
+		 * with registers)
+		 */
+		for (i = 0; i < (size >> 2); i++) {
+			ret = sun8i_sid_register_readout(sid, i, NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	econfig.size = size;
 	econfig.dev = dev;
 	econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
@@ -119,9 +189,35 @@ static int sunxi_sid_remove(struct platform_device *pdev)
 	return nvmem_unregister(nvmem);
 }
 
+static const struct sunxi_sid_cfg sun4i_a10_cfg = {
+	.value_offset = 0,
+	.size = 0x10,
+	.need_register_readout = false,
+};
+
+static const struct sunxi_sid_cfg sun7i_a20_cfg = {
+	.value_offset = 0,
+	.size = 0x200,
+	.need_register_readout = false,
+};
+
+static const struct sunxi_sid_cfg sun8i_h3_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+	.need_register_readout = true,
+};
+
+static const struct sunxi_sid_cfg sun50i_a64_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+	.need_register_readout = false,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-sid" },
-	{ .compatible = "allwinner,sun7i-a20-sid" },
+	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
+	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
+	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.11.0

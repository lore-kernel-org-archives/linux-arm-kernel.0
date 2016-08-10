From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Wed, 10 Aug 2016 14:50:43 +0800
Subject: [PATCH v1 4/4] nvmem: rockchip-efuse: add rk3399-efuse support
In-Reply-To: <1470811843-42668-1-git-send-email-finley.xiao@rock-chips.com>
References: <1470811843-42668-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1470811843-42668-5-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

1) the efuse timing of rk3399 is different from earlier SoCs.
2) rk3399-efuse is organized as 32bits by 32 one-time programmable
electrical fuses, the efuse of earlier SoCs is organized as 32bits
by 8 one-time programmable electrical fuses with random access interface.

This patch adds a new read function for rk3399-efuse.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/nvmem/rockchip-efuse.c | 132 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 20 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 4d3f391..58fee00b 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -22,17 +22,28 @@
 #include <linux/nvmem-provider.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#define EFUSE_A_SHIFT			6
-#define EFUSE_A_MASK			0x3ff
-#define EFUSE_PGENB			BIT(3)
-#define EFUSE_LOAD			BIT(2)
-#define EFUSE_STROBE			BIT(1)
-#define EFUSE_CSB			BIT(0)
-
-#define REG_EFUSE_CTRL			0x0000
-#define REG_EFUSE_DOUT			0x0004
+#define RK3288_A_SHIFT		6
+#define RK3288_A_MASK		0x3ff
+#define RK3288_PGENB		BIT(3)
+#define RK3288_LOAD			BIT(2)
+#define RK3288_STROBE		BIT(1)
+#define RK3288_CSB			BIT(0)
+
+#define RK3399_A_SHIFT		16
+#define RK3399_A_MASK		0x3ff
+#define RK3399_NBYTES		4
+#define RK3399_STROBSFTSEL	BIT(9)
+#define RK3399_PD			BIT(5)
+#define RK3399_PGENB		BIT(3)
+#define RK3399_LOAD			BIT(2)
+#define RK3399_STROBE		BIT(1)
+#define RK3399_CSB			BIT(0)
+
+#define REG_EFUSE_CTRL		0x0000
+#define REG_EFUSE_DOUT		0x0004
 
 struct rockchip_efuse_chip {
 	struct device *dev;
@@ -40,8 +51,8 @@ struct rockchip_efuse_chip {
 	struct clk *clk;
 };
 
-static int rockchip_efuse_read(void *context, unsigned int offset,
-			       void *val, size_t bytes)
+static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
+				      void *val, size_t bytes)
 {
 	struct rockchip_efuse_chip *efuse = context;
 	u8 *buf = val;
@@ -53,27 +64,78 @@ static int rockchip_efuse_read(void *context, unsigned int offset,
 		return ret;
 	}
 
-	writel(EFUSE_LOAD | EFUSE_PGENB, efuse->base + REG_EFUSE_CTRL);
+	writel(RK3288_LOAD | RK3288_PGENB, efuse->base + REG_EFUSE_CTRL);
 	udelay(1);
 	while (bytes--) {
 		writel(readl(efuse->base + REG_EFUSE_CTRL) &
-			     (~(EFUSE_A_MASK << EFUSE_A_SHIFT)),
+			     (~(RK3288_A_MASK << RK3288_A_SHIFT)),
 			     efuse->base + REG_EFUSE_CTRL);
 		writel(readl(efuse->base + REG_EFUSE_CTRL) |
-			     ((offset++ & EFUSE_A_MASK) << EFUSE_A_SHIFT),
+			     ((offset++ & RK3288_A_MASK) << RK3288_A_SHIFT),
 			     efuse->base + REG_EFUSE_CTRL);
 		udelay(1);
 		writel(readl(efuse->base + REG_EFUSE_CTRL) |
-			     EFUSE_STROBE, efuse->base + REG_EFUSE_CTRL);
+			     RK3288_STROBE, efuse->base + REG_EFUSE_CTRL);
 		udelay(1);
 		*buf++ = readb(efuse->base + REG_EFUSE_DOUT);
 		writel(readl(efuse->base + REG_EFUSE_CTRL) &
-		     (~EFUSE_STROBE), efuse->base + REG_EFUSE_CTRL);
+		     (~RK3288_STROBE), efuse->base + REG_EFUSE_CTRL);
 		udelay(1);
 	}
 
 	/* Switch to standby mode */
-	writel(EFUSE_PGENB | EFUSE_CSB, efuse->base + REG_EFUSE_CTRL);
+	writel(RK3288_PGENB | RK3288_CSB, efuse->base + REG_EFUSE_CTRL);
+
+	clk_disable_unprepare(efuse->clk);
+
+	return 0;
+}
+
+static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
+				      void *val, size_t bytes)
+{
+	struct rockchip_efuse_chip *efuse = context;
+	unsigned int addr_start, addr_end, addr_offset, addr_len;
+	unsigned int out_value;
+	unsigned char *buf;
+	int ret, i = 0;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret < 0) {
+		dev_err(efuse->dev, "failed to prepare/enable efuse clk\n");
+		return ret;
+	}
+
+	addr_start = rounddown(offset, RK3399_NBYTES) / RK3399_NBYTES;
+	addr_end = roundup(offset + bytes, RK3399_NBYTES) / RK3399_NBYTES;
+	addr_offset = offset % RK3399_NBYTES;
+	addr_len = addr_end - addr_start;
+
+	buf = kzalloc(sizeof(*buf) * addr_len * RK3399_NBYTES, GFP_KERNEL);
+
+	writel(RK3399_LOAD | RK3399_PGENB | RK3399_STROBSFTSEL,
+	       efuse->base + REG_EFUSE_CTRL);
+	udelay(1);
+	while (addr_len--) {
+		writel(readl(efuse->base + REG_EFUSE_CTRL) | RK3399_STROBE |
+			((addr_start++ & RK3399_A_MASK) << RK3399_A_SHIFT),
+			efuse->base + REG_EFUSE_CTRL);
+		udelay(1);
+		out_value = readl(efuse->base + REG_EFUSE_DOUT);
+		writel(readl(efuse->base + REG_EFUSE_CTRL) & (~RK3399_STROBE),
+		       efuse->base + REG_EFUSE_CTRL);
+		udelay(1);
+
+		memcpy(&buf[i], &out_value, RK3399_NBYTES);
+		i += RK3399_NBYTES;
+	}
+
+	/* Switch to standby mode */
+	writel(RK3399_PD | RK3399_CSB, efuse->base + REG_EFUSE_CTRL);
+
+	memcpy(val, buf + addr_offset, bytes);
+
+	kfree(buf);
 
 	clk_disable_unprepare(efuse->clk);
 
@@ -89,7 +151,22 @@ static struct nvmem_config econfig = {
 };
 
 static const struct of_device_id rockchip_efuse_match[] = {
-	{ .compatible = "rockchip,rockchip-efuse", },
+	{
+		.compatible = "rockchip,rk3066a-efuse",
+		.data = (void *)&rockchip_rk3288_efuse_read,
+	},
+	{
+		.compatible = "rockchip,rk3188-efuse",
+		.data = (void *)&rockchip_rk3288_efuse_read,
+	},
+	{
+		.compatible = "rockchip,rk3288-efuse",
+		.data = (void *)&rockchip_rk3288_efuse_read,
+	},
+	{
+		.compatible = "rockchip,rk3399-efuse",
+		.data = (void *)&rockchip_rk3399_efuse_read,
+	},
 	{ /* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, rockchip_efuse_match);
@@ -99,6 +176,14 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct rockchip_efuse_chip *efuse;
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match || !match->data) {
+		dev_err(dev, "failed to get match data\n");
+		return -EINVAL;
+	}
 
 	efuse = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_efuse_chip),
 			     GFP_KERNEL);
@@ -116,7 +201,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 
 	efuse->dev = &pdev->dev;
 	econfig.size = resource_size(res);
-	econfig.reg_read = rockchip_efuse_read;
+	econfig.reg_read = match->data;
 	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
 	nvmem = nvmem_register(&econfig);
@@ -144,6 +229,13 @@ static struct platform_driver rockchip_efuse_driver = {
 	},
 };
 
-module_platform_driver(rockchip_efuse_driver);
+static int __init rockchip_efuse_module_init(void)
+{
+	return platform_driver_probe(&rockchip_efuse_driver,
+				     rockchip_efuse_probe);
+}
+
+subsys_initcall(rockchip_efuse_module_init);
+
 MODULE_DESCRIPTION("rockchip_efuse driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

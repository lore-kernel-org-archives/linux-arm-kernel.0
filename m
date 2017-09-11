From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 11 Sep 2017 22:01:02 +0900
Subject: [PATCH 3/5] nvmem: mtk-efuse: fix different address space warnings of
 sparse
In-Reply-To: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1505134864-11975-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

drivers/nvmem/mtk-efuse.c:24:30: warning: incorrect type in initializer (different address spaces)
drivers/nvmem/mtk-efuse.c:24:30:    expected void [noderef] <asn:2>*base
drivers/nvmem/mtk-efuse.c:24:30:    got void *context
drivers/nvmem/mtk-efuse.c:37:30: warning: incorrect type in initializer (different address spaces)
drivers/nvmem/mtk-efuse.c:37:30:    expected void [noderef] <asn:2>*base
drivers/nvmem/mtk-efuse.c:37:30:    got void *context
drivers/nvmem/mtk-efuse.c:69:23: warning: incorrect type in assignment (different address spaces)
drivers/nvmem/mtk-efuse.c:69:23:    expected void *priv
drivers/nvmem/mtk-efuse.c:69:23:    got void [noderef] <asn:2>*[assigned] base

The type of nvmem_config->priv is (void *), so sparse complains
about assignment of the base address with (void __iomem *) type.

Even if we cast it out, sparse still warns:
warning: cast removes address space of expression

Of course, we can shut up the sparse by marking __force, but a more
correct way is to put the base address into driver private data.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/nvmem/mtk-efuse.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index fa7a0f6..c4058b5 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -18,15 +18,19 @@
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 
+struct mtk_efuse_priv {
+	void __iomem *base;
+};
+
 static int mtk_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
-	void __iomem *base = context;
+	struct mtk_efuse_priv *priv = context;
 	u32 *val = _val;
 	int i = 0, words = bytes / 4;
 
 	while (words--)
-		*val++ = readl(base + reg + (i++ * 4));
+		*val++ = readl(priv->base + reg + (i++ * 4));
 
 	return 0;
 }
@@ -34,12 +38,12 @@ static int mtk_reg_read(void *context,
 static int mtk_reg_write(void *context,
 			 unsigned int reg, void *_val, size_t bytes)
 {
-	void __iomem *base = context;
+	struct mtk_efuse_priv *priv = context;
 	u32 *val = _val;
 	int i = 0, words = bytes / 4;
 
 	while (words--)
-		writel(*val++, base + reg + (i++ * 4));
+		writel(*val++, priv->base + reg + (i++ * 4));
 
 	return 0;
 }
@@ -50,19 +54,23 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct nvmem_config econfig = {};
-	void __iomem *base;
+	struct mtk_efuse_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
 
 	econfig.stride = 4;
 	econfig.word_size = 4;
 	econfig.reg_read = mtk_reg_read;
 	econfig.reg_write = mtk_reg_write;
 	econfig.size = resource_size(res);
-	econfig.priv = base;
+	econfig.priv = priv;
 	econfig.dev = dev;
 	econfig.owner = THIS_MODULE;
 	nvmem = nvmem_register(&econfig);
-- 
2.7.4

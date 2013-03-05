From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:29 +0100
Subject: [PATCH 19/23] ASoC: samsung: use irq resource for idma
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-20-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With multiplatform kernels, we cannot use hardwired IRQ
numbers in device drivers. This changes the idma driver
to use a proper resource, like all other drivers do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-samsung/devs.c |  6 ++++++
 sound/soc/samsung/idma.c     | 10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 58fb02a..ec912e4 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -146,14 +146,20 @@ struct platform_device s3c_device_camif = {
 
 /* ASOC DMA */
 
+#ifdef CONFIG_PLAT_S5P 
+static struct resource samsung_asoc_idma_resource = DEFINE_RES_IRQ(IRQ_I2S0);
+
 struct platform_device samsung_asoc_idma = {
 	.name		= "samsung-idma",
 	.id		= -1,
+	.num_resources	= 1,
+	.resource	= &samsung_asoc_idma_resource,
 	.dev		= {
 		.dma_mask		= &samsung_device_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	}
 };
+#endif
 
 /* FB */
 
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index a07950b..f36a541 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -68,6 +68,8 @@ static struct idma_info {
 	dma_addr_t	lp_tx_addr;
 } idma;
 
+static int idma_irq;
+
 static void idma_getpos(dma_addr_t *src)
 {
 	*src = idma.lp_tx_addr +
@@ -305,7 +307,7 @@ static int idma_open(struct snd_pcm_substream *substream)
 	if (prtd == NULL)
 		return -ENOMEM;
 
-	ret = request_irq(IRQ_I2S0, iis_irq, 0, "i2s", prtd);
+	ret = request_irq(idma_irq, iis_irq, 0, "i2s", prtd);
 	if (ret < 0) {
 		pr_err("fail to claim i2s irq , ret = %d\n", ret);
 		kfree(prtd);
@@ -324,7 +326,7 @@ static int idma_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct idma_ctrl *prtd = runtime->private_data;
 
-	free_irq(IRQ_I2S0, prtd);
+	free_irq(idma_irq, prtd);
 
 	if (!prtd)
 		pr_err("idma_close called with prtd == NULL\n");
@@ -418,6 +420,10 @@ static struct snd_soc_platform_driver asoc_idma_platform = {
 
 static int asoc_idma_platform_probe(struct platform_device *pdev)
 {
+	idma_irq = platform_get_irq(pdev, 0);
+	if (idma_irq < 0)
+		return idma_irq;
+
 	return snd_soc_register_platform(&pdev->dev, &asoc_idma_platform);
 }
 
-- 
1.8.1.2

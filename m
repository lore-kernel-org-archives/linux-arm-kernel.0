From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 12 Mar 2015 00:39:49 +0000
Subject: [PATCH 1/2 v2] dmaengine: remove Renesas Audio DMAC peri peri
In-Reply-To: <87pp8ff3sb.wl%kuninori.morimoto.gx@renesas.com>
References: <87pp8ff3sb.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87oanzf3r1.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
not a general purpose DMAC (2nd DMAC is for Device to Device inside
sound system). Additionally, current DMAEngine can't support Device to
Device, and we don't have correct DT bindings for it at this point.
So the easiest solution for it is that move it from DMAEngine to rsnd
driver.
Audio DMAC peri peri on DMAEngine is no longer needed. remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2

 - remove DT bindings text

 .../devicetree/bindings/dma/rcar-audmapp.txt       |  29 --
 drivers/dma/sh/Kconfig                             |   6 -
 drivers/dma/sh/Makefile                            |   1 -
 drivers/dma/sh/rcar-audmapp.c                      | 376 ---------------------
 4 files changed, 412 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/rcar-audmapp.txt
 delete mode 100644 drivers/dma/sh/rcar-audmapp.c

diff --git a/Documentation/devicetree/bindings/dma/rcar-audmapp.txt b/Documentation/devicetree/bindings/dma/rcar-audmapp.txt
deleted file mode 100644
index 61bca50..0000000
--- a/Documentation/devicetree/bindings/dma/rcar-audmapp.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* R-Car Audio DMAC peri peri Device Tree bindings
-
-Required properties:
-- compatible:	should be "renesas,rcar-audmapp"
-- #dma-cells:	should be <1>, see "dmas" property below
-
-Example:
-	audmapp: audio-dma-pp at 0xec740000 {
-		compatible = "renesas,rcar-audmapp";
-		#dma-cells = <1>;
-
-		reg = <0 0xec740000 0 0x200>;
-	};
-
-
-* DMA client
-
-Required properties:
-- dmas:		a list of <[DMA multiplexer phandle] [SRS << 8 | DRS]> pairs.
-		where SRS/DRS are specified in the SoC manual.
-		It will be written into PDMACHCR as high 16-bit parts.
-- dma-names:	a list of DMA channel names, one per "dmas" entry
-
-Example:
-
-	dmas = <&audmapp 0x2d00
-		&audmapp 0x3700>;
-	dma-names =  "src0_ssiu0",
-		     "dvc0_ssiu0";
diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 8190ad2..725f6b4 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -51,12 +51,6 @@ config RCAR_HPB_DMAE
 	help
 	  Enable support for the Renesas R-Car series DMA controllers.
 
-config RCAR_AUDMAC_PP
-	tristate "Renesas R-Car Audio DMAC Peripheral Peripheral support"
-	depends on SH_DMAE_BASE
-	help
-	  Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.
-
 config RCAR_DMAC
 	tristate "Renesas R-Car Gen2 DMA Controller"
 	depends on ARCH_SHMOBILE || COMPILE_TEST
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 2852f9d..489609b 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -15,5 +15,4 @@ obj-$(CONFIG_SH_DMAE) += shdma.o
 
 obj-$(CONFIG_SUDMAC) += sudmac.o
 obj-$(CONFIG_RCAR_HPB_DMAE) += rcar-hpbdma.o
-obj-$(CONFIG_RCAR_AUDMAC_PP) += rcar-audmapp.o
 obj-$(CONFIG_RCAR_DMAC) += rcar-dmac.o
diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
deleted file mode 100644
index d95bbdd..0000000
--- a/drivers/dma/sh/rcar-audmapp.c
+++ /dev/null
@@ -1,376 +0,0 @@
-/*
- * This is for Renesas R-Car Audio-DMAC-peri-peri.
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- * Copyright (C) 2014 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * based on the drivers/dma/sh/shdma.c
- *
- * Copyright (C) 2011-2012 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
- *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/dmaengine.h>
-#include <linux/of_dma.h>
-#include <linux/platform_data/dma-rcar-audmapp.h>
-#include <linux/platform_device.h>
-#include <linux/shdma-base.h>
-
-/*
- * DMA register
- */
-#define PDMASAR		0x00
-#define PDMADAR		0x04
-#define PDMACHCR	0x0c
-
-/* PDMACHCR */
-#define PDMACHCR_DE		(1 << 0)
-
-#define AUDMAPP_MAX_CHANNELS	29
-
-/* Default MEMCPY transfer size = 2^2 = 4 bytes */
-#define LOG2_DEFAULT_XFER_SIZE	2
-#define AUDMAPP_SLAVE_NUMBER	256
-#define AUDMAPP_LEN_MAX		(16 * 1024 * 1024)
-
-struct audmapp_chan {
-	struct shdma_chan shdma_chan;
-	void __iomem *base;
-	dma_addr_t slave_addr;
-	u32 chcr;
-};
-
-struct audmapp_device {
-	struct shdma_dev shdma_dev;
-	struct audmapp_pdata *pdata;
-	struct device *dev;
-	void __iomem *chan_reg;
-};
-
-struct audmapp_desc {
-	struct shdma_desc shdma_desc;
-	dma_addr_t src;
-	dma_addr_t dst;
-};
-
-#define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
-
-#define to_chan(chan) container_of(chan, struct audmapp_chan, shdma_chan)
-#define to_desc(sdesc) container_of(sdesc, struct audmapp_desc, shdma_desc)
-#define to_dev(chan) container_of(chan->shdma_chan.dma_chan.device,	\
-				  struct audmapp_device, shdma_dev.dma_dev)
-
-static void audmapp_write(struct audmapp_chan *auchan, u32 data, u32 reg)
-{
-	struct audmapp_device *audev = to_dev(auchan);
-	struct device *dev = audev->dev;
-
-	dev_dbg(dev, "w %p : %08x\n", auchan->base + reg, data);
-
-	iowrite32(data, auchan->base + reg);
-}
-
-static u32 audmapp_read(struct audmapp_chan *auchan, u32 reg)
-{
-	return ioread32(auchan->base + reg);
-}
-
-static void audmapp_halt(struct shdma_chan *schan)
-{
-	struct audmapp_chan *auchan = to_chan(schan);
-	int i;
-
-	audmapp_write(auchan, 0, PDMACHCR);
-
-	for (i = 0; i < 1024; i++) {
-		if (0 == audmapp_read(auchan, PDMACHCR))
-			return;
-		udelay(1);
-	}
-}
-
-static void audmapp_start_xfer(struct shdma_chan *schan,
-			       struct shdma_desc *sdesc)
-{
-	struct audmapp_chan *auchan = to_chan(schan);
-	struct audmapp_device *audev = to_dev(auchan);
-	struct audmapp_desc *desc = to_desc(sdesc);
-	struct device *dev = audev->dev;
-	u32 chcr = auchan->chcr | PDMACHCR_DE;
-
-	dev_dbg(dev, "src/dst/chcr = %pad/%pad/%08x\n",
-		&desc->src, &desc->dst, chcr);
-
-	audmapp_write(auchan, desc->src,	PDMASAR);
-	audmapp_write(auchan, desc->dst,	PDMADAR);
-	audmapp_write(auchan, chcr,	PDMACHCR);
-}
-
-static int audmapp_get_config(struct audmapp_chan *auchan, int slave_id,
-			      u32 *chcr, dma_addr_t *dst)
-{
-	struct audmapp_device *audev = to_dev(auchan);
-	struct audmapp_pdata *pdata = audev->pdata;
-	struct audmapp_slave_config *cfg;
-	int i;
-
-	*chcr	= 0;
-	*dst	= 0;
-
-	if (!pdata) { /* DT */
-		*chcr = ((u32)slave_id) << 16;
-		auchan->shdma_chan.slave_id = (slave_id) >> 8;
-		return 0;
-	}
-
-	/* non-DT */
-
-	if (slave_id >= AUDMAPP_SLAVE_NUMBER)
-		return -ENXIO;
-
-	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
-		if (cfg->slave_id == slave_id) {
-			*chcr	= cfg->chcr;
-			*dst	= cfg->dst;
-			return 0;
-		}
-
-	return -ENXIO;
-}
-
-static int audmapp_set_slave(struct shdma_chan *schan, int slave_id,
-			     dma_addr_t slave_addr, bool try)
-{
-	struct audmapp_chan *auchan = to_chan(schan);
-	u32 chcr;
-	dma_addr_t dst;
-	int ret;
-
-	ret = audmapp_get_config(auchan, slave_id, &chcr, &dst);
-	if (ret < 0)
-		return ret;
-
-	if (try)
-		return 0;
-
-	auchan->chcr		= chcr;
-	auchan->slave_addr	= slave_addr ? : dst;
-
-	return 0;
-}
-
-static int audmapp_desc_setup(struct shdma_chan *schan,
-			      struct shdma_desc *sdesc,
-			      dma_addr_t src, dma_addr_t dst, size_t *len)
-{
-	struct audmapp_desc *desc = to_desc(sdesc);
-
-	if (*len > (size_t)AUDMAPP_LEN_MAX)
-		*len = (size_t)AUDMAPP_LEN_MAX;
-
-	desc->src = src;
-	desc->dst = dst;
-
-	return 0;
-}
-
-static void audmapp_setup_xfer(struct shdma_chan *schan,
-			       int slave_id)
-{
-}
-
-static dma_addr_t audmapp_slave_addr(struct shdma_chan *schan)
-{
-	struct audmapp_chan *auchan = to_chan(schan);
-
-	return auchan->slave_addr;
-}
-
-static bool audmapp_channel_busy(struct shdma_chan *schan)
-{
-	struct audmapp_chan *auchan = to_chan(schan);
-	u32 chcr = audmapp_read(auchan, PDMACHCR);
-
-	return chcr & ~PDMACHCR_DE;
-}
-
-static bool audmapp_desc_completed(struct shdma_chan *schan,
-				   struct shdma_desc *sdesc)
-{
-	return true;
-}
-
-static struct shdma_desc *audmapp_embedded_desc(void *buf, int i)
-{
-	return &((struct audmapp_desc *)buf)[i].shdma_desc;
-}
-
-static const struct shdma_ops audmapp_shdma_ops = {
-	.halt_channel	= audmapp_halt,
-	.desc_setup	= audmapp_desc_setup,
-	.set_slave	= audmapp_set_slave,
-	.start_xfer	= audmapp_start_xfer,
-	.embedded_desc	= audmapp_embedded_desc,
-	.setup_xfer	= audmapp_setup_xfer,
-	.slave_addr	= audmapp_slave_addr,
-	.channel_busy	= audmapp_channel_busy,
-	.desc_completed	= audmapp_desc_completed,
-};
-
-static int audmapp_chan_probe(struct platform_device *pdev,
-			      struct audmapp_device *audev, int id)
-{
-	struct shdma_dev *sdev = &audev->shdma_dev;
-	struct audmapp_chan *auchan;
-	struct shdma_chan *schan;
-	struct device *dev = audev->dev;
-
-	auchan = devm_kzalloc(dev, sizeof(*auchan), GFP_KERNEL);
-	if (!auchan)
-		return -ENOMEM;
-
-	schan = &auchan->shdma_chan;
-	schan->max_xfer_len = AUDMAPP_LEN_MAX;
-
-	shdma_chan_probe(sdev, schan, id);
-
-	auchan->base = audev->chan_reg + 0x20 + (0x10 * id);
-	dev_dbg(dev, "%02d : %p / %p", id, auchan->base, audev->chan_reg);
-
-	return 0;
-}
-
-static void audmapp_chan_remove(struct audmapp_device *audev)
-{
-	struct shdma_chan *schan;
-	int i;
-
-	shdma_for_each_chan(schan, &audev->shdma_dev, i) {
-		BUG_ON(!schan);
-		shdma_chan_remove(schan);
-	}
-}
-
-static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
-					 struct of_dma *ofdma)
-{
-	dma_cap_mask_t mask;
-	struct dma_chan *chan;
-	u32 chcr = dma_spec->args[0];
-
-	if (dma_spec->args_count != 1)
-		return NULL;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	chan = dma_request_channel(mask, shdma_chan_filter, NULL);
-	if (chan)
-		to_shdma_chan(chan)->hw_req = chcr;
-
-	return chan;
-}
-
-static int audmapp_probe(struct platform_device *pdev)
-{
-	struct audmapp_pdata *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
-	struct audmapp_device *audev;
-	struct shdma_dev *sdev;
-	struct dma_device *dma_dev;
-	struct resource *res;
-	int err, i;
-
-	if (np)
-		of_dma_controller_register(np, audmapp_of_xlate, pdev);
-	else if (!pdata)
-		return -ENODEV;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	audev = devm_kzalloc(&pdev->dev, sizeof(*audev), GFP_KERNEL);
-	if (!audev)
-		return -ENOMEM;
-
-	audev->dev	= &pdev->dev;
-	audev->pdata	= pdata;
-	audev->chan_reg	= devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(audev->chan_reg))
-		return PTR_ERR(audev->chan_reg);
-
-	sdev		= &audev->shdma_dev;
-	sdev->ops	= &audmapp_shdma_ops;
-	sdev->desc_size	= sizeof(struct audmapp_desc);
-
-	dma_dev			= &sdev->dma_dev;
-	dma_dev->copy_align	= LOG2_DEFAULT_XFER_SIZE;
-	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
-
-	err = shdma_init(&pdev->dev, sdev, AUDMAPP_MAX_CHANNELS);
-	if (err < 0)
-		return err;
-
-	platform_set_drvdata(pdev, audev);
-
-	/* Create DMA Channel */
-	for (i = 0; i < AUDMAPP_MAX_CHANNELS; i++) {
-		err = audmapp_chan_probe(pdev, audev, i);
-		if (err)
-			goto chan_probe_err;
-	}
-
-	err = dma_async_device_register(dma_dev);
-	if (err < 0)
-		goto chan_probe_err;
-
-	return err;
-
-chan_probe_err:
-	audmapp_chan_remove(audev);
-	shdma_cleanup(sdev);
-
-	return err;
-}
-
-static int audmapp_remove(struct platform_device *pdev)
-{
-	struct audmapp_device *audev = platform_get_drvdata(pdev);
-	struct dma_device *dma_dev = &audev->shdma_dev.dma_dev;
-
-	dma_async_device_unregister(dma_dev);
-
-	audmapp_chan_remove(audev);
-	shdma_cleanup(&audev->shdma_dev);
-
-	return 0;
-}
-
-static const struct of_device_id audmapp_of_match[] = {
-	{ .compatible = "renesas,rcar-audmapp", },
-	{},
-};
-
-static struct platform_driver audmapp_driver = {
-	.probe		= audmapp_probe,
-	.remove		= audmapp_remove,
-	.driver		= {
-		.name	= "rcar-audmapp-engine",
-		.of_match_table = audmapp_of_match,
-	},
-};
-module_platform_driver(audmapp_driver);
-
-MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-MODULE_DESCRIPTION("Renesas R-Car Audio DMAC peri-peri driver");
-MODULE_LICENSE("GPL");
-- 
1.9.1

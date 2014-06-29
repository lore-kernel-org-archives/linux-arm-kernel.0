From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 29 Jun 2014 15:23:51 +0200
Subject: [PATCH 01/10] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <53AB515E.8080301@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
 <1402890635-12342-2-git-send-email-emilio@elopez.com.ar>
 <20140625184203.GE19569@lukather> <53AB515E.8080301@elopez.com.ar>
Message-ID: <20140629132351.GG3385@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 07:46:54PM -0300, Emilio L?pez wrote:
> Hi Maxime,
> 
> [I have not replied to every single comment; you can assume I fixed
> all the missing parentheses, spaces and comment style issues you
> pointed out.]
> 
> El 25/06/14 15:42, Maxime Ripard escribi?:
> >On Mon, Jun 16, 2014 at 12:50:26AM -0300, Emilio L?pez wrote:
> >>This patch adds support for the DMA engine present on Allwinner A10,
> >>A13, A10S and A20 SoCs. This engine has two kinds of channels: normal
> >>and dedicated. The main difference is in the mode of operation;
> >>while a single normal channel may be operating at any given time,
> >>dedicated channels may operate simultaneously provided there is no
> >>overlap of source or destination.
> >>
> >>Hardware documentation can be found on A10 User Manual (section 12), A13
> >>User Manual (section 14) and A20 User Manual (section 1.12)
> >>
> >>Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >>---
> (...)
> >>diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> >>index ba06d1d..a9ee0c9 100644
> >>--- a/drivers/dma/Kconfig
> >>+++ b/drivers/dma/Kconfig
> >>@@ -361,6 +361,16 @@ config FSL_EDMA
> >>  	  multiplexing capability for DMA request sources(slot).
> >>  	  This module can be found on Freescale Vybrid and LS-1 SoCs.
> >>
> >>+config SUN4I_DMA
> >>+	tristate "Allwinner A10/A10S/A13/A20 DMA support"
> >>+	depends on ARCH_SUNXI
> >
> >MACH_SUN4I || MACH_SUN5I || MACH_SUN7I ?
> >
> >That would probably be a good idea to add COMPILE_TEST to the list
> >too.
> 
> Yes, now that they're split I'll change it and add COMPILE_TEST.

If you're using writel_relaxed, then forget about
COMPILE_TEST. *_relaxed accessors are not standard one, and are not
defined on all the architectures.

> 
> >>+	select DMA_ENGINE
> >>+	select DMA_OF
> >>+	select DMA_VIRTUAL_CHANNELS
> >>+	help
> >>+	  Enable support for the DMA controller present in the sun4i,
> >>+	  sun5i and sun7i Allwinner ARM SoCs.
> >>+
> >>  config DMA_ENGINE
> >>  	bool
> >>
> >>diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> >>index 5150c82..13a7d5d 100644
> >>--- a/drivers/dma/Makefile
> >>+++ b/drivers/dma/Makefile
> >>@@ -46,3 +46,4 @@ obj-$(CONFIG_K3_DMA) += k3dma.o
> >>  obj-$(CONFIG_MOXART_DMA) += moxart-dma.o
> >>  obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
> >>  obj-$(CONFIG_QCOM_BAM_DMA) += qcom_bam_dma.o
> >>+obj-$(CONFIG_SUN4I_DMA) += sun4i-dma.o
> >>diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> >>new file mode 100644
> >>index 0000000..0b14b3f
> >>--- /dev/null
> >>+++ b/drivers/dma/sun4i-dma.c
> >>@@ -0,0 +1,1065 @@
> >>+/*
> >>+ * Copyright (C) 2014 Emilio L?pez
> >>+ * Emilio L?pez <emilio@elopez.com.ar>
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License as published by
> >>+ * the Free Software Foundation; either version 2 of the License, or
> >>+ * (at your option) any later version.
> >>+ */
> >>+
> >>+#include <linux/bitmap.h>
> >>+#include <linux/bitops.h>
> >>+#include <linux/clk.h>
> >>+#include <linux/dmaengine.h>
> >>+#include <linux/dmapool.h>
> >>+#include <linux/interrupt.h>
> >>+#include <linux/module.h>
> >>+#include <linux/of_dma.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/slab.h>
> >>+#include <linux/spinlock.h>
> >>+
> >>+#include "virt-dma.h"
> >>+
> >>+/** General DMA register values **/
> >>+
> >>+/* DMA source/destination burst length values */
> >>+#define DMA_BURST_LENGTH_1			0
> >>+#define DMA_BURST_LENGTH_4			1
> >>+#define DMA_BURST_LENGTH_8			2
> >
> >An enum maybe?
> >
> >You're not using this anywhere though.
> >
> >>+/* DMA source/destination data width */
> >>+#define DMA_DATA_WIDTH_8BIT			0
> >>+#define DMA_DATA_WIDTH_16BIT			1
> >>+#define DMA_DATA_WIDTH_32BIT			2
> >
> >And you're not using this either.
> 
> As discussed on IRC, I'll drop the unused #defines
> 
> (...)
> 
> >>+
> >>+/* Dedicated DMA parameter register layout */
> >>+#define DDMA_PARA_DEST_DATA_BLK_SIZE(n)		(n-1 << 24)
> >>+#define DDMA_PARA_DEST_WAIT_CYCLES(n)		(n-1 << 16)
> >>+#define DDMA_PARA_SRC_DATA_BLK_SIZE(n)		(n-1 << 8)
> >>+#define DDMA_PARA_SRC_WAIT_CYCLES(n)		(n-1 << 0)
> >
> >Since the minus operations has precedence over the shift, I wonder how
> >this can work.
> >
> >(plus, parenthesis around n, and spaces around the minus)
> 
> It works because it's not used :)
> 
> (...)
> 
> >
> >>+
> >>+/** DMA Driver **/
> >>+
> >>+/* Normal DMA has 8 channels, and Dedicated DMA has another 8, so that's
> >>+ * 16 channels. As for endpoints, there's 29 and 21 respectively. Given
> >>+ * that the Normal DMA endpoints can be used as tx/rx, we need 79 vchans
> >>+ * in total
> >>+ */
> >>+#define NDMA_NR_MAX_CHANNELS	8
> >>+#define DDMA_NR_MAX_CHANNELS	8
> >>+#define DMA_NR_MAX_CHANNELS	(NDMA_NR_MAX_CHANNELS + DDMA_NR_MAX_CHANNELS)
> >>+#define NDMA_NR_MAX_VCHANS	(29*2)
> >
> >I'm counting 29 + 28
> 
> I just counted them again, there's 29 on NDMA, and you may want to
> read from or write to them, so 29*2. I could drop one to compensate
> mem2mem being counted twice though, if we want to be really exact
> with this.

Ok.

> 
> >>+#define DDMA_NR_MAX_VCHANS	21
> >>+#define DMA_NR_MAX_VCHANS	(NDMA_NR_MAX_VCHANS + DDMA_NR_MAX_VCHANS)
> >>+
> >>+struct sun4i_dma_pchan {
> >>+	/* Register base of channel */
> >>+	void __iomem			*base;
> >>+	/* vchan currently being serviced */
> >>+	struct sun4i_dma_vchan		*vchan;
> >>+	/* Is this a dedicated pchan? */
> >>+	int				is_dedicated;
> >>+};
> >>+
> >>+struct sun4i_dma_vchan {
> >>+	struct virt_dma_chan		vc;
> >>+	struct dma_slave_config		cfg;
> >>+	struct sun4i_dma_pchan		*pchan;
> >>+	struct sun4i_dma_promise	*processing;
> >>+	struct sun4i_dma_contract	*contract;
> >>+	u8				endpoint;
> >>+	int				is_dedicated;
> >>+};
> >>+
> >>+struct sun4i_dma_promise {
> >>+	u32				cfg;
> >>+	u32				para;
> >>+	dma_addr_t			src;
> >>+	dma_addr_t			dst;
> >>+	size_t				len;
> >>+	struct list_head		list;
> >>+};
> >>+
> >>+/* A contract is a set of promises */
> >>+struct sun4i_dma_contract {
> >>+	struct virt_dma_desc		vd;
> >>+	struct list_head		demands;
> >>+	struct list_head		completed_demands;
> >>+};
> >>+
> >>+struct sun4i_dma_dev {
> >>+	DECLARE_BITMAP(pchans_used, DDMA_NR_MAX_CHANNELS);
> >>+	struct tasklet_struct		tasklet;
> >>+	struct dma_device		slave;
> >>+	struct sun4i_dma_pchan		*pchans;
> >>+	struct sun4i_dma_vchan		*vchans;
> >>+	void __iomem			*base;
> >>+	struct clk			*clk;
> >>+	int				irq;
> >>+	spinlock_t			lock;
> >>+};
> >>+
> >>+static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> >>+{
> >>+	return container_of(dev, struct sun4i_dma_dev, slave);
> >>+}
> >>+
> >>+static struct sun4i_dma_vchan *to_sun4i_dma_vchan(struct dma_chan *chan)
> >>+{
> >>+	return container_of(chan, struct sun4i_dma_vchan, vc.chan);
> >>+}
> >>+
> >>+static struct sun4i_dma_contract *to_sun4i_dma_contract(struct virt_dma_desc *vd)
> >>+{
> >>+	return container_of(vd, struct sun4i_dma_contract, vd);
> >>+}
> >>+
> >>+static struct device *chan2dev(struct dma_chan *chan)
> >>+{
> >>+	return &chan->dev->device;
> >>+}
> >>+
> >>+static int convert_burst(u32 maxburst)
> >>+{
> >>+	if (maxburst > 8)
> >>+		maxburst = 8;
> >
> >returning an error would be better here.
> 
> Ok, I'll do that.
> 
> >>+
> >>+	/* 1 -> 0, 4 -> 1, 8 -> 2 */
> >
> >4 seems to be an invalid value on the A20
> 
> They define it on the SDK DMA driver though
> 
> https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/arch/arm/mach-sun7i/include/mach/dma.h#L38
> 
> And actually use it on the sound codec driver, among other parts
> 
> https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/sound/soc/sunxi/sunxi-codec.c#L1143
> 
> So I would prefer to keep it, unless we hear it's actually not
> supported from Allwinner themselves.

Hmmm, weird. Ok.

> 
> >
> >>+	return (maxburst >> 2);
> >>+}
> >>+
> >>+static int convert_buswidth(enum dma_slave_buswidth addr_width)
> >>+{
> >>+	if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
> >>+		return -EINVAL;
> >
> >especially if you're returning one here.
> >
> >>+
> >>+	/* 8 -> 0, 16 -> 1, 32 -> 2 */
> >
> >16 seems to be an invalid value on the A20
> 
> Ditto
> 
> >
> >>+	return (addr_width >> 4);
> >>+}
> >>+
> (...)
> >>+static void configure_pchan(struct sun4i_dma_pchan *pchan,
> >>+			    struct sun4i_dma_promise *d)
> >>+{
> >>+	if (pchan->is_dedicated) {
> >>+		/* Configure addresses and misc parameters */
> >>+		writel_relaxed(d->src, pchan->base + DDMA_SRC_ADDR_REG);
> >>+		writel_relaxed(d->dst, pchan->base + DDMA_DEST_ADDR_REG);
> >>+		writel_relaxed(d->len, pchan->base + DDMA_BYTE_COUNT_REG);
> >>+		writel_relaxed(d->para, pchan->base + DDMA_PARA_REG);
> >>+
> >>+		/* We use a writel here because CFG_LOADING may be set,
> >>+		 * and it requires that the rest of the configuration
> >>+		 * takes place before the engine is started */
> >
> >You should be ok here.
> >
> >See http://permalink.gmane.org/gmane.linux.ports.arm.kernel/117640
> >
> >>+		writel(d->cfg, pchan->base + DDMA_CFG_REG);
> 
> Ok, I've switched this to writel_relaxed as well after the
> explanation on IRC.
> 
> >>+	} else {
> >>+		/* Configure addresses and misc parameters */
> >>+		writel_relaxed(d->src, pchan->base + NDMA_SRC_ADDR_REG);
> >>+		writel_relaxed(d->dst, pchan->base + NDMA_DEST_ADDR_REG);
> >>+		writel_relaxed(d->len, pchan->base + NDMA_BYTE_COUNT_REG);
> (...)
> >>+static struct dma_async_tx_descriptor *
> >>+sun4i_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
> >>+			  dma_addr_t src, size_t len, unsigned long flags)
> >>+{
> >>+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
> >>+	struct dma_slave_config *sconfig = &vchan->cfg;
> >>+	struct sun4i_dma_promise *promise;
> >>+	struct sun4i_dma_contract *contract;
> >>+
> >>+	contract = generate_dma_contract();
> >>+	if (!contract)
> >>+		return NULL;
> >>+
> >>+	if (vchan->is_dedicated)
> >>+		promise = generate_ddma_promise(chan, src, dest, len, sconfig);
> >>+	else
> >>+		promise = generate_ndma_promise(chan, src, dest, len, sconfig);
> >>+
> >>+	if (!promise) {
> >>+		kfree(contract);
> >>+		return NULL;
> >>+	}
> >>+
> >>+	/* Configure memcpy mode */
> >>+	if (vchan->is_dedicated) {
> >>+		promise->cfg |= DDMA_CFG_SRC_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
> >>+				DDMA_CFG_SRC_NON_SECURE |
> >>+				DDMA_CFG_DEST_DRQ_TYPE(DDMA_DRQ_TYPE_SDRAM) |
> >>+				DDMA_CFG_DEST_NON_SECURE;
> >>+	} else {
> >>+		promise->cfg |= NDMA_CFG_SRC_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
> >>+				NDMA_CFG_SRC_NON_SECURE |
> >>+				NDMA_CFG_DEST_DRQ_TYPE(NDMA_DRQ_TYPE_SDRAM) |
> >>+				NDMA_CFG_DEST_NON_SECURE;
> >
> >Hmm, are you sure about that non-secure? Depending on the mode the
> >kernel execute in, wouldn't that change?
> 
> dmatest seems to be happy either way on my A20. It's not clear to me
> from the documentation what this flag does, so I suppose I can just
> drop it for now and we can worry about it in the future if it turns
> out we need it for something.

Even when you're starting the kernel itself in secure and !secure?

> 
> >>+static enum dma_status sun4i_dma_tx_status(struct dma_chan *chan,
> >>+					   dma_cookie_t cookie,
> >>+					   struct dma_tx_state *state)
> >>+{
> >>+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
> >>+	struct sun4i_dma_pchan *pchan = vchan->pchan;
> >>+	struct sun4i_dma_contract *contract;
> >>+	struct sun4i_dma_promise *promise = NULL;
> >>+	struct virt_dma_desc *vd;
> >>+	unsigned long flags;
> >>+	enum dma_status ret;
> >>+	size_t bytes = 0;
> >>+
> >>+	ret = dma_cookie_status(chan, cookie, state);
> >>+	if (ret == DMA_COMPLETE)
> >>+		return ret;
> >>+
> >>+	spin_lock_irqsave(&vchan->vc.lock, flags);
> >>+	vd = vchan_find_desc(&vchan->vc, cookie);
> >>+	if (!vd) /* TODO */
> >
> >TODO?
> 
> I don't actually recall what was left to do here, I should've
> written a better comment :|
> 
> (...)
> >>+static int sun4i_dma_remove(struct platform_device *pdev)
> >>+{
> >>+	struct sun4i_dma_dev *priv = platform_get_drvdata(pdev);
> >>+
> >>+	/* Disable IRQ so the tasklet doesn't schedule any longer, then
> >>+	 * kill it */
> >>+	disable_irq(priv->irq);
> >>+	tasklet_kill(&priv->tasklet);
> >
> >You might still have your tasklet pending to be scheduled. This is not
> >the proper way to bail out from a tasklet.
> >
> >See https://lwn.net/Articles/588457/
> 
> As we talked on IRC, the tasklet does not reschedule itself, and
> after disabling the interrupt, there should be no way for it to get
> rescheduled, so I think calling task_kill should be ok.
> 
> >>+	of_dma_controller_free(pdev->dev.of_node);
> >>+	dma_async_device_unregister(&priv->slave);
> >>+
> >>+	clk_disable_unprepare(priv->clk);
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static struct of_device_id sun4i_dma_match[] = {
> >>+	{ .compatible = "allwinner,sun4i-a10-dma" }
> >
> >The two IPs seem to differ from A10 to A20. Maybe it would be great to
> >introduce several compatibles here?
> 
> I'm ok with introducing several compatibles, but as far as I can
> tell the IP is the same - I have not needed to add any conditionals
> depending on the SoC or anything.

Ok.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140629/881ed126/attachment-0001.sig>

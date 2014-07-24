From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Jul 2014 10:53:09 +0200
Subject: [PATCH v2 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <53C843DC.8090808@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-2-git-send-email-emilio@elopez.com.ar>
 <20140717205639.GH20328@lukather> <53C843DC.8090808@elopez.com.ar>
Message-ID: <20140724085309.GR20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 17, 2014 at 06:45:00PM -0300, Emilio L?pez wrote:
> >>+	depends on (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || (COMPILE_TEST && OF && ARM))
> >
> >This pretty much defeats the purpose of COMPILE_TEST
> 
> QCOM_BAM_DMA does it that way; it's better to get some coverage than
> none I guess?

You'll get that kind of coverage with multi_v7 already, so that looks
quite redundant.

> >>+	help
> >>+	  Enable support for the DMA controller present in the sun4i,
> >>+	  sun5i and sun7i Allwinner ARM SoCs.
> >>+
> (...)
> >>+
> >>+/** Normal DMA register values **/
> >>+
> >>+/* Normal DMA source/destination data request type values */
> >>+#define NDMA_DRQ_TYPE_SDRAM			0x16
> >>+#define NDMA_DRQ_TYPE_LIMIT			(0x1F + 1)
> >
> >Hmmm, I'm unsure what this is about... What is it supposed to do, and
> >how is it different from BIT(5) ?
> 
> if (val < NDMA_DRQ_TYPE_LIMIT)
> 	/* valid value */
> else
> 	/* invalid value */
> 
> 0x1F is the last valid value

Ok.

> >>+
> >>+static void set_pchan_interrupt(struct sun4i_dma_dev *priv,
> >>+				struct sun4i_dma_pchan *pchan,
> >>+				int half, int end)
> >>+{
> >>+	u32 reg = readl_relaxed(priv->base + DMA_IRQ_ENABLE_REG);
> >>+	int pchan_number = pchan - priv->pchans;
> >>+
> >>+	if (half)
> >>+		reg |= BIT(pchan_number * 2);
> >>+	else
> >>+		reg &= ~BIT(pchan_number * 2);
> >>+
> >>+	if (end)
> >>+		reg |= BIT(pchan_number * 2 + 1);
> >>+	else
> >>+		reg &= ~BIT(pchan_number * 2 + 1);
> >>+
> >>+	writel_relaxed(reg, priv->base + DMA_IRQ_ENABLE_REG);
> >
> >I don't see any interrupts here.
> 
> Hm?

I'm not sure, but I think I meant spinlocks, it doesn't make much
sense otherwise.

> >>+	for_each_sg(sgl, sg, sg_len, i) {
> >>+		/* Figure out addresses */
> >>+		if (dir == DMA_MEM_TO_DEV) {
> >>+			srcaddr = sg_dma_address(sg);
> >>+			dstaddr = sconfig->dst_addr;
> >>+		} else {
> >>+			srcaddr = sconfig->src_addr;
> >>+			dstaddr = sg_dma_address(sg);
> >>+		}
> >>+
> >>+		/* TODO: should this be configurable? */
> >>+		para = DDMA_MAGIC_SPI_PARAMETERS;
> >
> >What is it? Is it supposed to change from one client device to
> >another?
> 
> These are the magic DMA engine timings that keep SPI going. I
> haven't seen any interface on DMAEngine to configure timings, and so
> far they seem to work for everything we support, so I've kept them
> here. I don't know if other devices need different timings because,
> as usual, we only have the "para" bitfield meanings, but no comment
> on what the values should be when doing a certain operation :|

If it works for everything you tested so far, I guess you can leave it
that way, only adding what you just replied to the TODO.

> >>+static enum dma_status sun4i_dma_tx_status(struct dma_chan *chan,
> >>+					   dma_cookie_t cookie,
> >>+					   struct dma_tx_state *state)
> >>+{
> >>+	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(chan);
> >>+	struct sun4i_dma_pchan *pchan = vchan->pchan;
> >>+	struct sun4i_dma_contract *contract;
> >>+	struct sun4i_dma_promise *promise;
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
> >TODO what?
> >
> 
> /* TODO: remove the TODO */

:)

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/1d013a68/attachment.sig>

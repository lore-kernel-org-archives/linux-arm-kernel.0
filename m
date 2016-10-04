From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Oct 2016 18:55:54 +0200
Subject: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
In-Reply-To: <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
Message-ID: <20161004165553.GS5228@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 12:40:11PM +0200, Jean-Francois Moine wrote:
> On Tue,  4 Oct 2016 11:46:14 +0200
> Myl?ne Josserand <mylene.josserand@free-electrons.com> wrote:
> 
> > Add the case of a burst of 4 which is handled by the SoC.
> > 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> > ---
> >  drivers/dma/sun6i-dma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 8346199..0485204 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
> >  	switch (maxburst) {
> >  	case 1:
> >  		return 0;
> > +	case 4:
> > +		return 1;
> >  	case 8:
> >  		return 2;
> >  	default:
> > -- 
> > 2.9.3
> 
> This patch has already been rejected by Maxime in the threads
> 	http://www.spinics.net/lists/dmaengine/msg08610.html
> and
> 	http://www.spinics.net/lists/dmaengine/msg08719.html
> 
> I hope you will find the way he wants for this maxburst to be added.

I was talking about something along these lines (not tested):

-------8<---------
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 83461994e418..573ac4608293 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
 	default:
@@ -1110,11 +1112,19 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	sdc->slave.dst_bursts			= BIT(1) | BIT(8);
+	sdc->slave.src_bursts			= BIT(1) | BIT(8);
 	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
 	sdc->slave.dev = &pdev->dev;
 
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun8i-h3-dma")) {
+		sdc->slave.dst_bursts |= BIT(4);
+		sdc->slave.src_bursts |= BIT(4);
+	}
+
 	sdc->pchans = devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels,
 				   sizeof(struct sun6i_pchan), GFP_KERNEL);
 	if (!sdc->pchans)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index cc535a478bae..f7bbec24bb58 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -673,6 +673,8 @@ struct dma_filter {
  * 	each type of direction, the dma controller should fill (1 <<
  * 	<TYPE>) and same should be checked by controller as well
  * @max_burst: max burst capability per-transfer
+ * @dst_bursts: bitfield of the available burst sizes for the destination
+ * @src_bursts: bitfield of the available burst sizes for the source
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -800,6 +802,14 @@ struct dma_device {
 static inline int dmaengine_slave_config(struct dma_chan *chan,
 					  struct dma_slave_config *config)
 {
+	if (config->src_maxburst && config->device->src_bursts &&
+	    !(BIT(config->src_maxburst) & config->device->src_bursts))
+		return -EINVAL;
+
+	if (config->dst_maxburst && config->device->dst_bursts &&
+	    !(BIT(config->dst_maxburst) & config->device->dst_bursts))
+		return -EINVAL;
+
 	if (chan->device->device_config)
 		return chan->device->device_config(chan, config);
-------8<------------ 

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161004/925068da/attachment.sig>

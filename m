From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 15 Nov 2013 07:43:04 +0000
Subject: [PATCH v6 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20131114104620.GB16396@e106331-lin.cambridge.arm.com>
References: <1379498279-16096-1-git-send-email-b35083@freescale.com>
 <20131114104620.GB16396@e106331-lin.cambridge.arm.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E852409CE@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, November 14, 2013 6:46 PM
> To: Lu Jingchang-B35083
> Cc: vinod.koul at intel.com; devicetree at vger.kernel.org; Wang Huan-B18965;
> linux-kernel at vger.kernel.org; shawn.guo at linaro.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v6 3/3] dma: Add Freescale eDMA engine driver support
> 
> On Wed, Sep 18, 2013 at 10:57:59AM +0100, Jingchang Lu wrote:
> > Add Freescale enhanced direct memory(eDMA) controller support.
> > The eDMA controller deploys DMAMUXs routing DMA request sources(slot)
> > to eDMA channels.
> > This module can be found on Vybrid and LS-1 SoCs.
> >
> > Signed-off-by: Alison Wang <b18965@freescale.com>
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
[...] 
> > +* DMAMUX
> > +Required properties:
> 
> No compatible?
> 
> Where are DMAMUX nodes expected to live?
> 
> How to they relate to the eDMA controller in HW? Are they a
> subcomponent, or a logically separate unit that happens to be connected?
[Lu Jingchang-b35083] 
DMAMUX is a multiplexer between dma controller channels and peripheral deivces,
each DMAMUX provides 16 independently selectable DMA channel routers, and each 
channel router can be assigned to one of the possible peripheral DMA slots.
So it's not a standalone device, it's just required by the DMA controller to
connect the channels and slaves, So it's got by DMA controller's "fsl,dma-mux" property.
Thanks!
> 
> > +- reg : Should contain DMAMUX registers location and length
> > +- fsl,dmamux-id : DMAMUX ID. DMAMUX IDs are unique in each eDMA
> controller.
> > +  inside one eDMA controller, specific request source can only be
> routed by
> > +  one of its DMAMUXs.
> > +  However Specific request source may be routed to different eDMA
> controller,
> > +  thus all the DMAMUXs sharing a the same request sources have the
> same ID.
> > +- clocks : Phandle of the clock used by the DMAMUX
> > +- clock-names : The clock names
> 
> _which_ clock names do you expect? From the looks of the example, you
> expect "dmamux".
> 
> From the view of the DMAMUX, what is its clock input called? "dmamux"
> doesn't look like what I'd expect for a clock name, but if the
> documentation for the eDMA doesn't provide a name for it, "dmamux" is
> fine.
> 
> If you're not using clock-names, it's useless. You _must_ define the set
> of names you expect or it's unusable. If you do define a set of names,
> then you should request clocks by name in the driver.
> 
[Lu Jingchang-b35083] [Lu Jingchang-b35083] 
The clock here is from the platform bus clock, I will remove this property for
compatible between SoCs. Thanks!
> > +

[...] 

> > +* DMA clients
> > +DMA client drivers that uses the DMA function must use the format
> described
> > +in the dma.txt file, using a three-cell specifier for each channel: a
> phandle
> > +plus two integer cells as described above.
> 
> Nit: the phandle isn't part of the specifier. The cells after the
> phandle are the specifier associated with the phandle.
> 
[Lu Jingchang-b35083] 
I will fix this, thanks!
> [...]
> 
> > +static bool fsl_edma_filter_fn(struct dma_chan *chan, void *mux_id)
> > +{
> > +       struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > +
> > +       if (fsl_chan->edmamux->mux_id != (u32)mux_id)
> > +               return false;
> > +
> > +       return true;
> 
> Why not:
> 
> return fsl_chan->edmamux->mux_id == (u32)mux_id;
> 
[Lu Jingchang-b35083] 
I will replace it, thanks!
> [...]
> 
> > +static int
> > +fsl_init_edmamux(struct platform_device *pdev, struct fsl_edma_engine
> *fsl_edma)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct fsl_edma_dmamux *fsl_edmamux;
> > +       struct device_node *phandle;
> 
> That's confusing, a node is not a phandle. Why not mux_np?
[Lu Jingchang-b35083] 
Ok, I will eliminate the confusing, thanks!
> 
> > +       const void *prop;
> > +       struct resource res;
> > +       int len, n_muxes, chans_per_mux, ch_off;
> > +       int i, j;
> > +       int ret;
> > +
> > +       prop = of_get_property(np, "fsl,dma-mux", &len);
> > +       if (!prop) {
> > +               dev_err(&pdev->dev, "Can't get DMAMUX.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       n_muxes = len / sizeof(u32);
> 
> It would be nicer if we had a variant of of_count_phandle_with_args that
> cound handle a fixed count of 0 args for this sort of thing.
[Lu Jingchang-b35083] 
Yes, I will do it, thanks!
> 
> > +       chans_per_mux = fsl_edma->n_chans / n_muxes;
> > +       fsl_edmamux = devm_kzalloc(&pdev->dev,
> > +                       sizeof(struct fsl_edma_dmamux) * n_muxes,
> GFP_KERNEL);
> > +       if (!fsl_edmamux)
> > +               return -ENOMEM;
> > +
> > +       fsl_edma->n_muxes = 0;
> > +       fsl_edma->edmamux = fsl_edmamux;
> > +       for (i = 0; i < n_muxes; i++) {
> > +               phandle = of_parse_phandle(np, "fsl,dma-mux", i);
> > +               ret = of_address_to_resource(phandle, 0, &res);
> > +               if (ret)
> > +                       return ret;
> > +               fsl_edmamux->membase = devm_ioremap_resource(&pdev->dev,
> &res);
> > +               if (IS_ERR(fsl_edmamux->membase))
> > +                       return PTR_ERR(fsl_edmamux->membase);
> > +
> > +               fsl_edmamux->clk = of_clk_get(phandle, 0);
> > +               if (IS_ERR(fsl_edmamux->clk)) {
> > +                       dev_err(&pdev->dev, "Missing DMAMUX clock.\n");
> > +                       return PTR_ERR(fsl_edmamux->clk);
> > +               }
> 
> Please acquire the clock by name:
[Lu Jingchang-b35083] 
I will remove the node name property for reuse the driver between SoCs,
for they may have different clock names. Thanks!
> 
> fsl_edmamux->clk = of_clk_get_byname(phandle, "dmamux");
> 
> > +
> > +               ret = clk_prepare_enable(fsl_edmamux->clk);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "DMAMUX clk enable
> failed.\n");
> > +                       return ret;
> > +               }
> > +
> > +               ret = of_property_read_u32_index(phandle, "fsl,dmamux-
> id", 0,
> > +                               &fsl_edmamux->mux_id);
> 
> Why not just of_property_read_u32?

[...]
> 
> > +static int fsl_edma_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct fsl_edma_engine *fsl_edma;
> > +       struct fsl_edma_chan *fsl_chan;
> > +       struct resource *res;
> > +       int len, chans;
> > +       int ret, i;
> > +
> > +       ret = of_property_read_u32_index(np, "dma-channels", 0, &chans);
> 
> Use of_property_read_u32.
[Lu Jingchang-b35083] 
Thanks, I will do this.


Best Regards,
Jingchang

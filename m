From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 20 Apr 2016 14:55:27 +0000
Subject: [PATCH v2 2/2] dmaengine: vdma: Add clock support
In-Reply-To: <20160420143622.GP7128@xsjsorenbubuntu>
References: <1461152599-28858-1-git-send-email-appanad@xilinx.com>
 <1461152599-28858-2-git-send-email-appanad@xilinx.com>
 <20160420143622.GP7128@xsjsorenbubuntu>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57930F@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Wednesday, April 20, 2016 8:06 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; vinod.koul at intel.com; dan.j.williams at intel.com;
> Appana Durga Kedareswara Rao <appanad@xilinx.com>;
> moritz.fischer at ettus.com; laurent.pinchart at ideasonboard.com;
> luis at debethencourt.com; Anirudha Sarangi <anirudh@xilinx.com>; Punnaiah
> Choudary Kalluri <punnaia@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> dmaengine at vger.kernel.org
> Subject: Re: [PATCH v2 2/2] dmaengine: vdma: Add clock support
> 
> On Wed, 2016-04-20 at 17:13:19 +0530, Kedareswara rao Appana wrote:
> > Added basic clock support. The clocks are requested at probe and
> > released at remove.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v2:
> > --> None.
> >
> >  drivers/dma/xilinx/xilinx_vdma.c | 56
> > ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> > b/drivers/dma/xilinx/xilinx_vdma.c
> > index 70caea6..d526029 100644
> > --- a/drivers/dma/xilinx/xilinx_vdma.c
> > +++ b/drivers/dma/xilinx/xilinx_vdma.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/slab.h>
> > +#include <linux/clk.h>
> >
> >  #include "../dmaengine.h"
> >
> > @@ -352,6 +353,8 @@ struct xilinx_dma_chan {
> >   * @flush_on_fsync: Flush on frame sync
> >   * @ext_addr: Indicates 64 bit addressing is supported by dma device
> >   * @dmatype: DMA ip type
> > + * @clks:	pointer to array of clocks
> > + * @numclks:	number of clocks available
> >   */
> >  struct xilinx_dma_device {
> >  	void __iomem *regs;
> > @@ -362,6 +365,8 @@ struct xilinx_dma_device {
> >  	u32 flush_on_fsync;
> >  	bool ext_addr;
> >  	enum xdma_ip_type dmatype;
> > +	struct clk **clks;
> > +	int numclks;
> >  };
> >
> >  /* Macros */
> > @@ -1731,6 +1736,26 @@ int xilinx_vdma_channel_set_config(struct
> > dma_chan *dchan,  }  EXPORT_SYMBOL(xilinx_vdma_channel_set_config);
> >
> > +static int xdma_clk_init(struct xilinx_dma_device *xdev, bool enable)
> > +{
> > +	int i = 0, ret;
> > +
> > +	for (i = 0; i < xdev->numclks; i++) {
> > +		if (enable) {
> > +			ret = clk_prepare_enable(xdev->clks[i]);
> > +			if (ret) {
> > +				dev_err(xdev->dev,
> > +					"failed to enable the axidma clock\n");
> > +				return ret;
> > +			}
> > +		} else {
> > +			clk_disable_unprepare(xdev->clks[i]);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* -----------------------------------------------------------------------------
> >   * Probe and remove
> >   */
> > @@ -1919,6 +1944,7 @@ static int xilinx_dma_probe(struct platform_device
> *pdev)
> >  	struct resource *io;
> >  	u32 num_frames, addr_width;
> >  	int i, err;
> > +	const char *str;
> >
> >  	/* Allocate and initialize the DMA engine structure */
> >  	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL); @@
> > -1965,6 +1991,32 @@ static int xilinx_dma_probe(struct platform_device
> *pdev)
> >  	/* Set the dma mask bits */
> >  	dma_set_mask(xdev->dev, DMA_BIT_MASK(addr_width));
> >
> > +	xdev->numclks = of_property_count_strings(pdev->dev.of_node,
> > +						  "clock-names");
> > +	if (xdev->numclks > 0) {
> > +		xdev->clks = devm_kmalloc_array(&pdev->dev, xdev->numclks,
> > +						sizeof(struct clk *),
> > +						GFP_KERNEL);
> > +		if (!xdev->clks)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < xdev->numclks; i++) {
> > +			of_property_read_string_index(pdev->dev.of_node,
> > +						      "clock-names", i, &str);
> > +			xdev->clks[i] = devm_clk_get(xdev->dev, str);
> > +			if (IS_ERR(xdev->clks[i])) {
> > +				if (PTR_ERR(xdev->clks[i]) == -ENOENT)
> > +					xdev->clks[i] = NULL;
> > +				else
> > +					return PTR_ERR(xdev->clks[i]);
> > +			}
> > +		}
> > +
> > +		err = xdma_clk_init(xdev, true);
> > +		if (err)
> > +			return err;
> > +	}
> 
> I guess this works, but the relation to the binding is a little loose, IMHO. Instead
> of using the clock names from the binding this is just using whatever is provided
> in DT and enabling it. Also, all the clocks here are handled as optional feature,
> while binding - and I guess reality too - have them as mandatory.
> It would be nicer if the driver specifically asks for the clocks it needs and return
> an error if a mandatory clock is missing.

Here DMA channels are configurable I mean if user select only mm2s channel then we will have
Only 3 clocks. If user selects both mm2s and s2mm channels we will have 5 clocks.
That?s why reading the number of clocks from the clock-names property.

And also the AXI DMA/CDMA Ip support also getting added to this driver for those IP's also the clocks are configurable
For AXI DMA it is either 3 or 4 clocks and for AXI CDMA it is 2 clocks.

That's why I thought it is the proper solution.

If you have any better idea please let me know will try in that way...

Regards,
Kedar.
> 
> 	S?ren

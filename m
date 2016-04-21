From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 21 Apr 2016 10:02:15 -0700
Subject: [PATCH v3 3/3] dmaengine: vdma: Add clock support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A5799D9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1461235118-800-1-git-send-email-appanad@xilinx.com>
 <1461235118-800-4-git-send-email-appanad@xilinx.com>
 <20160421162153.GZ7128@xsjsorenbubuntu>
 <C246CAC1457055469EF09E3A7AC4E11A4A5799D9@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160421170215.GB7128@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-04-21 at 09:32:44 -0700, Appana Durga Kedareswara Rao wrote:
> Hi Soren,
> 
> > -----Original Message-----
> > From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> > Sent: Thursday, April 21, 2016 9:52 PM
> > To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> > Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> > ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> > <michals@xilinx.com>; vinod.koul at intel.com; dan.j.williams at intel.com;
> > Appana Durga Kedareswara Rao <appanad@xilinx.com>;
> > moritz.fischer at ettus.com; laurent.pinchart at ideasonboard.com;
> > luis at debethencourt.com; Anirudha Sarangi <anirudh@xilinx.com>; Punnaiah
> > Choudary Kalluri <punnaia@xilinx.com>; Shubhrajyoti Datta
> > <shubhraj@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > dmaengine at vger.kernel.org
> > Subject: Re: [PATCH v3 3/3] dmaengine: vdma: Add clock support
> > 
> > On Thu, 2016-04-21 at 16:08:38 +0530, Kedareswara rao Appana wrote:
[...]
> > > @@ -1757,6 +1767,200 @@ static void xilinx_dma_chan_remove(struct
> > xilinx_dma_chan *chan)
> > >  	list_del(&chan->common.device_node);
> > >  }
> > >
> > > +static int axidma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
> > > +			    struct clk **tx_clk, struct clk **rx_clk,
> > > +			    struct clk **sg_clk, struct clk **tmp_clk) {
> > > +	int err;
> > > +
> > > +	*tmp_clk = NULL;
> > > +
> > > +	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
> > > +	if (IS_ERR(*axi_clk)) {
> > > +		err = PTR_ERR(*axi_clk);
> > > +		dev_err(&pdev->dev, "failed to get axi_aclk (%u)\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	*tx_clk = devm_clk_get(&pdev->dev, "m_axi_mm2s_aclk");
> > > +	if (IS_ERR(*tx_clk))
> > > +		*tx_clk = NULL;
> > > +
> > > +	*rx_clk = devm_clk_get(&pdev->dev, "m_axi_s2mm_aclk");
> > > +	if (IS_ERR(*rx_clk))
> > > +		*rx_clk = NULL;
> > > +
> > > +	*sg_clk = devm_clk_get(&pdev->dev, "m_axi_sg_aclk");
> > > +	if (IS_ERR(*sg_clk))
> > > +		*sg_clk = NULL;
> > > +
> > > +
> > > +	err = clk_prepare_enable(*axi_clk);
> > 
> > Should this be called if you know that the pointer might be NULL?
> 
> It is a mandatory clock and if this clk is not there in DT I am already returning error...
> I didn't get your question could you please elaborate???

But for all the optional clocks. They could all be NULL and you're calling
clk_prepare_enable with a NULL pointer. That function is nice enough to
do a NULL check for you, but I wonder whether these calls should happen at
all when you already know that the pointer is not a valid clock.

	S?ren

From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 13 Jun 2016 11:20:12 +0530
Subject: [PATCH v10 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A5B4FA9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1464765839-29018-1-git-send-email-appanad@xilinx.com>
 <1464765839-29018-2-git-send-email-appanad@xilinx.com>
 <20160607070841.GJ16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B4FA9@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160613055012.GC16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 07:40:52AM +0000, Appana Durga Kedareswara Rao wrote:
> > > +static void zynqmp_dma_desc_config_eod(struct zynqmp_dma_chan *chan,
> > > +void *desc)
> > 
> > eod? 80 line?

What's eod?

> > > +int zynqmp_dma_channel_set_config(struct dma_chan *dchan,
> > > +				  struct zynqmp_dma_config *cfg)
> > > +{
> > > +	struct zynqmp_dma_chan *chan = to_chan(dchan);
> > > +
> > > +	chan->config.ovrfetch = cfg->ovrfetch;
> > > +	chan->config.has_sg = cfg->has_sg;
> > 
> > is this HW capability? if so why would anyone not like to use it!
> 
> Yes it is HW capability. It can be either in simple mode or SG mode
> Earlier In the driver this configuration is read from the device-tree 
> But as per lars and your suggestion moved it as runtime config parameters.

If sg mode is available why would anyone _not_ want it?

I do not think there is point to have this

> 
> > 
> > > +	chan->config.ratectrl = cfg->ratectrl;
> > > +	chan->config.src_issue = cfg->src_issue;
> > > +	chan->config.src_burst_len = cfg->src_burst_len;
> > > +	chan->config.dst_burst_len = cfg->dst_burst_len;
> > 
> > can you describe these parameters?
> ratectl:
> Rate control can be independently enabled per channel. When rate control is enabled, the
> DMA channel uses the rate control count to schedule successive data read transactions.

And how is this used by client?

> src_issue:
> Tells outstanding transaction on SRC.

This should be read only then, right?

> Burst_len: 
> Configures the burst length of the src and dst transfers...

Hmmm, but you are on memcpy, so that should be programmed for throughput?

> > 
> > How would a client know how to configure them?
> 
> With the default values of the config parameters driver will work.

But how will client know what is default!

> If user has specific requirement to change these parameters they can pass
> It to the driver using set_config API and all these parameters are
> Documented in the include/linux/dma/xilinx_dma.h file...

Can you give me an example where user would like to do that

-- 
~Vinod

From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 15 Jun 2016 22:20:04 +0530
Subject: [PATCH v10 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A5B6441@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1464765839-29018-1-git-send-email-appanad@xilinx.com>
 <1464765839-29018-2-git-send-email-appanad@xilinx.com>
 <20160607070841.GJ16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B4FA9@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160613055012.GC16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B6441@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160615165004.GC16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 08:18:09AM +0000, Appana Durga Kedareswara Rao wrote:
> > > Yes it is HW capability. It can be either in simple mode or SG mode
> > > Earlier In the driver this configuration is read from the device-tree
> > > But as per lars and your suggestion moved it as runtime config parameters.
> > 
> > If sg mode is available why would anyone _not_ want it?
> > 
> > I do not think there is point to have this
> 
> You mean always keep the device in SG mode and provide an option 
> For simple dma mode if user want to use simple DMA mode??

Yes, why would anyone want to use single if sg is available?

> 
> There are few features that are available in the simple DMA mode won't
> Available in SG mode like write only DMA , read only DMA mode etc...

Can you explain what these are, how they are used by clients?

> > > > > +	chan->config.ratectrl = cfg->ratectrl;
> > > > > +	chan->config.src_issue = cfg->src_issue;
> > > > > +	chan->config.src_burst_len = cfg->src_burst_len;
> > > > > +	chan->config.dst_burst_len = cfg->dst_burst_len;
> > > >
> > > > can you describe these parameters?
> > > ratectl:
> > > Rate control can be independently enabled per channel. When rate
> > > control is enabled, the DMA channel uses the rate control count to schedule
> > successive data read transactions.
> > 
> > And how is this used by client?
> 
> When rate control is enabled, ZDMA channel uses the rate control count
> To schedule successive data read transactions I mean kind of flow control to schedule 
> Transactions at fixed intervals instead of pumping the transfers without delay or whenever bus is available
> 
> Rate control count register definition (11:0):
> Scheduling interval for SRC AXI transaction, only used if rate control is enabled 

Okay, why would anyone want transactions at fixed interval. We are talking
about DMA, so please give me transfers without delay or whenever bus is
available!


> > > src_issue:
> > > Tells outstanding transaction on SRC.
> > 
> > This should be read only then, right?
> 
> It is a Read/Write register
> http://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers.html 
> By default it is configured for Max transactions.
> If user want to limit it they can limit it using this config option.

And why would they want that?

> > > Burst_len:
> > > Configures the burst length of the src and dst transfers...
> > 
> > Hmmm, but you are on memcpy, so that should be programmed for throughput?
> 
> Yes...

So max burst lengths then, why would anyone configure lesser?

> > > > How would a client know how to configure them?
> > >
> > > With the default values of the config parameters driver will work.
> > 
> > But how will client know what is default!
> 
> Default values means IP default state after reset.
> If user not aware of the above parameters also still the driver will work for basic functionality.
> Do you want me to implement one more API get_config so that 
> Whenever user will call the get_config he will know the default values
> Of the config parameters?

Looking at above I think we do not warrant programming them. Assume defaults
in your driver for performance. Like max burst lengths, Max transactions,
without delay scheduling.

If you disagree, which is fine, please provide the cases where a client
would need to program these to different values.

> > > If user has specific requirement to change these parameters they can
> > > pass It to the driver using set_config API and all these parameters
> > > are Documented in the include/linux/dma/xilinx_dma.h file...
> > 
> > Can you give me an example where user would like to do that
> 
> I am using customized dma test client.
> There I am calling this set_config API before triggering memcpy/SG operations.

Well that is precisely a  problem. The generic applications wont know "your"
custom API and will not configure that!

-- 
~Vinod

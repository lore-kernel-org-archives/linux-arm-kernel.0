From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jul 2017 22:47:35 +0530
Subject: [PATCH v2 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <3c04c9bf-572d-98a6-ff62-83498bbc7fdf@st.com>
References: <1499343941-6375-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343941-6375-3-git-send-email-pierre-yves.mordret@st.com>
 <20170721075547.GO3053@localhost>
 <ee278ecf-02a3-7799-888a-9590d1105bb3@st.com>
 <20170721095411.GR3053@localhost>
 <3c04c9bf-572d-98a6-ff62-83498bbc7fdf@st.com>
Message-ID: <20170721171735.GS3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 10:32:49AM +0000, Pierre Yves MORDRET wrote:
> >>>> +static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
> >>>> +				     enum dma_transfer_direction direction,
> >>>> +				     u32 *mdma_ccr, u32 *mdma_ctcr,
> >>>> +				     u32 *mdma_ctbr, u32 buf_len)
> >>>> +{
> >>>> +	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> >>>> +	struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
> >>>> +	enum dma_slave_buswidth src_addr_width, dst_addr_width;
> >>>> +	phys_addr_t src_addr, dst_addr;
> >>>> +	int src_bus_width, dst_bus_width;
> >>>> +	u32 src_maxburst, dst_maxburst, src_best_burst, dst_best_burst;
> >>>> +	u32 ccr, ctcr, ctbr, tlen;
> >>>> +
> >>>> +	src_addr_width = chan->dma_config.src_addr_width;
> >>>> +	dst_addr_width = chan->dma_config.dst_addr_width;
> >>>> +	src_maxburst = chan->dma_config.src_maxburst;
> >>>> +	dst_maxburst = chan->dma_config.dst_maxburst;
> >>>> +	src_addr = chan->dma_config.src_addr;
> >>>> +	dst_addr = chan->dma_config.dst_addr;
> >>>
> >>> this doesn't seem right to me, only the periphral address would come from
> >>> slave_config, the memory address is passed as an arg to transfer..
> >>>
> >>> ...
> >>>
> >>
> >> Correct. But these locals are managed in the case statement below. if direction
> >> is Mem2Dev only dst_addr(Peripheral) is considered. In the other way around with
> >> Dev2Mem direction only src_addr(Peripheral) is considered.
> >> However to disambiguate I can move src_addr & dst_addr affectation in the
> >> corresponding case statement if you'd like.
> > 
> > But below you are over writing both, so in effect this is wasted cycles..
> > anyway latter one is more clear, so lets remove from here.
> > 
> 
> Sorry I don't follow ... or miss something
> For instance if direction is Mem2Dev ..._xfer_param is going to configure 
> Destination Bus width and Addr given by slave_config. ..._setup_xfer in its turn 
> will configure source given as parameter.
> Don't the see the over-writing

ah re-looking at it, yes you are right.

The above two assignments threw me off, I should have read it properly.

But I think calculating for src and dstn always might not be optimal as you
would use one only, so should these be moved to respective case where they
are used...

-- 
~Vinod

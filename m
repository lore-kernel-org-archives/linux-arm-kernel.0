From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 09 May 2011 11:17:21 +0530
Subject: [PATCH V4 3/5] dmaengine/dw_dmac: Divide one sg to many desc,
	if sg len is greater than DWC_MAX_COUNT
In-Reply-To: <4DC783A9.5060802@st.com>
References: <cover.1304596524.git.viresh.kumar@st.com>
	<f3150fa0fb160c70760b95ac72423ebba354f188.1304596524.git.viresh.kumar@st.com>
	<1304918425.32447.20.camel@vkoul-udesk3>  <4DC783A9.5060802@st.com>
Message-ID: <1304920041.32447.33.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-09 at 11:33 +0530, viresh kumar wrote:
> On 05/09/2011 10:50 AM, Koul, Vinod wrote:
> >> > @@ -695,9 +695,15 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> >> >  		reg = dws->tx_reg;
> >> >  		for_each_sg(sgl, sg, sg_len, i) {
> >> >  			struct dw_desc	*desc;
> >> > -			u32		len;
> >> > -			u32		mem;
> >> > +			u32		len, dlen, mem;
> >> >  
> >> > +			mem = sg_phys(sg);
> >> > +			len = sg_dma_len(sg);
> >> > +			mem_width = 2;
> > hardcoding mem_width doesn't make sense, you should take this from input
> > params
> 
> Firstly, this change is not introduced in this patch, i have just rearranged this.
> So, will send separate patch if this change is required.
> 
> Secondly, peripheral width is taken from chan->private. And by 2 for mem_width,
> we meant word-by-word here. Shouldn't we always try word-by-word here?
> How should we pass width for memory?
Ah, then there is another todo for this driver. Move from chan->private
to DMA_SLAVE_CONFIG.

struct dma_slave_config has dedicated fields for both source and
destination widths, src_addr_width & dst_addr_width please use them...
You should pass this structure to device control API as:
dmaengine_device_control(
	chan, DMA_SLAVE_CONFIG, (unsigned long)&slave_config);

-- 
~Vinod

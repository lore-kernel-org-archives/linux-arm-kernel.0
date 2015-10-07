From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 Oct 2015 12:15:31 +0100
Subject: [PATCH v2 4/9] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1441980871-24475-5-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <20151007111529.GA4810@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:14:26PM +0100, Peter Griffin wrote:

> +static char *fdma_clk_name[CLK_MAX_NUM] = {
> +	[CLK_SLIM]	= "fdma_slim",
> +	[CLK_HI]	= "fdma_hi",
> +	[CLK_LOW]	= "fdma_low",
> +	[CLK_IC]	= "fdma_ic",
> +};

why do we want to have this sort of data in kernel, we should get the clocks
from DT here

> +static int config_reqctrl(struct st_fdma_chan *fchan)
> +{
> +	u32 maxburst = 0, addr = 0;
> +	enum dma_slave_buswidth width;
> +	int ch_id = fchan->vchan.chan.chan_id;
> +	struct st_fdma_dev *fdev = fchan->fdev;
> +
> +	if (fchan->scfg.direction == DMA_DEV_TO_MEM) {
> +		fchan->cfg.req_ctrl &= ~REQ_CTRL_WNR;
> +		maxburst = fchan->scfg.src_maxburst;
> +		width = fchan->scfg.src_addr_width;
> +		addr = fchan->scfg.src_addr;
> +	} else if (fchan->scfg.direction == DMA_MEM_TO_DEV) {
> +		fchan->cfg.req_ctrl |= REQ_CTRL_WNR;
> +		maxburst = fchan->scfg.dst_maxburst;
> +		width = fchan->scfg.dst_addr_width;
> +		addr = fchan->scfg.dst_addr;

This raises red flags, why do we have direction in channel, and where is
this set. Direction belong to a descriptor and you are supposed to use
direction from prep_ calls!


> +	if (!is_slave_direction(direction)) {
> +		dev_err(fchan->fdev->dev, "bad direction?\n");
> +		return NULL;
> +	}
> +
> +	if (!config_reqctrl(fchan)) {
> +		dev_err(fchan->fdev->dev, "bad width or direction\n");

would make sense to print proper error in called fn

> +static enum dma_status st_fdma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> +	struct virt_dma_desc *vd;
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	if (!txstate)
> +		return fchan->status;

why channel status and not cookie status ?

> +static const struct st_fdma_ram fdma_mpe31_mem[] = {
> +	{ .name = "dmem", .offset = 0x10000, .size = 0x3000 },
> +	{ .name = "imem", .offset = 0x18000, .size = 0x8000 },
> +};

why aren't these coming from DT ?

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
> +MODULE_AUTHOR("Ludovic.barre <Ludovic.barre@st.com>");

No MODULE_ALIAS ?

-- 
~Vinod

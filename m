From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 27 Apr 2016 13:59:23 +0100
Subject: [PATCH 03/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <20160426165622.GR2274@localhost>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-4-git-send-email-peter.griffin@linaro.org>
 <20160426165622.GR2274@localhost>
Message-ID: <20160427125923.GA12756@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for reviewing.

On Tue, 26 Apr 2016, Vinod Koul wrote:

> On Thu, Apr 21, 2016 at 12:04:20PM +0100, Peter Griffin wrote:
> 
> > +	if (!atomic_read(&fchan->fdev->fw_loaded)) {
> > +		dev_err(fchan->fdev->dev, "%s: fdma fw not loaded\n", __func__);
> > +		return NULL;
> > +	}
> 
> so who is loading the fw and setting fw_loaded, it is not set in this patch?

This shouldn't be in this patch. It should have been added as part of the
"dmaengine: st_fdma: Add xp70 firmware loading mechanism" patch.

> 
> > +	if (direction == DMA_DEV_TO_MEM) {
> > +		fchan->cfg.req_ctrl &= ~REQ_CTRL_WNR;
> > +		maxburst = fchan->scfg.src_maxburst;
> > +		width = fchan->scfg.src_addr_width;
> > +		addr = fchan->scfg.src_addr;
> > +	} else if (direction == DMA_MEM_TO_DEV) {
> > +		fchan->cfg.req_ctrl |= REQ_CTRL_WNR;
> > +		maxburst = fchan->scfg.dst_maxburst;
> > +		width = fchan->scfg.dst_addr_width;
> > +		addr = fchan->scfg.dst_addr;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> 
> switch please

Ok, will fix in v4
> 
> > +
> > +	fchan->cfg.req_ctrl &= ~REQ_CTRL_OPCODE_MASK;
> > +	if (width == DMA_SLAVE_BUSWIDTH_1_BYTE)
> > +		fchan->cfg.req_ctrl |= REQ_CTRL_OPCODE_LD_ST1;
> > +	else if (width == DMA_SLAVE_BUSWIDTH_2_BYTES)
> > +		fchan->cfg.req_ctrl |= REQ_CTRL_OPCODE_LD_ST2;
> > +	else if (width == DMA_SLAVE_BUSWIDTH_4_BYTES)
> > +		fchan->cfg.req_ctrl |= REQ_CTRL_OPCODE_LD_ST4;
> > +	else if (width == DMA_SLAVE_BUSWIDTH_8_BYTES)
> > +		fchan->cfg.req_ctrl |= REQ_CTRL_OPCODE_LD_ST8;
> > +	else
> > +		return -EINVAL;
> 
> here as well

Ok, will fix in v4.
> 
> > +static void fill_hw_node(struct st_fdma_hw_node *hw_node,
> > +			struct st_fdma_chan *fchan,
> > +			enum dma_transfer_direction direction)
> > +{
> > +
> > +	if (direction == DMA_MEM_TO_DEV) {
> > +		hw_node->control |= NODE_CTRL_SRC_INCR;
> > +		hw_node->control |= NODE_CTRL_DST_STATIC;
> > +		hw_node->daddr = fchan->cfg.dev_addr;
> > +	} else {
> > +		hw_node->control |= NODE_CTRL_SRC_STATIC;
> > +		hw_node->control |= NODE_CTRL_DST_INCR;
> > +		hw_node->saddr = fchan->cfg.dev_addr;
> > +	}
> 
> empty line here at other places too. The code looks very compressed and bit
> harder to read overall

Ok, will fix in v4.

> 
> > +	fdesc = st_fdma_alloc_desc(fchan, sg_len);
> > +	if (!fdesc) {
> > +		dev_err(fchan->fdev->dev, "no memory for desc\n");
> > +		return NULL;
> > +	}
> > +
> > +	fdesc->iscyclic = false;
> > +
> > +	for_each_sg(sgl, sg, sg_len, i) {
> > +		hw_node = fdesc->node[i].desc;
> > +
> > +		hw_node->next = fdesc->node[(i + 1) % sg_len].pdesc;
> > +		hw_node->control = NODE_CTRL_REQ_MAP_DREQ(fchan->dreq_line);
> > +
> > +		fill_hw_node(hw_node, fchan, direction);
> > +
> > +		if (direction == DMA_MEM_TO_DEV)
> > +			hw_node->saddr = sg_dma_address(sg);
> > +		else
> > +			hw_node->daddr = sg_dma_address(sg);
> > +
> > +		hw_node->nbytes = sg_dma_len(sg);
> > +		hw_node->generic.length = sg_dma_len(sg);
> > +	}
> > +
> > +	/* interrupt at end of last node */
> > +	hw_node->control |= NODE_CTRL_INT_EON;
> > +
> > +	return vchan_tx_prep(&fchan->vchan, &fdesc->vdesc, flags);
> 
> bunch of this seems similar to cyclic case, can you create common setup
> routine for these, anyway cyclic is a special cases of slave_sg

In v4 I've made a st_fdma_prep_common() which abstracts out all the common
checks at the beginning of the *_prep*() functions.

In v3 fill_fw_node() is already (from one of your previous reviews)
abstracting out all the common parts from these loops. So everything
that is now left is actually differences between the two setups.

Is that Ok?

> 
> > +
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	if (ret == DMA_COMPLETE)
> > +		return ret;
> > +
> > +	if (!txstate)
> > +		return fchan->status;
> 
> why channel status, query is for descriptor

Ok, will fix in v4.

> 
> > +static int st_fdma_remove(struct platform_device *pdev)
> > +{
> > +	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
> > +
> > +	st_fdma_clk_disable(fdev);
> 
> and you irq is still enabled and tasklets can be scheduled!!
> 
Eeek! Very good point. Also looking at some other drivers we
should be doing a of_dma_controller_free() and
dma_async_device_unregister().

So something like this: -

  st_fdma_disable(); /*disables irqs*/
  of_dma_controller_free(pdev->dev.of_node);
  dma_async_device_unregister(&priv->slave);
  st_fdma_clk_disable(fdev);

regards,

Peter.

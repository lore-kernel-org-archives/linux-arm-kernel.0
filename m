From: jeremy.trimble@gmail.com (Jeremy Trimble)
Date: Fri, 19 Jun 2015 12:49:25 -0400
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine driver
 support
In-Reply-To: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
Message-ID: <CAHYiM2+hVn1s5ky6He4+ApvsM_adMfo=q+T_owXd7wkJ6rjHNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/**
> + * xilinx_dma_start_transfer - Starts DMA transfer
> + * @chan: Driver specific channel struct pointer
> + */
> +static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
> +{
> +       struct xilinx_dma_tx_descriptor *desc;
> +       struct xilinx_dma_tx_segment *head, *tail = NULL;
> +
> +       if (chan->err)
> +               return;
> +
> +       if (list_empty(&chan->pending_list))
> +               return;
> +
> +       if (!chan->idle)
> +               return;
> +
> +       desc = list_first_entry(&chan->pending_list,
> +                               struct xilinx_dma_tx_descriptor, node);
> +
> +       if (chan->has_sg && xilinx_dma_is_running(chan) &&
> +           !xilinx_dma_is_idle(chan)) {
> +               tail = list_entry(desc->segments.prev,
> +                                 struct xilinx_dma_tx_segment, node);
> +               dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC, tail->phys);
> +               goto out_free_desc;
> +       }
> +
> +       if (chan->has_sg) {
> +               head = list_first_entry(&desc->segments,
> +                                       struct xilinx_dma_tx_segment, node);
> +               tail = list_entry(desc->segments.prev,
> +                                 struct xilinx_dma_tx_segment, node);
> +               dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC, head->phys);
> +       }
> +
> +       /* Enable interrupts */
> +       dma_ctrl_set(chan, XILINX_DMA_REG_CONTROL,
> +                    XILINX_DMA_XR_IRQ_ALL_MASK);
> +
> +       xilinx_dma_start(chan);
> +       if (chan->err)
> +               return;
> +
> +       /* Start the transfer */
> +       if (chan->has_sg) {
> +               dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC, tail->phys);
> +       } else {
> +               struct xilinx_dma_tx_segment *segment;
> +               struct xilinx_dma_desc_hw *hw;
> +
> +               segment = list_first_entry(&desc->segments,
> +                                          struct xilinx_dma_tx_segment, node);
> +               hw = &segment->hw;
> +
> +               if (desc->direction == DMA_MEM_TO_DEV)
> +                       dma_ctrl_write(chan, XILINX_DMA_REG_SRCADDR,
> +                                      hw->buf_addr);
> +               else
> +                       dma_ctrl_write(chan, XILINX_DMA_REG_DSTADDR,
> +                                      hw->buf_addr);
> +
> +               /* Start the transfer */
> +               dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> +                              hw->control & XILINX_DMA_MAX_TRANS_LEN);
> +       }
> +
> +out_free_desc:
> +       list_del(&desc->node);
> +       chan->idle = false;
> +       chan->active_desc = desc;
> +}

What prevents chan->active_desc from being overwritten before the
previous descriptor is transferred to done_list.  For instance, if two
transfers are queued with issue_pending() in quick succession (such
that xilinx_dma_start_transfer() is called twice before the interrupt
for the first transfer occurs), won't the first descriptor be
overwritten and lost?

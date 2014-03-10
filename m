From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 11 Mar 2014 00:00:12 +0800
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Video Direct Memory Access
 Engine driver support
In-Reply-To: <1394104717-3100-3-git-send-email-sthokal@xilinx.com>
References: <1394104717-3100-1-git-send-email-sthokal@xilinx.com>
 <1394104717-3100-3-git-send-email-sthokal@xilinx.com>
Message-ID: <CABb+yY1y1sOozVU=iAsotWG-q3N=SogjHjZ=iF04CiXF89eeOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 6, 2014 at 7:18 PM, Srikanth Thokala <sthokal@xilinx.com> wrote:

> +static struct dma_async_tx_descriptor *
> +xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
> +                                struct dma_interleaved_template *xt,
> +                                unsigned long flags)
> +{
> +       struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
> +       struct xilinx_vdma_tx_descriptor *desc;
> +       struct xilinx_vdma_tx_segment *segment;
> +       struct xilinx_vdma_tx_segment *prev = NULL;
> +       int i;
> +
> +       if ((xt->dir != DMA_MEM_TO_DEV) && (xt->dir != DMA_DEV_TO_MEM))
> +               return NULL;
> +
> +       if (!xt->numf || !xt->sgl[0].size)
> +               return NULL;
> +
> +       /* Allocate a transaction descriptor. */
> +       desc = xilinx_vdma_alloc_tx_descriptor(chan);
> +       if (!desc)
> +               return NULL;
> +
> +       dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
> +       desc->async_tx.tx_submit = xilinx_vdma_tx_submit;
> +       desc->async_tx.cookie = 0;
> +       async_tx_ack(&desc->async_tx);
> +
> +       /* Build the list of transaction segments. */
> +       for (i = 0; i < xt->frame_size; i++) {
> +               struct xilinx_vdma_desc_hw *hw;
> +
> +               /* Allocate the link descriptor from DMA pool */
> +               segment = xilinx_vdma_alloc_tx_segment(chan);
> +               if (!segment)
> +                       goto error;
> +
> +               /* Fill in the hardware descriptor */
> +               hw = &segment->hw;
> +               hw->vsize = xt->numf;
> +               hw->hsize = xt->sgl[0].size;
> +               hw->stride = xt->sgl[0].icg <<
> +                               XILINX_VDMA_FRMDLY_STRIDE_STRIDE_SHIFT;
>
It seems the xt->frame_size is (should be?) always going to be 1?
If yes, the for-loop isn't needed.
If no, you should probably use 'i' as the index to sgl[], and not always 0.

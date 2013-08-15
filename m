From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 15 Aug 2013 09:57:11 +0800
Subject: [v3 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376497189-21298-1-git-send-email-zonque@gmail.com>
References: <1376497189-21298-1-git-send-email-zonque@gmail.com>
Message-ID: <CADApbegKj=AMGx4OFOBVsyk71BGis97Gw9QM_-0EsNi90pS+Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 12:19 AM, Daniel Mack <zonque@gmail.com> wrote:
> In order to report the channel's residue, we have to memorize the first
> dma buffer position when the channel is configured.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/dma/mmp_pdma.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 579f79a..d66340a 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -28,8 +28,8 @@
>  #define DALGN          0x00a0
>  #define DINT           0x00f0
>  #define DDADR          0x0200
> -#define DSADR          0x0204
> -#define DTADR          0x0208
> +#define DSADR(n)       (0x0204 + ((n) << 4))
> +#define DTADR(n)       (0x0208 + ((n) << 4))
>  #define DCMD           0x020c
>
>  #define DCSR_RUN       (1 << 31)       /* Run Bit (read / write) */
> @@ -97,6 +97,11 @@ struct mmp_pdma_chan {
>         struct dma_async_tx_descriptor desc;
>         struct mmp_pdma_phy *phy;
>         enum dma_transfer_direction dir;
> +       /*
> +        * We memorize the original total length so we can later determine the
> +        * channel's residue.
> +        */
> +       u32 total_len;
>
>         /* channel's basic info */
>         struct tasklet_struct tasklet;
> @@ -470,6 +475,8 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
>                 chan->dcmd |= DCMD_BURST32;
>         }
>
> +       chan->total_len = len;
> +
>         do {
>                 /* Allocate the link descriptor from DMA pool */
>                 new = mmp_pdma_alloc_descriptor(chan);
> @@ -541,11 +548,14 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>                 return NULL;
>
>         chan->byte_align = false;
> +       chan->total_len = 0;
>
>         for_each_sg(sgl, sg, sg_len, i) {
>                 addr = sg_dma_address(sg);
>                 avail = sg_dma_len(sgl);
>
> +               chan->total_len += avail;
> +
>                 do {
>                         len = min_t(size_t, avail, PDMA_MAX_DESC_BYTES);
>                         if (addr & 0x7)
> @@ -666,6 +676,36 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>         return ret;
>  }
>
> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan)
> +{
> +       struct mmp_pdma_desc_sw *sw;
> +       u32 curr, done = 0;
> +
> +       if (chan->dir == DMA_DEV_TO_MEM)
> +               curr = readl(chan->phy->base + DTADR(chan->phy->idx));
> +       else
> +               curr = readl(chan->phy->base + DSADR(chan->phy->idx));
> +
> +       list_for_each_entry(sw, &chan->chain_running, node) {
> +               u32 start;
> +               u32 len = sw->desc.dcmd & DCMD_LENGTH;
> +
> +               if (chan->dir == DMA_DEV_TO_MEM)
> +                       start = sw->desc.dtadr;
> +               else
> +                       start = sw->desc.dsadr;
> +
> +               if (curr >= start && curr <= (start + len)) {
> +                       done += curr - start;
> +                       break;
> +               }
> +
> +               done += len;
> +       }
> +
> +       return chan->total_len - done;
> +}
> +

It seems that you will get all the residue bytes in the channel.
For DMA transfer, user may submit many trasaction.
The transaction will be composed by mutiple desctiptors. So it means
that chan->chain_running includes
the descriptors from all ongoing transactions.
When user try to get the tx_status, user will pass the cookie to
identify which transaction it want to get the status.
So for mmp_pdma_residue, it need care about the cookie, and find out
the transaction, then calculate the residue bytes.

The orignal driver has a issue, it will assign cookie for all
descriptors, not the transaction. I think that need to be changed.

>  static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>                         dma_cookie_t cookie, struct dma_tx_state *txstate)
>  {
> @@ -675,6 +715,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>
>         spin_lock_irqsave(&chan->desc_lock, flags);
>         ret = dma_cookie_status(dchan, cookie, txstate);
> +       txstate->residue = mmp_pdma_residue(chan);
>         spin_unlock_irqrestore(&chan->desc_lock, flags);
>
>         return ret;
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

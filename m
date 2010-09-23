From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 23 Sep 2010 12:53:58 -0700
Subject: [PATCH 2/3] dmaengine: add wrapper functions for dmaengine
In-Reply-To: <1281956870-12463-3-git-send-email-s.hauer@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTin8v_29HESnmhE5==3OLmb29bmoOY1iona4C+eD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 4:07 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Currently dmaengine users have to explicitely dereference function
> pointers in struct dma_device. For the convenience of drivers and
> to be more flexible when changing the dmaengine later add static
> inline wrapper functions for the dma commands.
>
> This patch is not complete yet. If there's consensus on this patch
> I'll provide an updated patch with the missing functions.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ?include/linux/dmaengine.h | ? 41 +++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 41 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0df7864..635c60b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -491,6 +491,47 @@ struct dma_device {
> ? ? ? ?void (*device_issue_pending)(struct dma_chan *chan);
> ?};
>
> +static inline int dmaengine_device_control(struct dma_chan *chan,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?enum dma_ctrl_cmd cmd,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long arg)
> +{
> + ? ? ? return chan->device->device_control(chan, cmd, arg);
> +}
> +
> +static inline int dmaengine_slave_config(struct dma_chan *chan,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct dma_slave_config *config)
> +{
> + ? ? ? return dmaengine_device_control(chan, DMA_SLAVE_CONFIG,
> + ? ? ? ? ? ? ? ? ? ? ? (unsigned long)config);
> +}
> +
> +static inline int dmaengine_terminate_all(struct dma_chan *chan)
> +{
> + ? ? ? return dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
> +}
> +
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> + ? ? ? ? ? ? ? struct dma_chan *chan, struct scatterlist *sgl,
> + ? ? ? ? ? ? ? unsigned int sg_len, enum dma_data_direction direction,
> + ? ? ? ? ? ? ? unsigned long flags)
> +{
> + ? ? ? return chan->device->device_prep_slave_sg(chan, sgl, sg_len, direction,
> + ? ? ? ? ? ? ? ? ? ? ? flags);
> +}
> +
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_cyclic(
> + ? ? ? ? ? ? ? struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> + ? ? ? ? ? ? ? size_t period_len, enum dma_data_direction direction)
> +{
> + ? ? ? return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
> + ? ? ? ? ? ? ? ? ? ? ? period_len, direction);
> +}
> +

No strong disagreements on the above, the type safety of
dmaengine_slave_config() is nice.

> +static inline int dmaengine_tx_submit(struct dma_async_tx_descriptor *desc)
> +{
> + ? ? ? return desc->tx_submit(desc);
> +}

This one can drop the tx.

--
Dan

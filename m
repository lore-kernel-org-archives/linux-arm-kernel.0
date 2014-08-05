From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Aug 2014 22:00:42 +0200
Subject: [PATCH v3 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
 <1407183002-29420-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140805200042.GO3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Overall it looks very nice, thanks.

On Mon, Aug 04, 2014 at 05:09:55PM -0300, Emilio L?pez wrote:
> +static struct sun4i_dma_pchan *find_and_use_pchan(struct sun4i_dma_dev *priv,
> +                                                 struct sun4i_dma_vchan *vchan)
> +{
> +       struct sun4i_dma_pchan *pchan = NULL, *pchans = priv->pchans;
> +       unsigned long flags;
> +       int i, max;
> +
> +       /*
> +        * pchans 0-NDMA_NR_MAX_CHANNELS are normal, and
> +        * NDMA_NR_MAX_CHANNELS+ are dedicated ones
> +        */
> +       if (vchan->is_dedicated) {
> +               i = NDMA_NR_MAX_CHANNELS;
> +               max = DMA_NR_MAX_CHANNELS;
> +       } else {
> +               i = 0;
> +               max = NDMA_NR_MAX_CHANNELS;
> +       }
> +
> +       spin_lock_irqsave(&priv->lock, flags);
> +       for_each_clear_bit_from(i, &priv->pchans_used, max) {
> +               pchan = &pchans[i];
> +               pchan->vchan = vchan;
> +               set_bit(i, priv->pchans_used);
> +               break;

ffz instead?

> +static int execute_vchan_pending(struct sun4i_dma_dev *priv,
> +				 struct sun4i_dma_vchan *vchan)
> +{
> +	struct sun4i_dma_promise *promise = NULL;
> +	struct sun4i_dma_contract *contract = NULL;
> +	struct sun4i_dma_pchan *pchan;
> +	struct virt_dma_desc *vd;
> +	int ret;
> +
> +	lockdep_assert_held(&vchan->vc.lock);

So this has to be called with a lock taken?

You should mention that somewhere.
Usually, such fonctions are also prefixed by "__"

> +/**
> + * Generate a promise, to be used in a normal DMA contract.
> + *
> + * A NDMA promise contains all the information required to program the
> + * normal part of the DMA Engine and get data copied. A non-executed
> + * promise will live in the demands list on a contract. Once it has been
> + * completed, it will be moved to the completed demands list for later freeing.
> + * All linked promises will be freed when the corresponding contract is freed
> + */
> +static struct sun4i_dma_promise *
> +generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
> +		      size_t len, struct dma_slave_config *sconfig)
> +{
> +	struct sun4i_dma_promise *promise;
> +	int ret;
> +
> +	promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
> +	if (!promise)
> +		return NULL;
> +
> +	promise->src = src;
> +	promise->dst = dest;
> +	promise->len = len;
> +	promise->cfg = NDMA_CFG_LOADING | NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
> +
> +	/* Use sensible default values if client is using undefined ones */
> +	if (sconfig->src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		sconfig->src_addr_width = sconfig->dst_addr_width;
> +	if (sconfig->dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +		sconfig->dst_addr_width = sconfig->src_addr_width;
> +	if (sconfig->src_maxburst == 0)
> +		sconfig->src_maxburst = sconfig->dst_maxburst;
> +	if (sconfig->dst_maxburst == 0)
> +		sconfig->dst_maxburst = sconfig->src_maxburst;

I'm not sure what's the default policy on that. Vinod?

> +static irqreturn_t sun4i_dma_submit_work(int irq, void *dev_id)
> +{
> +	struct sun4i_dma_dev *priv = dev_id;
> +	struct sun4i_dma_vchan *vchan;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i = 0; i < DMA_NR_MAX_VCHANS; i++) {
> +		vchan = &priv->vchans[i];
> +		spin_lock_irqsave(&vchan->vc.lock, flags);
> +		execute_vchan_pending(priv, vchan);
> +		spin_unlock_irqrestore(&vchan->vc.lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

Judging from Russell's comment here, that should be in the interrupt
handler

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277737.html

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140805/cf899a3b/attachment.sig>

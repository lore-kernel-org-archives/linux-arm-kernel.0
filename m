From: mirq-linux@rere.qmqm.pl (=?iso-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Tue, 5 Dec 2017 20:03:31 +0100
Subject: [PATCH net-next 2/2 v6] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20171202110640.5284-2-linus.walleij@linaro.org>
References: <20171202110640.5284-1-linus.walleij@linaro.org>
 <20171202110640.5284-2-linus.walleij@linaro.org>
Message-ID: <20171205190331.GA29007@qmqm.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 02, 2017 at 12:06:40PM +0100, Linus Walleij wrote:
[...]
> The latest v6 incarnation of this driver was written by Micha?
> Miros?aw and submitted for inclusion in 2011. This was the
> last post:
> https://lwn.net/Articles/437889/
> 
> DaveM ACKed it at the time:
> https://marc.info/?l=linux-netdev&m=130255434310315&w=2
> 
> The controversial pieces under ARM (board files) and other
> subsystems are now gone and replaced by DeviceTree.
> 
> Micha?: I hope you don't mind me picking it up and hope
> you can still test it on your ICYbox, I have device tree
> patches in my tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/log/?h=gemini-ethernet

I'm happy to see that my work didn't go to /dev/null after all.
I haven't finished it at the time because the box I had broke down
beyond repair.

I skimmed through the patch - please find my comments below.

Best Regards,
Micha? Miros?aw


[...]
> --- /dev/null
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -0,0 +1,2461 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ethernet device driver for Cortina Systems Gemini SoC
> + * Also known as the StorLink SL3512 and SL3516 (SL351x) GMAC
> + *
> + * Authors:
> + * Linus Walleij <linus.walleij@linaro.org>
> + * Tobias Waldvogel <tobias.waldvogel@gmail.com> (OpenWRT)
> + * Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>

Doubly UTF-8 encoded?

[...]
> +static int gmac_setup_txqs(struct net_device *netdev)
> +{
[...]
> +	desc_ring = dma_alloc_coherent(geth->dev, len * sizeof(*desc_ring),
> +		&port->txq_dma_base, GFP_KERNEL);
> +
> +	if (!desc_ring) {

Should check with dma_mapping_error().

> +		kfree(skb_tab);
> +		return -ENOMEM;
> +	}
> +
> +	BUG_ON(port->txq_dma_base & ~DMA_Q_BASE_MASK);

BUG is too hard here. return -EINVAL or other error? Shouldn't happen
if dma_alloc_coherent() guarantees 16B alignment.

[...]
> +static int gmac_setup_rxq(struct net_device *netdev)
> +{
[...]
> +	BUG_ON(port->rxq_dma_base & ~NONTOE_QHDR0_BASE_MASK);

Like above.

[...]
> +static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
> +					      int pn)
> +{
> +	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	unsigned int frag_len = 1 << geth->freeq_frag_order;
> +	GMAC_RXDESC_T *freeq_entry;
> +	dma_addr_t mapping;
> +	struct page *page;
> +	int i;
> +
> +	page = alloc_page(GFP_ATOMIC);
> +	if (!page)
> +		return NULL;
> +
> +	mapping = dma_map_single(geth->dev, page_address(page),
> +				PAGE_SIZE, DMA_FROM_DEVICE);
> +
> +	if (unlikely(dma_mapping_error(geth->dev, mapping) || !mapping)) {

This should test only dma_mapping_error() since mapping == 0 is valid,
but unlikely.

> +static int geth_setup_freeq(struct gemini_ethernet *geth)
> +{
> +	void __iomem *dma_reg = geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG;
> +	QUEUE_THRESHOLD_T qt;
> +	DMA_SKB_SIZE_T skbsz;
> +	unsigned int filled;
> +	unsigned int frag_len = 1 << geth->freeq_frag_order;
> +	unsigned int len = 1 << geth->freeq_order;
> +	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	unsigned int pages = len >> fpp_order;
> +	dma_addr_t mapping;
> +	unsigned int pn;
> +
> +	geth->freeq_ring = dma_alloc_coherent(geth->dev,
> +		sizeof(*geth->freeq_ring) << geth->freeq_order,
> +		&geth->freeq_dma_base, GFP_KERNEL);
> +	if (!geth->freeq_ring)
> +		return -ENOMEM;
> +
> +	BUG_ON(geth->freeq_dma_base & ~DMA_Q_BASE_MASK);

Another BUG_ON:

if (WARN_ON(...)) goto err_freeq;

[...]
> +static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
> +			    struct gmac_txq *txq, unsigned short *desc)
> +{
[...]
> +	if (word1 > mtu) {
> +		word1 |= TSS_MTU_ENABLE_BIT;
> +		word3 += mtu;

word3 |= mtu; would be more natural.

[...]
> +		mapping = dma_map_single(geth->dev, buffer, buflen,
> +					DMA_TO_DEVICE);
> +		if (dma_mapping_error(geth->dev, mapping) ||
> +			!(mapping & PAGE_MASK))
> +			goto map_error;

Is page at phys 0 special to the HW?

[...]
> +map_error:
> +	while (w != *desc) {
> +		w--;
> +		w &= m;
> +
> +		dma_unmap_page(geth->dev, txq->ring[w].word2.buf_adr,
> +			txq->ring[w].word0.bits.buffer_size, DMA_TO_DEVICE);
> +	}
> +	return ENOMEM;

return -ENOMEM; for consistency, though not used in the caller.

[...]
> +static int gmac_start_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
[...]
> +	if (unlikely(gmac_map_tx_bufs(netdev, skb, txq, &w))) {
> +		if (skb_linearize(skb))
> +			goto out_drop;
> +
> +		if (unlikely(gmac_map_tx_bufs(netdev, skb, txq, &w)))
> +			goto out_drop_free;
> +
> +		u64_stats_update_begin(&port->tx_stats_syncp);
> +		port->tx_frags_linearized++;
> +		u64_stats_update_end(&port->tx_stats_syncp);

This misses stats update when mapping after skb_linearize() fails.

[...]
> +static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
> +	GMAC_RXDESC_0_T word0, unsigned frame_len)
> +{
> +	struct sk_buff *skb = NULL;
> +	unsigned rx_status = word0.bits.status;
> +	unsigned rx_csum = word0.bits.chksum_status;

> +	port->rx_stats[rx_status]++;
> +	port->rx_csum_stats[rx_csum]++;
> +
> +	if (word0.bits.derr || word0.bits.perr ||
> +	    rx_status || frame_len < ETH_ZLEN ||
> +	    rx_csum >= RX_CHKSUM_IP_ERR_UNKNOWN) {
> +		port->stats.rx_errors++;
> +
> +		if (frame_len < ETH_ZLEN || RX_ERROR_LENGTH(rx_status))
> +			port->stats.rx_length_errors++;
> +		if (RX_ERROR_OVER(rx_status))
> +			port->stats.rx_over_errors++;
> +		if (RX_ERROR_CRC(rx_status))
> +			port->stats.rx_crc_errors++;
> +		if (RX_ERROR_FRAME(rx_status))
> +			port->stats.rx_frame_errors++;
> +
> +		return NULL;

Could support RXALL feature here.

> +	skb = napi_get_frags(&port->napi);
> +	if (!skb)
> +		return NULL;

This case could get a stats update, too.

> +static unsigned int gmac_rx(struct net_device *netdev, unsigned budget)
> +{
[...]
> +		if (unlikely(!mapping)) {
> +			netdev_err(netdev,
> +				   "rxq[%u]: HW BUG: zero DMA desc\n", r);
> +			goto err_drop;
> +		}

I wonder if this was a bug in the driver or in HW. Does it trigger on
your boxes?

[...]
> +static void gmac_set_rx_mode(struct net_device *netdev)
> +{
> +	struct gemini_ethernet_port *port = netdev_priv(netdev);
> +	struct netdev_hw_addr *ha;
> +	__u32 mc_filter[2];
> +	unsigned bit_nr;
> +	GMAC_RX_FLTR_T filter = { .bits = {
> +		.broadcast = 1,
> +		.multicast = 1,
> +		.unicast = 1,
> +	} };
> +
> +	mc_filter[1] = mc_filter[0] = 0;

Looks like this should be = ~0u (IFF_ALLMULTI case).

> +	if (netdev->flags & IFF_PROMISC) {
> +		filter.bits.error = 1;
> +		filter.bits.promiscuous = 1;
> +	} else if (!(netdev->flags & IFF_ALLMULTI)) {
> +		mc_filter[1] = mc_filter[0] = 0;
> +		netdev_for_each_mc_addr(ha, netdev) {
> +			bit_nr = ~crc32_le(~0, ha->addr, ETH_ALEN) & 0x3f;
> +			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 0x1f);
> +		}
> +	}
[...]

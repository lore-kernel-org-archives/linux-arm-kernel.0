From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Mon, 11 Dec 2017 13:09:02 +0100
Subject: [PATCH net-next] net: thunderx: Add support for xdp redirect
In-Reply-To: <20171124120328.7600-1-aleksey.makarov@cavium.com>
References: <20171124120328.7600-1-aleksey.makarov@cavium.com>
Message-ID: <20171211130902.482513d3@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Nov 2017 15:03:26 +0300
Aleksey Makarov <aleksey.makarov@cavium.com> wrote:

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> This patch adds support for XDP_REDIRECT. Flush is not
> yet supported.
> 
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> Signed-off-by: cjacob <cjacob@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 110 ++++++++++++++++-----
>  drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  11 ++-
>  drivers/net/ethernet/cavium/thunder/nicvf_queues.h |   4 +
>  3 files changed, 94 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index a063c36c4c58..b82e28262c57 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -65,6 +65,11 @@ module_param(cpi_alg, int, S_IRUGO);
>  MODULE_PARM_DESC(cpi_alg,
>  		 "PFC algorithm (0=none, 1=VLAN, 2=VLAN16, 3=IP Diffserv)");
>  
> +struct nicvf_xdp_tx {
> +	u64 dma_addr;
> +	u8  qidx;
> +};
> +
[...]

>  static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
>  				struct cqe_rx_t *cqe_rx, struct snd_queue *sq,
>  				struct sk_buff **skb)
>  {
>  	struct xdp_buff xdp;
>  	struct page *page;
> +	struct nicvf_xdp_tx *xdp_tx = NULL;
>  	u32 action;
> -	u16 len, offset = 0;
> +	u16 len, err, offset = 0;
>  	u64 dma_addr, cpu_addr;
>  	void *orig_data;
>  
> @@ -521,7 +541,7 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
>  	cpu_addr = (u64)phys_to_virt(cpu_addr);
>  	page = virt_to_page((void *)cpu_addr);
>  
> -	xdp.data_hard_start = page_address(page);
> +	xdp.data_hard_start = page_address(page) + RCV_BUF_HEADROOM;
>  	xdp.data = (void *)cpu_addr;
>  	xdp_set_data_meta_invalid(&xdp);
>  	xdp.data_end = xdp.data + len;
[...]
> @@ -564,6 +573,20 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
>  	case XDP_TX:
>  		nicvf_xdp_sq_append_pkt(nic, sq, (u64)xdp.data, dma_addr, len);
>  		return true;
> +	case XDP_REDIRECT:
> +		/* Save DMA address for use while transmitting */
> +		xdp_tx = (struct nicvf_xdp_tx *)page_address(page);
> +		xdp_tx->dma_addr = dma_addr;
> +		xdp_tx->qidx = nicvf_netdev_qidx(nic, cqe_rx->rq_idx);

Hey, this sucks... You cannot just invent your own in-driver usage of
the XDP packet headroom.  That is specific to your driver only.  In
effect you can only XDP_REDIRECT from your driver out your own driver.

The XDP_TX action is for driver/port local redirect.  The XDP_REDIRECT
action is between drivers.

> +
> +		err = xdp_do_redirect(nic->pnicvf->netdev, &xdp, prog);
> +		if (!err)
> +			return true;
> +
> +		/* Free the page on error */
> +		nicvf_unmap_page(nic, page, dma_addr);
> +		put_page(page);
> +		break;
>  	default:
>  		bpf_warn_invalid_xdp_action(action);
>  		/* fall through */
[...]
> @@ -1764,6 +1776,50 @@ static int nicvf_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
>  	}
>  }
>  
> +static int nicvf_xdp_xmit(struct net_device *netdev, struct xdp_buff *xdp)

This is a generic ndo_xdp_xmit that other drivers can call.

> +{
> +	struct nicvf *nic = netdev_priv(netdev);
> +	struct nicvf *snic = nic;
> +	struct nicvf_xdp_tx *xdp_tx;
> +	struct snd_queue *sq;
> +	struct page *page;
> +	int err, qidx;
> +
> +	if (!netif_running(netdev) || !nic->xdp_prog)
> +		return -EINVAL;
> +
> +	page = virt_to_page(xdp->data);
> +	xdp_tx = (struct nicvf_xdp_tx *)page_address(page);
> +	qidx = xdp_tx->qidx;

What is another driver XDP_REDIRECT a frame to your driver?

> +
> +	if (xdp_tx->qidx >= nic->xdp_tx_queues)
> +		return -EINVAL;
> +
> +	/* Get secondary Qset's info */
> +	if (xdp_tx->qidx >= MAX_SND_QUEUES_PER_QS) {
> +		qidx = xdp_tx->qidx / MAX_SND_QUEUES_PER_QS;
> +		snic = (struct nicvf *)nic->snicvf[qidx - 1];
> +		if (!snic)
> +			return -EINVAL;
> +		qidx = xdp_tx->qidx % MAX_SND_QUEUES_PER_QS;
> +	}
> +
> +	sq = &snic->qs->sq[qidx];
> +	err = nicvf_xdp_sq_append_pkt(snic, sq, (u64)xdp->data,
> +				      xdp_tx->dma_addr,
> +				      xdp->data_end - xdp->data);
> +	if (err)
> +		return -ENOMEM;
> +
> +	nicvf_xdp_sq_doorbell(snic, sq, qidx);
> +	return 0;
> +}
> +
> +static void nicvf_xdp_flush(struct net_device *dev)
> +{
> +	return;
> +}
> +
>  static const struct net_device_ops nicvf_netdev_ops = {
>  	.ndo_open		= nicvf_open,
>  	.ndo_stop		= nicvf_stop,
> @@ -1775,6 +1831,8 @@ static const struct net_device_ops nicvf_netdev_ops = {
>  	.ndo_fix_features       = nicvf_fix_features,
>  	.ndo_set_features       = nicvf_set_features,
>  	.ndo_bpf		= nicvf_xdp,
> +	.ndo_xdp_xmit		= nicvf_xdp_xmit,
> +	.ndo_xdp_flush          = nicvf_xdp_flush,
>  };
[...]


> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
> index 67d1a3230773..178ab6e8e3c5 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/iommu.h>
> +#include <linux/bpf.h>
>  #include "q_struct.h"
>  
>  #define MAX_QUEUE_SET			128
> @@ -92,6 +93,9 @@
>  #define RCV_FRAG_LEN	 (SKB_DATA_ALIGN(DMA_BUFFER_LEN + NET_SKB_PAD) + \
>  			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>  
> +#define RCV_BUF_HEADROOM	128 /* To store dma address for XDP redirect */
> +#define XDP_HEADROOM		(XDP_PACKET_HEADROOM + RCV_BUF_HEADROOM)
> +
>  #define MAX_CQES_FOR_TX		((SND_QUEUE_LEN / MIN_SQ_DESC_PER_PKT_XMIT) * \
>  				 MAX_CQE_PER_PKT_XMIT)
>  



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

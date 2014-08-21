From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Thu, 21 Aug 2014 23:43:38 +0200
Subject: [PATCH v4 2/2] net: moxa: replace build_skb() with
 netdev_alloc_skb_ip_align() / memcpy()
In-Reply-To: <1408459784-9385-2-git-send-email-jonas.jensen@gmail.com>
References: <1408459784-9385-1-git-send-email-jonas.jensen@gmail.com>
 <1408459784-9385-2-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CAHXqBFJ3bWW8NVYcjxLnkk=6qxcRv75iCuBLrHuF91wxcL=61g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-08-19 16:49 GMT+02:00 Jonas Jensen <jonas.jensen@gmail.com>:
[...]
> diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
> index aa45607..17c9f0e 100644
> --- a/drivers/net/ethernet/moxa/moxart_ether.c
> +++ b/drivers/net/ethernet/moxa/moxart_ether.c
> @@ -226,14 +226,21 @@ static int moxart_rx_poll(struct napi_struct *napi, int budget)
>                 if (len > RX_BUF_SIZE)
>                         len = RX_BUF_SIZE;
>
> -               skb = build_skb(priv->rx_buf[rx_head], priv->rx_buf_size);
> +               dma_sync_single_for_cpu(&ndev->dev,
> +                                       priv->rx_mapping[rx_head],
> +                                       priv->rx_buf_size, DMA_FROM_DEVICE);
> +               skb = netdev_alloc_skb_ip_align(ndev, len);
>                 if (unlikely(!skb)) {
> -                       net_dbg_ratelimited("build_skb failed\n");
> +                       net_dbg_ratelimited("netdev_alloc_skb_ip_align failed\n");
>                         priv->stats.rx_dropped++;
>                         priv->stats.rx_errors++;
>                 }
> -
> +               memcpy(skb->data, priv->rx_buf[rx_head], len);

This has implicit: if (!skb) BUG(); There should probably be a return
or continue inside the if (!skb).

>                 skb_put(skb, len);
> +               dma_sync_single_for_device(&ndev->dev,
> +                                          priv->rx_mapping[rx_head],
> +                                          priv->rx_buf_size, DMA_FROM_DEVICE);
> +

dma_sync_single_for_device() is not needed here as CPU does not and
should not write to the DMA_FROM_DEVICE mapping.


>                 skb->protocol = eth_type_trans(skb, ndev);
>                 napi_gro_receive(&priv->napi, skb);
>                 rx++;

Best Regards,
Micha? Miros?aw

From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Sun, 22 Nov 2015 09:19:55 +0000
Subject: [PATCH V3 net-next 1/5] net:hns: Add support of Hip06 SoC to the
 Hislicon Network Subsystem
In-Reply-To: <1447966706-16219-2-git-send-email-salil.mehta@huawei.com>
References: <1447966706-16219-1-git-send-email-salil.mehta@huawei.com>
 <1447966706-16219-2-git-send-email-salil.mehta@huawei.com>
Message-ID: <CO2PR11MB0088145308CE8BF0C504C9C497180@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +void hns_rcbv2_int_ctrl_hw(struct hnae_queue *q, u32 flag, u32 mask)
> +{
> +	u32 int_mask_en = !!mask;
> +
> +	if (flag & RCB_INT_FLAG_TX)
> +		dsaf_write_dev(q, RCB_RING_INTMSK_TXWL_REG,
> int_mask_en);
> +
> +	if (flag & RCB_INT_FLAG_RX)
> +		dsaf_write_dev(q, RCB_RING_INTMSK_RXWL_REG,
> int_mask_en);
> +}
> +
> +void hns_rcbv2_int_clr_hw(struct hnae_queue *q, u32 flag)
> +{
> +	u32 clr = 1;
> +
> +	if (flag & RCB_INT_FLAG_TX)
> +		dsaf_write_dev(q, RCBV2_TX_RING_INT_STS_REG, clr);
> +
> +	if (flag & RCB_INT_FLAG_RX)
> +		dsaf_write_dev(q, RCBV2_RX_RING_INT_STS_REG, clr);
> +}
> +

Why do you need the int_mask_en, clr variables? Why not directly use values?

> +static void fill_v2_desc(struct hnae_ring *ring, void *priv,
....
> +	hnae_set_field(bn_pid, 0x7, 0, buf_num - 1);

Magic values?

> +int hns_nic_net_xmit_hw(struct net_device *ndev,
> +			struct sk_buff *skb,
> +			struct hns_nic_ring_data *ring_data)
> +{

> -	/* If everything has gone correctly network should be the
> +	/**
> +	 * If everything has gone correctly network should be the
>  	 * data section of the packet and will be the end of the header.
>  	 * If not then it probably represents the end of the last recognized
>  	 * header.

What happened to the network style comments?

>  static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
>  			       struct sk_buff **out_skb, int *out_bnum)
> +	/**
> +	 * we will be copying header into skb->data in
> +	 * pskb_may_pull so it is in our interest to prefetch
> +	 * it now to avoid a possible cache miss
> +	 */
> +	prefetchw(skb->data);
> +

Likewise

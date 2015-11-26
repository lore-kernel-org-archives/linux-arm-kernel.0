From: salil.mehta@huawei.com (Salil Mehta)
Date: Thu, 26 Nov 2015 07:44:25 +0000
Subject: [PATCH V3 net-next 1/5] net:hns: Add support of Hip06 SoC to
 the Hislicon Network Subsystem
In-Reply-To: <CO2PR11MB0088145308CE8BF0C504C9C497180@CO2PR11MB0088.namprd11.prod.outlook.com>
References: <1447966706-16219-1-git-send-email-salil.mehta@huawei.com>
 <1447966706-16219-2-git-send-email-salil.mehta@huawei.com>
 <CO2PR11MB0088145308CE8BF0C504C9C497180@CO2PR11MB0088.namprd11.prod.outlook.com>
Message-ID: <5656B859.7010106@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/22/2015 9:19 AM, Yuval Mintz wrote:
>> +void hns_rcbv2_int_ctrl_hw(struct hnae_queue *q, u32 flag, u32 mask)
>> +{
>> +	u32 int_mask_en = !!mask;
>> +
>> +	if (flag & RCB_INT_FLAG_TX)
>> +		dsaf_write_dev(q, RCB_RING_INTMSK_TXWL_REG,
>> int_mask_en);
>> +
>> +	if (flag & RCB_INT_FLAG_RX)
>> +		dsaf_write_dev(q, RCB_RING_INTMSK_RXWL_REG,
>> int_mask_en);
>> +}
>> +
>> +void hns_rcbv2_int_clr_hw(struct hnae_queue *q, u32 flag)
>> +{
>> +	u32 clr = 1;
>> +
>> +	if (flag & RCB_INT_FLAG_TX)
>> +		dsaf_write_dev(q, RCBV2_TX_RING_INT_STS_REG, clr);
>> +
>> +	if (flag & RCB_INT_FLAG_RX)
>> +		dsaf_write_dev(q, RCBV2_RX_RING_INT_STS_REG, clr);
>> +}
>> +
> Why do you need the int_mask_en, clr variables? Why not directly use values?
'clr' variable can be avoided and is kind of redundant as it always 
holds the
same value. This chnage is now part of latest floated PATCH V5.

Purpose of the mask is coming from the previous/legacy
SoC Hip05 where operation is done on the basis of RX or TX direction.
This mask does not seem very useful for now but we would like to take
this change in future, if there is not any API's using this kind of 
interface.
-Salil
>
>> +static void fill_v2_desc(struct hnae_ring *ring, void *priv,
> ....
>> +	hnae_set_field(bn_pid, 0x7, 0, buf_num - 1);
> Magic values?
Changed to macro in PATCH V5. Thanks!
-Salil
>
>> +int hns_nic_net_xmit_hw(struct net_device *ndev,
>> +			struct sk_buff *skb,
>> +			struct hns_nic_ring_data *ring_data)
>> +{
>> -	/* If everything has gone correctly network should be the
>> +	/**
>> +	 * If everything has gone correctly network should be the
>>   	 * data section of the packet and will be the end of the header.
>>   	 * If not then it probably represents the end of the last recognized
>>   	 * header.
> What happened to the network style comments?
Fixed this in PATCH V5. Thanks !!
-Salil
>
>>   static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
>>   			       struct sk_buff **out_skb, int *out_bnum)
>> +	/**
>> +	 * we will be copying header into skb->data in
>> +	 * pskb_may_pull so it is in our interest to prefetch
>> +	 * it now to avoid a possible cache miss
>> +	 */
>> +	prefetchw(skb->data);
>> +
> Likewise
Fixed this in PATCH V5. Thanks !!
-Salil
>

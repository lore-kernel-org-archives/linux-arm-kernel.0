From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 15 Jan 2015 10:56:06 +0800
Subject: [PATCH net-next v13 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1421222782.2847.1.camel@perches.com>
References: <1421217254-12008-1-git-send-email-dingtianhong@huawei.com>	
 <1421217254-12008-4-git-send-email-dingtianhong@huawei.com>
 <1421222782.2847.1.camel@perches.com>
Message-ID: <54B72C46.5070601@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/14 16:06, Joe Perches wrote:
> On Wed, 2015-01-14 at 14:34 +0800, Ding Tianhong wrote:
>> Support Hisilicon hip04 ethernet driver, including 100M / 1000M controller.
>> The controller has no tx done interrupt, reclaim xmitted buffer in the poll.
> 
> Single comment:
> 
>> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> []
>> +static int hip04_rx_poll(struct napi_struct *napi, int budget)
>> +{
> []
>> +	while (cnt && !last) {
>> +		buf = priv->rx_buf[priv->rx_head];
>> +		skb = build_skb(buf, priv->rx_buf_size);
>> +		if (unlikely(!skb))
>> +			net_dbg_ratelimited("build_skb failed\n");
>> +
>> +		dma_unmap_single(&ndev->dev, priv->rx_phys[priv->rx_head],
>> +				 RX_BUF_SIZE, DMA_FROM_DEVICE);
>> +		priv->rx_phys[priv->rx_head] = 0;
>> +
>> +		desc = (struct rx_desc *)skb->data;
> 
> Perhaps if (!skb) is possible, there shouldn't be
> a dereference of that known null here.
> 
Yes, we should return and do something to avoid oops, thanks.

Ding

> 
> 
> .
> 

From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 28 May 2014 14:09:04 +0800
Subject: [PATCH v2 2/2] net: hisilicon: add hix5hd2 mac driver
In-Reply-To: <20140527135727.GC6969@leverpostej>
References: <1401194667-14445-1-git-send-email-zhangfei.gao@linaro.org>
 <1401194667-14445-3-git-send-email-zhangfei.gao@linaro.org>
 <20140527135727.GC6969@leverpostej>
Message-ID: <53857D80.50806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/27/2014 09:57 PM, Mark Rutland wrote:
> On Tue, May 27, 2014 at 01:44:27PM +0100, Zhangfei Gao wrote:
>> Add support for the hix5hd2 XGMAC 1Gb ethernet device.
>> The controller requires two queues for tx and two queues for rx.
>> Controller fetch buffer from free queue and then push to used queue.
>> Diver should prepare free queue and free buffer from used queue.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/net/ethernet/Kconfig                  |    1 +
>>   drivers/net/ethernet/Makefile                 |    1 +
>>   drivers/net/ethernet/hisilicon/Kconfig        |   27 +
>>   drivers/net/ethernet/hisilicon/Makefile       |    5 +
>>   drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 1057 +++++++++++++++++++++++++
>>   5 files changed, 1091 insertions(+)
>>   create mode 100644 drivers/net/ethernet/hisilicon/Kconfig
>>   create mode 100644 drivers/net/ethernet/hisilicon/Makefile
>>   create mode 100644 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
>
> [...]
>
>> +struct hix5hd2_desc {
>> +       __le32 buff_addr;
>> +       __le32 cmd;
>> +} __aligned(32);
>
> [...]
>
>> +static void hix5hd2_rx_refill(struct hix5hd2_priv *priv)
>> +{
>> +       struct hix5hd2_desc *desc;
>> +       struct sk_buff *skb;
>> +       u32 start, end, num, pos, i;
>> +
>> +       /* software write pointer */
>> +       start = dma_cnt(readl_relaxed(priv->base + RX_FQ_WR_ADDR));
>> +       /* logic read pointer */
>> +       end = dma_cnt(readl_relaxed(priv->base + RX_FQ_RD_ADDR));
>> +       num = CIRC_SPACE(start, end, RX_DESC_NUM);
>> +
>> +       for (i = 0, pos = start; i < num; i++) {
>> +               if (priv->rx_skb[pos])
>> +                       break;
>> +               else {
>> +                       skb = netdev_alloc_skb_ip_align(priv->netdev,
>> +                               MAC_MAX_FRAME_SIZE);
>> +                       if (unlikely(skb == NULL))
>> +                               break;
>> +               }
>> +
>> +               desc = priv->rx_fq.desc + pos;
>> +               desc->buff_addr =
>> +                       dma_map_single(priv->dev, skb->data,
>> +                                       MAC_MAX_FRAME_SIZE, DMA_FROM_DEVICE);
>
> buff_addr was declared as an __le32, but here we're pasting values of
> the kernel's native endianness (which might not be little). You will
> need to carefully convert the endianness of this value when dealing with
> it.
>
>> +               if (dma_mapping_error(priv->dev, desc->buff_addr)) {
>> +                       dev_kfree_skb_any(skb);
>> +                       break;
>> +               }
>> +
>> +               priv->rx_skb[pos] = skb;
>> +               desc->cmd = (MAC_MAX_FRAME_SIZE - 1) | DESC_VLD_FREE;
>
> Likewise cmd was described as an __le32 and needs to be converted
> appropriately.
>

Got it, will use le32_to_cpu & cpu_to_le32 for the conversion.
Thanks for the info.

From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 27 May 2014 11:57:52 +0800
Subject: [PATCH 3/3] net: hisilicon: add hix5hd2 mac driver
In-Reply-To: <201405261651.15998.arnd@arndb.de>
References: <1400504227-12047-1-git-send-email-zhangfei.gao@linaro.org>
 <1400504227-12047-4-git-send-email-zhangfei.gao@linaro.org>
 <201405261651.15998.arnd@arndb.de>
Message-ID: <53840D40.3000600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the kind suggestions.

On 05/26/2014 10:51 PM, Arnd Bergmann wrote:
> On Monday 19 May 2014, Zhangfei Gao wrote:
>
> I only noticed one real issue with the driver:
>
>> +struct hix5hd2_desc {
>> +	__le32 buff_addr;
>> +	__le32 buff_len:11;
>> +	__le32 reserve2:5;
>> +	__le32 data_len:11;
>> +	__le32 reserve1:2;
>> +	__le32 fl:2;
>> +	__le32 descvid:1;
>> +} __aligned(32);
>> +
>
> You should generall not use bitfields in hardware data structures, as that is
> not endian safe and will prevent running a big-endian kernel on this machine.
> Better convert this to a set of __le32 fields and explicit shifts and masks.

Got it, will update.

More knowledge about big-endian kernel is appreciated, in which case we 
should consider such kernel.
Can we only consider this driver is only running on arm, which is 
little-endian.

>
> Two smaller things you should think about, I'm not entirely sure about these:
>
>> +static int hix5hd2_rx(struct net_device *dev, int limit)
>> +{
>> +	struct hix5hd2_priv *priv = netdev_priv(dev);
>> +	struct sk_buff *skb;
>> +	struct hix5hd2_desc *desc;
>> +	dma_addr_t dma_addr;
>> +	u32 start, end, num, pos, i, len;
>> +
>> +	/* software read pointer */
>> +	start = dma_cnt(readl_relaxed(priv->base + RX_BQ_RD_ADDR));
>> +	/* logic write pointer */
>> +	end = dma_cnt(readl_relaxed(priv->base + RX_BQ_WR_ADDR));
>
> I think one of these needs to be readl() instead of readl_relaxed(),
> to ensure the data is correctly ordered with regard to the pointer
> access.
readl_relaxed can ensure the sequence.

>
>> +	if (pos != start)
>> +		writel(dma_byte(pos), priv->base + TX_RQ_RD_ADDR);
>
> While this looks like it could be writel_relaxed().
>
En, I think all three cases can use xxx_relaxed.
These accesses are just update pointer used by internal logic and get 
pointer updated by internal logic.

Thanks

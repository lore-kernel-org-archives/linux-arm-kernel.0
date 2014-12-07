From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 7 Dec 2014 11:28:55 +0800
Subject: [PATCH v8 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <5483A279.5000503@suse.de>
References: <1397869980-21187-1-git-send-email-zhangfei.gao@linaro.org>
 <1397869980-21187-4-git-send-email-zhangfei.gao@linaro.org>
 <5483A279.5000503@suse.de>
Message-ID: <5483C977.2060308@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/7 8:42, Alexander Graf wrote:
> On 19.04.14 03:13, Zhangfei Gao wrote:
>> Support Hisilicon hip04 ethernet driver, including 100M / 1000M controller.
>> The controller has no tx done interrupt, reclaim xmitted buffer in the poll.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Is this driver still supposed to go upstream? I presume this was the
> last submission and it's been quite some time ago :)
> 

yes, it is really a long time, but The hip04 did not support tx irq, 
we couldn't get any better idea to fix this defect, do you have any suggestion?

Regards
Ding

>> ---
>>  drivers/net/ethernet/hisilicon/Makefile    |    2 +-
>>  drivers/net/ethernet/hisilicon/hip04_eth.c |  846 ++++++++++++++++++++++++++++
>>  2 files changed, 847 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/net/ethernet/hisilicon/hip04_eth.c
>>
>> diff --git a/drivers/net/ethernet/hisilicon/Makefile b/drivers/net/ethernet/hisilicon/Makefile
>> index 1d6eb6e..17dec03 100644
> 
> [...]
> 
>> +static irqreturn_t hip04_mac_interrupt(int irq, void *dev_id)
>> +{
>> +	struct net_device *ndev = (struct net_device *) dev_id;
>> +	struct hip04_priv *priv = netdev_priv(ndev);
>> +	struct net_device_stats *stats = &ndev->stats;
>> +	u32 ists = readl_relaxed(priv->base + PPE_INTSTS);
>> +
>> +	writel_relaxed(DEF_INT_MASK, priv->base + PPE_RINT);
>> +
>> +	if (unlikely(ists & DEF_INT_ERR)) {
>> +		if (ists & (RCV_NOBUF | RCV_DROP))
>> +			stats->rx_errors++;
>> +			stats->rx_dropped++;
>> +			netdev_err(ndev, "rx drop\n");
> 
> Why would a user want to see this as a dmesg error? We already have
> stats for packet drops, no?
> 
>> +		if (ists & TX_DROP) {
>> +			stats->tx_dropped++;
>> +			netdev_err(ndev, "tx drop\n");
> 
> Same here.
> 
>> +		}
>> +	}
>> +
>> +	if (ists & RCV_INT) {
>> +		/* disable rx interrupt */
>> +		priv->reg_inten &= ~(RCV_INT);
>> +		writel_relaxed(priv->reg_inten, priv->base + PPE_INTEN);
>> +		napi_schedule(&priv->napi);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> [...]
> 
>> +
>> +static const struct of_device_id hip04_mac_match[] = {
>> +	{ .compatible = "hisilicon,hip04-mac" },
>> +	{ }
>> +};
> 
> This is missing the magic macro that actually would make module aliases
> work.
> 
> 
> Alex
> 
>> +
>> +static struct platform_driver hip04_mac_driver = {
>> +	.probe	= hip04_mac_probe,
>> +	.remove	= hip04_remove,
>> +	.driver	= {
>> +		.name		= DRV_NAME,
>> +		.owner		= THIS_MODULE,
>> +		.of_match_table	= hip04_mac_match,
>> +	},
>> +};
>> +module_platform_driver(hip04_mac_driver);
>> +
>> +MODULE_DESCRIPTION("HISILICON P04 Ethernet driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:hip04-ether");
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

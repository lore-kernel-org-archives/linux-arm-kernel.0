From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 30 Mar 2016 13:51:13 +0300
Subject: [PATCH net-next] net: hns: add support of pause frame ctrl for
 HNS V2
In-Reply-To: <1459235041-91766-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1459235041-91766-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1459335073.5907.34.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-29 at 15:04 +0800, Yisen Zhuang wrote:
> From: Lisheng <lisheng011@huawei.com>
> 
> The patch adds support of pause ctrl for HNS V2, and this feature is
> lost
> by HNS V1:
> ???????1) service ports can disable rx pause frame,
> ???????2) debug ports can open tx/rx pause frame.
> 
> And this patch updates the REGs about the pause ctrl when updated
> status function called by upper layer routine.

> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
> 

> +void hns_dsaf_get_rx_mac_pause_en(struct dsaf_device *dsaf_dev, int
> mac_id,
> +				??u32 *en)
> +{
> +	if (AE_IS_VER1(dsaf_dev->dsaf_ver))
> +		*en = 1;
> ?	else
> ?		dsaf_write_dev(dsaf_dev, DSAF_PFC_EN_0_REG + mac_id
> * 4, 0xff);
> +		*en = dsaf_get_dev_bit(dsaf_dev,
> +				???????DSAF_PAUSE_CFG_REG + mac_id *
> 4,
> +				???????DSAF_MAC_PAUSE_RX_EN_B);

And what the point of if branch then? I think it's an obvious misfix,
you must replace else to } else { and add }.

How did you test this part?

> ?}


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

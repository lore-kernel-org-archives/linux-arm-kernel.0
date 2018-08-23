From: zhongjiang@huawei.com (zhong jiang)
Date: Thu, 23 Aug 2018 19:44:38 +0800
Subject: [PATCH] arm: pm: call put_device instead of of_node_put in
 at91_pm_config_ws
In-Reply-To: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
References: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <5B7E9E26.3050209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, alexandre

Can you pick up the patch?  Thanks

Best wishes,
zhong jiang

On 2018/8/16 18:26, zhong jiang wrote:
> of_find_device_by_node takes a reference to the struct device when it
> finds a match via get_device. but it fails to put_device in
> at91_pm_config_ws, for_each_matching_node_and_match will get and put
> the node properly, there is no need to call the of_put_node. Therefore,
> just call put_device instead of of_node_put in at91_pm_config_ws.
>
> Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
> Suggested-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm/mach-at91/pm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 32fae4d..6574f00 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -143,15 +143,15 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>  
>  			/* Check if enabled on SHDWC. */
>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
> -				goto put_node;
> +				goto put_device;
>  
>  			mode |= wsi->pmc_fsmr_bit;
>  			if (wsi->set_polarity)
>  				polarity |= wsi->pmc_fsmr_bit;
>  		}
>  
> -put_node:
> -		of_node_put(np);
> +put_device:
> +		put_device(&pdev->dev);
>  	}
>  
>  	if (mode) {

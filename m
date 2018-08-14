From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 14 Aug 2018 14:59:54 +0200
Subject: [PATCH] arm/mach-at91/pm: Do not double put the device node
In-Reply-To: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
References: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20180814125954.GM943@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/2018 09:54:56+0800, zhong jiang wrote:
> Device node iterators put the previous value of the index variable,
> so an explicit put causes a double put.
> 

While for_each_matching_node_and_match will get and put the node
properly, there is also a call to of_find_device_by_node that will get a
reference to the node.

> I detect the issue with the help of Coccinelle.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm/mach-at91/pm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 32fae4d..a5ec35f 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -143,15 +143,12 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>  
>  			/* Check if enabled on SHDWC. */
>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
> -				goto put_node;
> +				continue;
>  
>  			mode |= wsi->pmc_fsmr_bit;
>  			if (wsi->set_polarity)
>  				polarity |= wsi->pmc_fsmr_bit;
>  		}
> -
> -put_node:
> -		of_node_put(np);
>  	}
>  
>  	if (mode) {
> -- 
> 1.7.12.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

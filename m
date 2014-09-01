From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Sep 2014 10:05:13 +0200
Subject: [PATCH] ARM: at91: fix ramc standby function registration
In-Reply-To: <1409155611-7574-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1409155611-7574-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <540428B9.4070400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2014 18:06, Alexandre Belloni :
> After the for_each_matching_node loop, we end up with a null value for np. Then,
> of_match_node() is not matching anything and we can't register the standby
> function and "ramc no standby function available" is printed.
> 
> Fix that by selecting the first available standby function. For now,
> at91_pm_set_standby doesn't support multiple different standby functions and no
> existing SoCs have different RAM controllers.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

That makes sense for now.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/setup.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 28ae63b8eb16..d2cade21ebd7 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -343,25 +343,28 @@ static void at91_dt_ramc(void)
>  	struct device_node *np;
>  	const struct of_device_id *of_id;
>  	int idx = 0;
> +	const void *standby = NULL;
>  
> -	for_each_matching_node(np, ramc_ids) {
> +	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
>  		at91_ramc_base[idx] = of_iomap(np, 0);
>  		if (!at91_ramc_base[idx])
>  			panic(pr_fmt("unable to map ramc[%d] cpu registers\n"), idx);
>  
> +		if (!standby)
> +			standby = of_id->data;
> +
>  		idx++;
>  	}
>  
>  	if (!idx)
>  		panic(pr_fmt("unable to find compatible ram controller node in dtb\n"));
>  
> -	of_id = of_match_node(ramc_ids, np);
> -	if (!of_id) {
> +	if (!standby) {
>  		pr_warn("ramc no standby function available\n");
>  		return;
>  	}
>  
> -	at91_pm_set_standby(of_id->data);
> +	at91_pm_set_standby(standby);
>  }
>  
>  void __init at91rm9200_dt_initialize(void)
> 


-- 
Nicolas Ferre

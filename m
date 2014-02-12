From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Feb 2014 11:45:15 +0100
Subject: [PATCH v4 1/8] at91: dt: Adds support for the bus matrix
 declaration in the DT
In-Reply-To: <1392199607-27452-2-git-send-email-jjhiblot@traphandler.com>
References: <1392199607-27452-1-git-send-email-jjhiblot@traphandler.com>
 <1392199607-27452-2-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52FB50BB.5070603@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Jacques,

Thanks for this new series, I have one little comment:

On 12/02/2014 11:06, Jean-Jacques Hiblot wrote:
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  arch/arm/mach-at91/setup.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index f7ca97b..b8d0b66 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -487,6 +487,28 @@ end:
>  	of_node_put(np);
>  }
>  
> +static struct of_device_id matrix_ids[] = {
> +	{ .compatible = "atmel,at91sam9261-bus-matrix", },
> +	{ /*sentinel*/ }
> +};
> +
> +static void at91_dt_matrix(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, matrix_ids);
> +	if (!np) {
> +		pr_debug("AT91: unable to find compatible bus matrix controller node in dtb\n");

I think that a panic here should be more consistent with the next check.
Indeed if it fails here then at91_matrix_base will be uninitialized too,
and it will make the kernel crash when at91_matrix_base will be accessed.

Thanks,

Gregory


> +		return;
> +	}
> +
> +	at91_matrix_base = of_iomap(np, 0);
> +	if (!at91_matrix_base)
> +		panic("Impossible to ioremap at91_matrix_base\n");
> +
> +	of_node_put(np);
> +}
> +
>  void __init at91rm9200_dt_initialize(void)
>  {
>  	at91_dt_ramc();
> @@ -506,6 +528,7 @@ void __init at91_dt_initialize(void)
>  	at91_dt_rstc();
>  	at91_dt_ramc();
>  	at91_dt_shdwc();
> +	at91_dt_matrix();
>  
>  	/* Init clock subsystem */
>  	at91_dt_clock_init();
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

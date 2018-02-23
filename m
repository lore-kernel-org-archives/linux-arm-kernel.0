From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 23 Feb 2018 15:54:23 +0100
Subject: [PATCH v4 01/10] ARM: sun9i: smp: Add sun9i dt parsing function
In-Reply-To: <20180223133742.26044-2-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-2-mylene.josserand@bootlin.com>
Message-ID: <20180223145423.5og5bdhtznu5qlw7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 23, 2018 at 02:37:33PM +0100, Myl?ne Josserand wrote:
> To prepare the support for sun8i-a83t, create a new function
> that handles all the resources needed on sun9i-a80 (because
> it will be different from sun8i-a83t).
> 
> All the parsing of device tree is moved into this new function:
> sun9i_dt_parsing. Create also a function to release the resources
> retrieved during the dt parsing in case there is an error in init
> function.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 99 ++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 11e46c6efb90..650a2ad4398f 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -684,35 +684,22 @@ static int __init sunxi_mc_smp_lookback(void)
>  	return ret;
>  }
>  
> -static int __init sunxi_mc_smp_init(void)
> +static int sun9i_dt_parsing(struct resource res)

Like I told you in the previous version, this should be _parse_dt, and
not _dt_parsing.

Also, I'm not sure why you are passing by copy the resource structure?

>  {
> -	struct device_node *cpucfg_node, *sram_node, *node;
> -	struct resource res;
> +	struct device_node *prcm_node, *cpucfg_node, *sram_node;
>  	int ret;
>  
> -	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
> -		return -ENODEV;
> -
> -	if (!sunxi_mc_smp_cpu_table_init())
> -		return -EINVAL;
> -
> -	if (!cci_probed()) {
> -		pr_err("%s: CCI-400 not available\n", __func__);
> -		return -ENODEV;
> -	}
> -
> -	node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
> -	if (!node) {
> -		pr_err("%s: PRCM not available\n", __func__);
> +	prcm_node = of_find_compatible_node(NULL, NULL,
> +				       "allwinner,sun9i-a80-prcm");
> +	if (!prcm_node)
>  		return -ENODEV;
> -	}
>  
>  	/*
>  	 * Unfortunately we can not request the I/O region for the PRCM.
>  	 * It is shared with the PRCM clock.
>  	 */
> -	prcm_base = of_iomap(node, 0);
> -	of_node_put(node);
> +	prcm_base = of_iomap(prcm_node, 0);

So it does more a bit more than just parsing the DT?

Can you maybe just fill the DT nodes and have the common part map the
memory regions if the pointer is not NULL?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180223/3898813c/attachment.sig>

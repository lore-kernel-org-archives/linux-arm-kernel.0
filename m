From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 11:49:56 +0000
Subject: [PATCH 6/7] pm: at91: add achieve the mpddrc peripheral ID and
 the DDR clock ID support
In-Reply-To: <1422266896-24666-1-git-send-email-wenyou.yang@atmel.com>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
 <1422266896-24666-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150126114956.GE23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 10:08:16AM +0000, Wenyou Yang wrote:
> The patch achieves the mpddr controller peripheral ID
> and the DDR clock ID from the dts file.
> 
> They will be used in the future to disable the mpddr controller'c clock
> the and DDR clock to decrease the power consumption during suspending.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  arch/arm/mach-at91/generic.h |    2 ++
>  arch/arm/mach-at91/setup.c   |   24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index 41796bf..3c72a3e 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -47,6 +47,8 @@ void __init at91_sam9x5_pm_init(void) { }
>  struct at91_pm_struct {
>  	unsigned long uhp_udp_mask;
>  	int memctrl;
> +	u32 mpddrc_id[2];
> +	u32 ddrck_id;
>  };
>  
>  #endif /* _AT91_GENERIC_H */
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 7924663..a306f95 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -363,6 +363,27 @@ void __init at91_ioremap_matrix(u32 base_addr)
>  		panic(pr_fmt("Impossible to ioremap at91_matrix_base\n"));
>  }
>  
> +static u32 at91_of_get_ddr_id(struct device_node *np, char *name)
> +{
> +	struct of_phandle_args clkspec;
> +	u32 id;
> +	int index;
> +	int rc;
> +
> +	index = of_property_match_string(np, "clock-names", name);
> +	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index, &clkspec);
> +	if (rc)
> +		return 0;
> +
> +	rc = of_property_read_u32(clkspec.np, "reg", &id);
> +	if (rc)
> +		return 0;
> +
> +	of_node_put(clkspec.np);
> +
> +	return id;
> +}

This doesn't look right to me. This assumes the format of the clock
provider node, which invalidates the point of having the abstraction in
the first place.

> +
>  struct at91_ramc_of_data {
>  	u8 ramc_type;
>  };
> @@ -400,6 +421,9 @@ static void at91_dt_ramc(void)
>  		of_data = of_id->data;
>  		at91_pm_data.memctrl = of_data->ramc_type;
>  
> +		at91_pm_data.mpddrc_id[idx] = at91_of_get_ddr_id(np, "mpddr");
> +		at91_pm_data.ddrck_id = at91_of_get_ddr_id(np, "ddrck");
> +

Why do you need these here?

Surely the logic for poking any clocks should live in the relevant
clock controller drivers?

Mark.

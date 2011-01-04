From: nm@ti.com (Nishanth Menon)
Date: Tue, 04 Jan 2011 12:46:19 -0600
Subject: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined
	reference'
In-Reply-To: <1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4D236AFB.2050301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the following:
[..]

> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index 710f4ea..c095351 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -65,9 +65,6 @@ struct voltagedomain {
>  	char *name;
>  };
>  
> -/* API to get the voltagedomain pointer */
> -struct voltagedomain *omap_voltage_domain_lookup(char *name);
> -
>  /**
>   * struct omap_volt_data - Omap voltage specific data.
>   * @voltage_nominal:	The possible voltage value in uV
> @@ -131,6 +128,9 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>  		struct omap_volt_pmic_info *pmic_info);
>  void omap_change_voltscale_method(struct voltagedomain *voltdm,
>  		int voltscale_method);
> +/* API to get the voltagedomain pointer */
> +struct voltagedomain *omap_voltage_domain_lookup(char *name);
> +
>  int omap_voltage_late_init(void);
>  #else
>  static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
> @@ -144,6 +144,10 @@ static inline int omap_voltage_late_init(void)
>  {
>  	return -EINVAL;
>  }
> +static inline struct voltagedomain *omap_voltage_domain_lookup(char *name)
> +{
> +	return NULL;
the omap_voltage_domain_lookup uses ERR_PTR() for all return values 
which are handled by the callers with IS_ERR()

I think you should return ERR_PTR(-EINVAL)

-- 
Regards,
Nishanth Menon

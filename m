From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Dec 2017 07:04:57 -0800
Subject: [PATCH 06/12] mmc: sdhci_omap: Add support to set IODELAY values
In-Reply-To: <20171214130941.26666-7-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-7-kishon@ti.com>
Message-ID: <20171214150457.GH14441@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Kishon Vijay Abraham I <kishon@ti.com> [171214 13:13]:
> The data manual of J6/J6 Eco recommends to set different IODELAY values
> depending on the mode in which the MMC/SD is enumerated in order to
> ensure IO timings are met.
> 
> Add support to set the IODELAY values depending on the various MMC
> modes using the pinctrl APIs.
...

> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -105,6 +109,20 @@ struct sdhci_omap_host {
>  	struct sdhci_host	*host;
>  	u8			bus_mode;
>  	u8			power_mode;
> +	u8			timing;
> +	u8			flags;
> +
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pinctrl_state;
> +	struct pinctrl_state	*default_pinctrl_state;
> +	struct pinctrl_state	*sdr104_pinctrl_state;
> +	struct pinctrl_state	*hs200_1_8v_pinctrl_state;
> +	struct pinctrl_state	*ddr50_pinctrl_state;
> +	struct pinctrl_state	*sdr50_pinctrl_state;
> +	struct pinctrl_state	*sdr25_pinctrl_state;
> +	struct pinctrl_state	*sdr12_pinctrl_state;
> +	struct pinctrl_state	*hs_pinctrl_state;
> +	struct pinctrl_state	*ddr_1_8v_pinctrl_state;
>  };


You can make the pinctrl code more generic by allocating an array
of states and have just:

	struct pinctrl_state **pinctrl_state;

Then access it with omap_host->pinctrl_state[MMC_TIMING_MMC_HS200]
and so on.

This way the code gets simplified and you can do a generic function
to initialize things and call it from a for loop etc.

Just remember that pinctrl use can be optional as the pins can be
set up in the bootloader alone. Then you can just continue with the
default iodelay state like we are currently doing.

Regards,

Tony

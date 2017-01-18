From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 14:32:37 +0530
Subject: [PATCH v2 06/14] ARM: davinci: da850: model the SATA refclk
In-Reply-To: <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <ff3b3949-1f48-f176-2b06-b9a4c14e6ffa@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 January 2017 05:56 PM, Bartosz Golaszewski wrote:
> Register a dummy clock modelling the external SATA oscillator for

I would not call it a dummy clock. Its representing something physically
present. Just call it "fixed rate clock" ?

> da850 DT mode. For non-DT boot we don't register the clock - instead
> we rely on the default MPY value defined in the da850 ahci driver (as
> is done currently).

Here too, like David suggested, it will be nice to register it both for
DT and non-DT case. With that I think your driver will be simple too
since you dont have to worry about the case when refclkpn is not supplied.

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da8xx-dt.c           |  8 ++++++++
>  arch/arm/mach-davinci/devices-da8xx.c      | 23 +++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index b83e5d1..13137cb 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -61,6 +61,14 @@ static void __init da850_init_machine(void)
>  		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
>  			__func__, ret);
>  
> +	if (of_machine_is_compatible("ti,da850-evm") ||
> +	    of_machine_is_compatible("ti,da850-lcdk")) {
> +		ret = da850_register_sata_refclk(100000000);
> +		if (ret)
> +			pr_warn("%s: registering SATA_REFCLK clock failed: %d",
> +				__func__, ret);
> +	}

Since all supported boards use 100 Mhz refclk anyway, I would drop the
machine check and just do:

	/* All existing boards use 100MHz SATA refclkpn */
	unsigned long sata_refclkpn = 100 * 1000 * 1000;

	ret = da850_register_sata_refclk(sata_refclkpn);

It should then be easy for the odd board (when it comes) to set
sata_refclkpn to a different value.

Thanks,
Sekhar

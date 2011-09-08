From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 11:07:07 -0700
Subject: [RFC PATCH 04/10] arm/dts: OMAP4: Add mpu, dsp and iva nodes
In-Reply-To: <1314191356-10963-5-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-5-git-send-email-b-cousson@ti.com>
Message-ID: <20110908180707.GD2967@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:09:10PM +0200, Benoit Cousson wrote:
> Add nodes for devices used by PM code (mpu, dsp, iva).
> 
> Add an empty cpus node as well as recommended in the DT spec.
> 
> Remove mpu, dsp, iva devices init if CONFIG_OF is defined.
> Ideally the whole function should be removed. It will be doable as
> soon as the OMAP3 DT support will be added.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |   28 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.c     |    5 ++++-
>  2 files changed, 32 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 928a74c..a3efe76 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -25,11 +25,39 @@
>  	};
>  
>  	/*
> +	 * XXX: The cpus node is mandatory, but since the CPUs are as well part
> +	 * of the mpu subsystem below, it is not clear where the information
> +	 * should be. Maybe here with a phandle inside the mpu?
> +	 */
> +	cpus {
> +	};
> +
> +	/*
>  	 * The soc node represents the soc top level view. It is uses for IPs
>  	 * that are not memory mapped in the MPU view or for the MPU itself.
>  	 */
>  	soc {
>  		compatible = "ti,omap-infra";
> +		mpu {
> +			compatible = "ti,omap4-mpu";
> +			hwmods = "mpu";
> +			cpu at 0 {
> +				compatible = "arm,cortex-a9";
> +			};
> +			cpu at 1 {
> +				compatible = "arm,cortex-a9";
> +			};
> +		};
> +
> +		dsp {
> +			compatible = "ti,omap4-c64", "ti,c64";
> +			hwmods = "dsp";
> +		};
> +
> +		iva {
> +			compatible = "ti,ivahd", "ti,iva";
> +			hwmods = "iva";
> +		};
>  	};
>  
>  	/*
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 832577a..ba4d187 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -49,15 +49,18 @@ static int _init_omap_device(char *name)
>   */
>  static void omap2_init_processor_devices(void)
>  {
> -	_init_omap_device("mpu");
>  	if (omap3_has_iva())
>  		_init_omap_device("iva");
>  
>  	if (cpu_is_omap44xx()) {
> +#ifndef CONFIG_OF
> +		_init_omap_device("mpu");
>  		_init_omap_device("l3_main_1");
>  		_init_omap_device("dsp");
>  		_init_omap_device("iva");
> +#endif

Ditto here, turning on CONFIG_OF should not be an either/or option
with ATAGs support.

>  	} else {
> +		_init_omap_device("mpu");
>  		_init_omap_device("l3_main");
>  	}
>  }
> -- 
> 1.7.0.4
> 

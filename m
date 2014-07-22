From: s-anna@ti.com (Suman Anna)
Date: Tue, 22 Jul 2014 14:01:58 -0500
Subject: [v3 PATCH 4/6] ARM: dts: am4372: Add prcm_resets node
In-Reply-To: <1405615531-15649-4-git-send-email-dmurphy@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
 <1405615531-15649-4-git-send-email-dmurphy@ti.com>
Message-ID: <53CEB526.3090101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On 07/17/2014 11:45 AM, Murphy, Dan wrote:
> Add the prcm_resets node to the prcm parent node.
> 
> Add the am34xx_resets file to define the
> am34xx reset lines that are handled by this reset
> framework.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - No changes
> 
>  arch/arm/boot/dts/am4372.dtsi        |    7 +++++
>  arch/arm/boot/dts/am43xx-resets.dtsi |   52 ++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am43xx-resets.dtsi
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 49fa596..d0aa9c9 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -88,6 +88,12 @@
>  
>  			prcm_clockdomains: clockdomains {
>  			};
> +
> +			prcm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;

Should be corrected as per comment on DT bindings.

> +				#reset-cells = <1>;
> +			};
>  		};
>  
>  		scrm: scrm at 44e10000 {
> @@ -892,3 +898,4 @@
>  };
>  
>  /include/ "am43xx-clocks.dtsi"
> +/include/ "am43xx-resets.dtsi"
> diff --git a/arch/arm/boot/dts/am43xx-resets.dtsi b/arch/arm/boot/dts/am43xx-resets.dtsi
> new file mode 100644
> index 0000000..ef338ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/am43xx-resets.dtsi
> @@ -0,0 +1,52 @@
> +/*
> + * Device Tree Source for AM43XX reset data
> + *
> + * Copyright (C) 2014 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +&prcm_resets {
> +	icss_rstctrl {
> +		reg = <0x810>,
> +			  <0x814>;
> +
> +		icss_reset: icss_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +
> +	gfx_rstctrl {
> +		reg = <0x410>,
> +			  <0x414>;
> +
> +		gfx_reset: gfx_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +
> +	per_rstctrl {
> +		reg = <0x2010>,
> +			  <0x2014>;
> +
> +		iva_reset: iva_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};

There's no IVA on AM4372. Looking at the offset, it looks like you were
defining this for the WkupM3, in which case you got the initial node
name wrong. The PER rstctrl has the reset management for PRU-ICSS, so
you also need to correct the icss_rstctrl accordingly.

regards
Suman

> +	};
> +
> +	device_rstctrl {
> +		reg = <0x4000>,
> +			  <0x4004>;
> +
> +		device_reset: device_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +
> +};
> 

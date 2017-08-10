From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 10:52:46 -0500
Subject: [PATCH v2] arm, am335x: add support for Moxa UC-8100-ME-T open
 platform
In-Reply-To: <20170802065757.1074-1-sz.lin@moxa.com>
References: <20170802065757.1074-1-sz.lin@moxa.com>
Message-ID: <20170810155246.pfaii3zb5jblluwy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 02:57:57PM +0800, SZ Lin wrote:
> Add support for Moxa UC-8100-ME-T open platform
> 
> The UC-8100-ME-T computing platform is designed
> for embedded data acquisition industrial applications
> 
> The features of UC-8100-ME-T series are:
> * eMMC
> * SPI flash
> * SD slot
> * 2x LAN
> * 2 RS-232/422/485 ports, software-selectable
> * Mini PCIe form factor with USB signal
> * USB host
> * EEPROM
> * TPM
> * Watchdog
> * RTC
> * User gpio-keys
> * User LEDs
> * User button
> 
> Signed-off-by: SZ Lin <sz.lin@moxa.com>
> ---
> Changes from v1:
> - Remove the un-needed @ in led at x's
> - Use AM33XX_IOPAD pinmux macro
> - Properly alphabetize Makefile
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     | 525 +++++++++++++++++++++
>  3 files changed, 529 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 8219b2c6bb29..72ad8700156a 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -154,6 +154,9 @@ Boards:
>  - AM335X phyCORE-AM335x: Development kit
>    compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
>  
> +- AM335X UC-8100-ME-T: Communication-centric industrial computing platform
> +  compatible = "moxa,uc-8100-me-t", "ti,am33xx";
> +
>  - OMAP5 EVM : Evaluation Module
>    compatible = "ti,omap5-evm", "ti,omap5"
>  
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4b17f35dc9a7..c293e841eea3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -617,6 +617,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>  	am335x-evmsk.dtb \
>  	am335x-icev2.dtb \
>  	am335x-lxm.dtb \
> +	am335x-moxa-uc-8100-me-t.dtb \
>  	am335x-nano.dtb \
>  	am335x-pepper.dtb \
>  	am335x-phycore-rdk.dtb \
> diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
> new file mode 100644
> index 000000000000..0aa1d10a0bed
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
> @@ -0,0 +1,525 @@
> +/*
> + * Copyright (C) 2017 MOXA Inc. - https://www.moxa.com/
> + *
> + * Author: SZ Lin (???) <sz.lin@moxa.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "am33xx.dtsi"
> +
> +/ {
> +	model = "Moxa UC-8100-ME-T";
> +	compatible = "moxa,uc-8100-me-t", "ti,am33xx";
> +
> +	cpus {
> +		cpu at 0 {
> +			cpu0-supply = <&vdd1_reg>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	vbat: fixedregulator at 0 {

Unit address without reg property is not valid (build with W=2). Perhaps 
vbat-regulator instead.

> +		compatible = "regulator-fixed";
> +	};
> +
> +	/* Power supply provides a fixed 3.3V @3A */
> +	vmmcsd_fixed: fixedregulator at 1 {

Ditto

With those fixed,

Acked-by: Rob Herring <robh@kernel.org>

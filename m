From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Jul 2012 15:20:05 +0200
Subject: [PATCH v3] ARM: at91: add support for Telit EVK-PRO3 with Telit
 GE863-PRO3
In-Reply-To: <1340788099-1117-1-git-send-email-fabio.porcedda@gmail.com>
References: <1340788099-1117-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <4FF1A005.1020706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 11:08 AM, Fabio Porcedda :
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

pushed in at91-3.6-dt branch on
git://github.com/at91linux/linux-at91.git
And replaces the v2 one...

Thanks, best regards,

> ---
>  - changes for v3
> 	- split the evk-pro3 from the ge863-pro3 to facilitate
>            the board customization
>         - add usb gadget and macb
>  - changes for v2
> 	- add empty line before the Signed-off-by line
> 
>  arch/arm/boot/dts/evk-pro3.dts    | 41 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ge863-pro3.dtsi | 52 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/Makefile.boot  |  1 +
>  3 files changed, 94 insertions(+)
>  create mode 100644 arch/arm/boot/dts/evk-pro3.dts
>  create mode 100644 arch/arm/boot/dts/ge863-pro3.dtsi
> 
> diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
> new file mode 100644
> index 0000000..b7354e6
> --- /dev/null
> +++ b/arch/arm/boot/dts/evk-pro3.dts
> @@ -0,0 +1,41 @@
> +/*
> + * evk-pro3.dts - Device Tree file for Telit EVK-PRO3 with Telit GE863-PRO3
> + *
> + * Copyright (C) 2012 Telit,
> + *               2012 Fabio Porcedda <fabio.porcedda@gmail.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +/dts-v1/;
> +
> +/include/ "ge863-pro3.dtsi"
> +
> +/ {
> +	model = "Telit EVK-PRO3 for Telit GE863-PRO3";
> +	compatible = "telit,evk-pro3", "atmel,at91sam9260", "atmel,at91sam9";
> +
> +	ahb {
> +		apb {
> +			macb0: ethernet at fffc4000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};
> +
> +			usb1: gadget at fffa4000 {
> +				atmel,vbus-gpio = <&pioC 5 0>;
> +				status = "okay";
> +			};
> +		};
> +
> +		usb0: ohci at 00500000 {
> +			num-ports = <2>;
> +			status = "okay";
> +		};
> +	};
> +
> +	i2c at 0 {
> +		status = "okay";
> +	};
> +
> +};
> \ No newline at end of file
> diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
> new file mode 100644
> index 0000000..17136fc
> --- /dev/null
> +++ b/arch/arm/boot/dts/ge863-pro3.dtsi
> @@ -0,0 +1,52 @@
> +/*
> + * ge863_pro3.dtsi - Device Tree file for Telit GE863-PRO3
> + *
> + * Copyright (C) 2012 Telit,
> + *               2012 Fabio Porcedda <fabio.porcedda@gmail.com>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +/include/ "at91sam9260.dtsi"
> +
> +/ {
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		main_clock: clock at 0 {
> +			compatible = "atmel,osc", "fixed-clock";
> +			clock-frequency = <6000000>;
> +		};
> +	};
> +
> +	ahb {
> +		apb {
> +			dbgu: serial at fffff200 {
> +				status = "okay";
> +			};
> +		};
> +
> +		nand0: nand at 40000000 {
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "soft";
> +			nand-on-flash-bbt;
> +			status = "okay";
> +
> +			boot at 0 {
> +				label = "boot";
> +				reg = <0x0 0x7c0000>;
> +			};
> +
> +			root at 07c0000 {
> +				label = "root";
> +				reg = <0x7c0000 0x7840000>;
> +			};
> +		};
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=ubi0:rootfs ubi.mtd=1 rootfstype=ubifs";
> +	};
> +};
> diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
> index 9e84fe4..11c3ca7 100644
> --- a/arch/arm/mach-at91/Makefile.boot
> +++ b/arch/arm/mach-at91/Makefile.boot
> @@ -16,6 +16,7 @@ endif
>  # Keep dtb files sorted alphabetically for each SoC
>  # sam9260
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += ethernut5.dtb
> +dtb-$(CONFIG_MACH_AT91SAM_DT) += evk-pro3.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += tny_a9260.dtb
>  dtb-$(CONFIG_MACH_AT91SAM_DT) += usb_a9260.dtb
>  # sam9263
> 


-- 
Nicolas Ferre

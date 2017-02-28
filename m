From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 18:03:27 -0600
Subject: [PATCH v2 4/5] ARM64: dts: Prepare Realtek RTD1295 and Zidoo X9S
In-Reply-To: <20170223164553.3715-5-afaerber@suse.de>
References: <20170223164553.3715-1-afaerber@suse.de>
 <20170223164553.3715-5-afaerber@suse.de>
Message-ID: <20170228000327.hnenlharcmiqxkpb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 05:45:51PM +0100, Andreas F?rber wrote:
> Add initial device trees for the RTD1295 SoC and the Zidoo X9S TV box.
> 
> The CPUs lack the enable-method property because the vendor device tree
> uses a custom "rtk-spin-table" method and "psci" did not appear to work.
> 
> The UARTs lack the interrupts properties because the vendor device tree
> connects them to a custom interrupt controller. earlycon works without.
> 
> A list of memory reservations is adopted from v1.2.11 vendor device tree:
> 0x02200000 can be used for an initrd, 0x01b00000 is audio-related;
> ion-related 0x02600000, 0x02c00000 and 0x11000000 are left out;
> 0x10000000 is used for sharing the U-Boot environment; others remain
> to be investigated.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Dropped 0x0000000010000000 /memreserve/
>  
>  arch/arm64/boot/dts/Makefile                      |   1 +
>  arch/arm64/boot/dts/realtek/Makefile              |   5 +
>  arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts |  78 +++++++++++
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi          | 162 ++++++++++++++++++++++
>  4 files changed, 246 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/Makefile
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 080232b..78f7991 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -14,6 +14,7 @@ dts-dirs += marvell
>  dts-dirs += mediatek
>  dts-dirs += nvidia
>  dts-dirs += qcom
> +dts-dirs += realtek
>  dts-dirs += renesas
>  dts-dirs += rockchip
>  dts-dirs += socionext
> diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
> new file mode 100644
> index 0000000..8521e92
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
> new file mode 100644
> index 0000000..53302bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (c) 2016-2017 Andreas F?rber
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.

You can use SPDX tag here instead.

> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;

Unless you have >4GB regions, you don't really need 2 cells here.

> +		ranges;
> +
> +		tee at 10100000 {
> +			reg = <0x0 0x10100000 0x0 0xf00000>;
> +			no-map;
> +		};
> +	};


> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;

Same here. And use ranges to narrow the address space to what you need.

> +		ranges;
> +
> +		uart0: serial at 98007800 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x98007800 0x0 0x400>,
> +			      <0x0 0x98007000 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <27000000>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial at 9801b200 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x9801b200 0x0 0x100>,
> +			      <0x0 0x9801b00c 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <432000000>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial at 9801b400 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x9801b400 0x0 0x100>,
> +			      <0x0 0x9801b00c 0x0 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clock-frequency = <432000000>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller at ff011000 {
> +			compatible = "arm,gic-400";
> +			reg = <0x0 0xff011000 0x0 0x1000>,
> +			      <0x0 0xff012000 0x0 0x1000>;

You are missing some register ranges and the sizes may be wrong. Check 
the binding doc.

> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +	};
> +};
> -- 
> 2.10.2
> 

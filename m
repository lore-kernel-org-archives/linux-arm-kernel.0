From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 15:59:09 +0200
Subject: [PATCH 1/2] arm: dts: mt7623: cleanup MT7623N NAND dts file
In-Reply-To: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
References: <34e4c13bd1deeb8e090a74b4e7e9192512b3eff0.1531199139.git.ryder.lee@mediatek.com>
Message-ID: <53d30dd0-d805-1ff9-c0f0-4029e7ee453f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/18 07:09, Ryder Lee wrote:
> Normally, we didn't release this kind of baord to user. This specific
> board exists only in the early stage of development inside MediaTek -
> and that may confuse peoples.
> 
> Hence this patch removes related files accordingly.
> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Whole series pushed to v4.18-next/dts32

Thanks a lot to everybody who provided feedback.

Regards,
Matthias

> ---
>  arch/arm/boot/dts/Makefile             |  1 -
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts | 73 -----------------------------
>  arch/arm/boot/dts/mt7623n-rfb.dtsi     | 86 ----------------------------------
>  3 files changed, 160 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
>  delete mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..dde494e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1168,7 +1168,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt7623a-rfb-emmc.dtb \
>  	mt7623a-rfb-nand.dtb \
>  	mt7623n-rfb-emmc.dtb \
> -	mt7623n-rfb-nand.dtb \
>  	mt7623n-bananapi-bpi-r2.dtb \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> deleted file mode 100644
> index 96ff3c9..0000000
> --- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2017 MediaTek Inc.
> - * Author: John Crispin <john@phrozen.org>
> - *
> - */
> -
> -/dts-v1/;
> -#include "mt7623n-rfb.dtsi"
> -
> -/ {
> -	model = "MediaTek MT7623N NAND reference board";
> -	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
> -};
> -
> -&bch {
> -	status = "okay";
> -};
> -
> -&nandc {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&nand_pins_default>;
> -
> -	nand at 0 {
> -		reg = <0>;
> -		spare_per_sector = <64>;
> -		nand-ecc-mode = "hw";
> -		nand-ecc-strength = <12>;
> -		nand-ecc-step-size = <1024>;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			partition at 0 {
> -				label = "preloader";
> -				reg = <0x0 0x40000>;
> -			};
> -
> -			partition at 40000 {
> -				label = "uboot";
> -				reg = <0x40000 0x80000>;
> -			};
> -
> -			partition at c0000 {
> -				label = "uboot-env";
> -				reg = <0xC0000 0x40000>;
> -			};
> -
> -			partition at 140000 {
> -				label = "bootimg";
> -				reg = <0x140000 0x2000000>;
> -			};
> -
> -			partition at 2140000 {
> -				label = "recovery";
> -				reg = <0x2140000 0x2000000>;
> -			};
> -
> -			partition at 4140000 {
> -				label = "rootfs";
> -				reg = <0x4140000 0x1000000>;
> -			};
> -
> -			partition at 5140000 {
> -				label = "usrdata";
> -				reg = <0x5140000 0x1000000>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> deleted file mode 100644
> index 5c5cc7d..0000000
> --- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2017 MediaTek Inc.
> - * Author: John Crispin <john@phrozen.org>
> - *	   Sean Wang <sean.wang@mediatek.com>
> - *
> - */
> -
> -/dts-v1/;
> -#include "mt7623.dtsi"
> -#include "mt6323.dtsi"
> -
> -/ {
> -	aliases {
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	cpus {
> -		cpu0 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu1 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu2 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -
> -		cpu3 {
> -			proc-supply = <&mt6323_vproc_reg>;
> -		};
> -	};
> -
> -	memory at 80000000 {
> -		device_type = "memory";
> -		reg = <0 0x80000000 0 0x40000000>;
> -	};
> -
> -	usb_p1_vbus: regulator-5v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -};
> -
> -&mmc0 {
> -	vmmc-supply = <&mt6323_vemc3v3_reg>;
> -	vqmmc-supply = <&mt6323_vio18_reg>;
> -};
> -
> -&mmc1 {
> -	vmmc-supply = <&mt6323_vmch_reg>;
> -	vqmmc-supply = <&mt6323_vmc_reg>;
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	status = "okay";
> -};
> -
> -&usb1 {
> -	vbus-supply = <&usb_p1_vbus>;
> -	status = "okay";
> -};
> -
> -&u3phy1 {
> -	status = "okay";
> -};
> 

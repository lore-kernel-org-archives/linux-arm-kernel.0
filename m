From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu, 26 Jul 2018 11:51:28 +0200
Subject: [PATCH v1] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
In-Reply-To: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
References: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <d84ef7a6-8db0-ff71-8e11-a5f56c70d60d@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Levin,

Some few comments.

On 26/07/18 09:13, djw at t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
> computer with USB 3.0 and Gigabit Ethernet in a form factor
> compatible with the Raspberry Pi. It is based on the Rockchip
> RK3399 SoC, powered by the Type-C port.
> 
> The devicetree currently supports peripherals of:
> 
> - Ethernet
> - HDMI
> - SD Card
> - UART2 debug
> - TYPE-C
> - eMMC
> 
> USB3 in type-c port currently only works with normal orientation,
> not flip one.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v1:
> - remove bootargs
> - use interpolation for brightness level
> - add vcc_vbus_typec1 regulator
> - fix phy-supply of u2phy0_otg and u2phy1_otg
> - remove vcc_hub_en dummy regualtor
> - add hub_rst (changed to output high) to pinctrl status of vcc5v0_host
> - remove vsel-gpios props in fan53xx
> - remove mp8859 in i2c
> - fusb302: fix interrupt setting
> - fusb302: add vbus-supply
> - remove extcon in tcphy0 and tcphy1
> - remove #sound-dai-cells in i2s*
> - use RK_PXX style bit number for cd-gpios in SDMMC
> - clean commented status lines
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts     | 687 +++++++++++++++++++++
>  3 files changed, 692 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index acfd3c7..ab5fde8 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -59,6 +59,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
>  
> +- Firefly ROC-RK3399-PC board:
> +    Required root node properties:
> +      - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> +
>  - ChipSPARK PopMetal-RK3288 board:
>      Required root node properties:
>        - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b0092d9..06028db 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> new file mode 100644
> index 0000000..7d41a91
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -0,0 +1,687 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Firefly ROC-RK3399-PC Board";
> +	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 25000 0>;
> +
> +		brightness-levels = <0 255>;
> +		default-brightness-level = <200>;
> +		num-interpolated-steps = <1>;

Unless you want a custom brightness-levels for some reason and because of
default brightness table does not work for you I'd remove all these three
properties and just use the default table.

After commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
linearly to human eye") the pwm_bl driver is able to calculate a default
brightness table. The calculated table for this PWM will have more
granularity and will be adjusted to change the brightness linearly to
the human eye. So I think you can use that table instead of have a DT-defined
table with less granularity.

> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};

<snip>

> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usbdrd3_0 {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +	status = "okay";
> +	dr_mode = "otg";

dr_mode is already set in rk3399.dtsi so you can remove that from here.

> +};
> +
> +&usbdrd3_1 {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_1 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&vopb {
> +	status = "okay";
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&vopl {
> +	status = "okay";
> +};
> +
> +&vopl_mmu {
> +	status = "okay";
> +};
> 

Best regards,
 Enric

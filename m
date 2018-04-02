From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Apr 2018 14:02:20 +0530
Subject: [PATCH] ARM: dts: da850-evm: add WP and CD to MMC
In-Reply-To: <1522428754-28337-1-git-send-email-aford173@gmail.com>
References: <1522428754-28337-1-git-send-email-aford173@gmail.com>
Message-ID: <8dc9db0f-f5e8-42fc-d23c-662ee07714c2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Friday 30 March 2018 10:22 PM, Adam Ford wrote:
> The legacy mode uses the write protect and card detect but DT
> has not.  This patch enables the pinmuxing and detection for
> WP and CD.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index c82368c..1030788 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -42,6 +42,12 @@
>  					0x04 0x00011000 0x000ff000
>  				>;
>  			};
> +			mmc0_cd_wp_pins: pinmux_mmc0_cd_wp_pins {
> +				pinctrl-single,bits = <
> +					/* GP4[0], GP4[1]*/
> +					0x28 0x88000000 0xff000000
> +					>;
> +			};

A new mux node for GPIO pins should not be needed after David Lechner's
gpio-ranges support patch[1]. I should be applying that soon after
v4.17-rc1 is out and its dependencies merged. Can you please re-spin
this patch then to apply on top of that?

Thanks,
Sekhar

[1] https://patchwork.kernel.org/patch/10229153/

>  			nand_pins: nand_pins {
>  				pinctrl-single,bits = <
>  					/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
> @@ -106,7 +112,9 @@
>  			bus-width = <4>;
>  			status = "okay";
>  			pinctrl-names = "default";
> -			pinctrl-0 = <&mmc0_pins>;
> +			pinctrl-0 = <&mmc0_pins &mmc0_cd_wp_pins>;
> +			cd-gpios = <&gpio 64 GPIO_ACTIVE_LOW>;
> +			wp-gpios = <&gpio 65 GPIO_ACTIVE_HIGH>;
>  		};
>  		spi1: spi at 30e000 {
>  			status = "okay";
> -- 
> 2.7.4
> 

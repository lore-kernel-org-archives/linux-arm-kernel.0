From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 21 Feb 2017 16:57:15 +0100
Subject: [PATCH v3 3/7] mmc: bcm2835: add sdhost controller to devicetree
In-Reply-To: <1487668026-7100-4-git-send-email-kraxel@redhat.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
 <1487668026-7100-4-git-send-email-kraxel@redhat.com>
Message-ID: <48fcc95e-3a21-f6d0-8073-cae34871656a@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 21.02.2017 um 10:07 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---
>   arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
>   arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 0b73f9c..7d89af2 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -69,6 +69,12 @@
>   	bus-width = <4>;
>   };
>   
> +&sdhost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhost_gpio48>;
> +	bus-width = <4>;
> +};
> +
>   &pwm {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index a3106aa..3f4fbff 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -450,6 +450,16 @@
>   			status = "disabled";
>   		};
>   
> +		sdhost: mmc at 7e202000 {
> +			compatible = "brcm,bcm2835-sdhost";
> +			reg = <0x7e202000 0x100>;
> +			interrupts = <2 24>;
> +			clocks = <&clocks BCM2835_CLOCK_VPU>;
> +			dmas = <&dma 13>;
> +			dma-names = "rx-tx";
> +			status = "disabled";
> +		};
> +
>   		hvs at 7e400000 {
>   			compatible = "brcm,bcm2835-hvs";
>   			reg = <0x7e400000 0x6000>;

Unfortunately this is still the wrong place regarding to the register 
order. So please be placed it between uart0: serial at 7e201000 and i2s: 
i2s at 7e203000.

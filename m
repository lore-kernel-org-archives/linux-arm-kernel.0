From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 9 Feb 2017 16:55:41 +0000
Subject: [PATCH v2 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
In-Reply-To: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
Message-ID: <ff34a257-7272-9b9e-c0bb-a88bac8b3d05@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/01/17 10:09, Teresa Remmet wrote:
> The phyCORE-AM335x development kit is a combination of the
> phyCORE-AM335x SoM and a PCM-953 carrier board. The features
> of the PCM-953 are:
> * ETH phy on carrier board: 1x RGMII
> * 1x CAN
> * Up to 4x UART
> * USB0 (otg)
> * USB1 (host)
> * SD slot
> * User gpio-keys
> * User LEDs
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> - moved gpio-keys, gpio-leds and regulators nodes to root node
> - moved muxing of gpio-keys and gpio-leds
> - removed not needed compatible "simple-bus"
> - fixed unit address of ethernet phy node
> - removed redundant status properties
> - added Acked-by: Rob Herring <robh@kernel.org>
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am335x-pcm-953.dtsi              | 288 +++++++++++++++++++++
>  arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 ++
>  4 files changed, 319 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
>  create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts
> 

[...]

> diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
> new file mode 100644
> index 0000000..02981ea
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi

[...]

};
> +	};
> +
> +	user_buttons: user_buttons {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&user_buttons_pins>;
> +
> +		button at 0 {
> +			label = "home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +			gpio-key,wakeup;
> +		};
> +
> +		button at 1 {
> +			label = "menu";
> +			linux,code = <KEY_MENU>;
> +			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
> +			gpio-key,wakeup;

Could you please replace this with wakeup-source as specified in
Documentation/devicetree/bindings/power/wakeup-source.txt

I know this patch is merged, just fix it on top of linux-next ?
I think TI/OMAP downstream tree has some remnants of the legacy
boolean and it keeps slipping through every merge window :)

-- 
Regards,
Sudeep

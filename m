From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Nov 2014 13:08:57 +0100
Subject: [PATCH 03/13] ARM: STi: DT: STiH416: Add DT nodes for the ehci
 and ohci usb controllers.
In-Reply-To: <1415361475-6218-4-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <2945908.5UNg8NaKcc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014 11:57:45 Peter Griffin wrote:
> diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
> index 0f3019a..6238d9e 100644
> --- a/arch/arm/boot/dts/stih416.dtsi
> +++ b/arch/arm/boot/dts/stih416.dtsi
> @@ -325,5 +325,149 @@
>                         clock-names = "osc_phy";
>  
>                 };
> +
> +               ehci0: usb at 0xfe1ffe00 {

Please drop the '0x' from the unit address in all instances.

> +                       compatible = "st,st-ehci-300x";
> +                       reg = <0xfe1ffe00 0x100>;
> +                       interrupts = <GIC_SPI 148 IRQ_TYPE_NONE>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_usb0>;
> +                       clocks = <&clk_s_a1_ls 0>,
> +                                <&clockgen_b0 0>;
> +                       clock-names = "ic", "clk48";
> +
> +                       phys = <&usb2_phy>;
> +                       phy-names = "usb";
> +                       status = "okay";

No need to list 'status="okay"', it's the default. It might
make sense to change this to 'status="disabled"' though, if the ports
might be unused on some boards.

>                 mmc0: sdhci at fe81e000 {
>                         bus-width = <8>;
>                 };
> +
> +               usb0: usb at fe100000 {
> +                       status = "okay";
> +               };
> +
> +               usb1: usb at fe200000 {
> +                       status = "okay";
> +               };
> +
> +               usb2: usb at fe300000 {
> +                       status = "okay";
> +               };

I don't understand this part: why do you add extra nodes here that only
contain a status property?

Note that if you add the devices to the per-soc file instead of the
per-board file, you can just access the nodes by label.

	Arnd

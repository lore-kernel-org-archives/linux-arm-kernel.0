From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 14:42:25 +0800
Subject: MicroSys sbc6x support (i.MX6)
In-Reply-To: <20130331201614.GC25751@amd.pavel.ucw.cz>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
 <20130330113703.GA21042@amd.pavel.ucw.cz>
 <5156D69E.3050600@gmail.com>
 <20130331201614.GC25751@amd.pavel.ucw.cz>
Message-ID: <20130401064224.GD1693@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 31, 2013 at 10:16:14PM +0200, Pavel Machek wrote:
> Add support for MicroSys sbc6x board.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
Are you using git send-email?  Why the diff stat is missing here?
Generally, I prefer to have prefix "ARM: dts: ..." put on subject for
such type of dts patches.

Also, please can you rebase the patch on my imx/dt branch below?

  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..1590ae9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -99,7 +99,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-arm2.dtb \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
> -	imx6q-sabresd.dtb
> +	imx6q-sabresd.dtb \
> +	imx6q-sbc6x.dtb
>  dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx23-olinuxino.dtb \
>  	imx23-stmp378x_devb.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
> new file mode 100644
> index 0000000..cca8a46
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2013 Pavel Machek <pavel@denx.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License V2.
> + */
> +
> +/dts-v1/;
> +/include/ "imx6q.dtsi"
> +
> +/ {
> +	model = "MicroSys sbc6x board";
> +	compatible = "fsl,imx6q";

We generally have a vendor specific compatible string for custom
boards. 

> +
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1_1>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_1>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3_2>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg_1>;
> +	disable-over-current;
> +	status = "okay";
> +};

I'm going to be nit on new board dts files about the node order.  Please
sort them by label name in alphabet order.

	&fec
	&uart1
	&usbotg
	&usdhc3

Shawn

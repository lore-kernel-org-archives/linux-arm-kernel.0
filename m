From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 17:20:01 +0800
Subject: IMX6 USDHC card detection
In-Reply-To: <CAOMZO5DrdXpWuULubSjSw7fhCm40JiXnVZwu=YMjzX1sW_tuuw@mail.gmail.com>
References: <20131003193623.GF12758@n2100.arm.linux.org.uk>
 <CAOMZO5DrdXpWuULubSjSw7fhCm40JiXnVZwu=YMjzX1sW_tuuw@mail.gmail.com>
Message-ID: <20131005092000.GL2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 01:07:03PM -0300, Fabio Estevam wrote:
> Ran a quick test on a mx6qsabresd.
> 
> The original imx6qdl-sabresd.dtsi uses cd-gpio for sdhc3 port and I removed it:
> 
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -164,8 +164,6 @@
>                         fsl,pins = <
>                                 MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
>                                 MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
> -                               MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
> -                               MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
>                                 MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
>                                 MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
>                                 MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
> @@ -239,7 +237,5 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_usdhc3_1>;
>         bus-width = <8>;
> -       cd-gpios = <&gpio2 0 0>;
> -       wp-gpios = <&gpio2 1 0>;
>         status = "okay";
>  };
> 
> After this change,  the SD controller internal card detection also worked fine.

I guess you are not using the controller internal card detection at all
in this case, because pad NANDF_D0 has no function of any SD_CD_B.  The
card detection may just happen to work via DAT3 (D3CD).  But same as
what Russell has seen, the description of D3CD bit suggests that DAT3
should be pulled down in this case.

DATA3 as Card Detection Pin:
If this bit is set, DATA3 should be pulled down to act as a card
detection pin. Be cautious when using this feature, because DATA3 is
also a chip-select for the SPI mode. A pull-down on this pin and CMD0
may set the card into the SPI mode, which the uSDHC does not support.

Shawn

From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 22 Sep 2017 13:33:39 +0000
Subject: [PATCH v2] ARM: dts: iwg22d: Enable SDHI0 controller
In-Reply-To: <1506085262-13639-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <TY1PR06MB0702E99A48352C055705E3A9B7670@TY1PR06MB0702.apcprd06.prod.outlook.com>
 <1506085262-13639-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR06MB08955E235768A72D33FE2AD3C0670@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

just to clarify the changes between v1 and v2, we can't use SDR50 and SDR104 (due to an HW issue) therefore the pinctrl for UHS has been removed and we dropped property "sd-uhs-sdr104". High Speed has been tested, therefore if you are happy with the patch I guess you can update the following page accordingly:
http://elinux.org/index.php?title=Renesas-MMC-Enabled-Speeds&type=revision&diff=451426&oldid=451421

Although (due to a bug) sdhi0 may not hold a reference to "vccq_sdhi0", the gpio regulator will initialize "SDHI0 VccQ" at 3.3V.
I have sent another patch (mmc: tmio: check mmc_regulator_get_supply return value) to start a discussion about a possible fix for the bug.

Let me know if you need more information.

Thanks,
Fabrizio

> -----Original Message-----
> From: linux-renesas-soc-owner at vger.kernel.org [mailto:linux-renesas-soc-owner at vger.kernel.org] On Behalf Of Fabrizio Castro
> Sent: 22 September 2017 14:01
> To: Simon Horman <horms+renesas@verge.net.au>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; Biju Das <biju.das@bp.renesas.com>; devicetree at vger.kernel.org; linux-renesas-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Chris Paterson <Chris.Paterson2@renesas.com>
> Subject: [PATCH v2] ARM: dts: iwg22d: Enable SDHI0 controller
>
> Enable the SDHI0 controller on iWave RZ/G1E carrier board.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> index aac84c6..8772c56 100644
> --- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> +++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> @@ -24,6 +24,19 @@
>  bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
>  stdout-path = "serial0:115200n8";
>  };
> +
> +vccq_sdhi0: regulator-vccq-sdhi0 {
> +compatible = "regulator-gpio";
> +
> +regulator-name = "SDHI0 VccQ";
> +regulator-min-microvolt = <1800000>;
> +regulator-max-microvolt = <3300000>;
> +
> +gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
> +gpios-states = <1>;
> +states = <3300000 1
> +  1800000 0>;
> +};
>  };
>
>  &pfc {
> @@ -36,6 +49,12 @@
>  groups = "avb_mdio", "avb_gmii";
>  function = "avb";
>  };
> +
> +sdhi0_pins: sd0 {
> +groups = "sdhi0_data4", "sdhi0_ctrl";
> +function = "sdhi0";
> +power-source = <3300>;
> +};
>  };
>
>  &scif4 {
> @@ -63,3 +82,13 @@
>  micrel,led-mode = <1>;
>  };
>  };
> +
> +&sdhi0 {
> +pinctrl-0 = <&sdhi0_pins>;
> +pinctrl-names = "default";
> +
> +vmmc-supply = <&reg_3p3v>;
> +vqmmc-supply = <&vccq_sdhi0>;
> +cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;
> +status = "okay";
> +};
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

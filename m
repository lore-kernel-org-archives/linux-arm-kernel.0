From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 28 Sep 2014 11:28:53 +0800
Subject: [PATCH v1 3/3] ARM: dts: imx6x: Add enet2 support for imx6sx-sdb
 board
In-Reply-To: <1411524680-12863-4-git-send-email-b38611@freescale.com>
References: <1411524680-12863-1-git-send-email-b38611@freescale.com>
 <1411524680-12863-4-git-send-email-b38611@freescale.com>
Message-ID: <20140928032852.GC12999@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:11:20AM +0800, Fugang Duan wrote:
> Add enet2 support for imx6sx-sdb board, and add the "fsl,imx6q-fec"
> compatible for fec2 node to be compatible with the old version.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts |   28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6sx.dtsi    |    2 +-
>  2 files changed, 29 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 82d6b34..06e0977 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -133,6 +133,14 @@
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_enet1>;
> +	pinctrl-assert-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>, <&gpio2 6 GPIO_ACTIVE_LOW>;

I do not think this property is supported by upstream kernel.

> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&fec2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet2>;
>  	phy-mode = "rgmii";
>  	status = "okay";
>  };
> @@ -394,6 +402,26 @@
>  				MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2	0x3081
>  				MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3	0x3081
>  				MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN	0x3081
> +				MX6SX_PAD_QSPI1A_DATA0__GPIO4_IO_16	0x80000000
> +				MX6SX_PAD_QSPI1A_DATA3__GPIO4_IO_19	0x80000000
> +				MX6SX_PAD_ENET2_RX_CLK__ENET2_REF_CLK_25M	0x91
> +			>;
> +		};
> +
> +		pinctrl_enet2: enet2grp {
> +			fsl,pins = <
> +				MX6SX_PAD_RGMII2_TXC__ENET2_RGMII_TXC	0xa0b9
> +				MX6SX_PAD_RGMII2_TD0__ENET2_TX_DATA_0	0xa0b1
> +				MX6SX_PAD_RGMII2_TD1__ENET2_TX_DATA_1	0xa0b1
> +				MX6SX_PAD_RGMII2_TD2__ENET2_TX_DATA_2	0xa0b1
> +				MX6SX_PAD_RGMII2_TD3__ENET2_TX_DATA_3	0xa0b1
> +				MX6SX_PAD_RGMII2_TX_CTL__ENET2_TX_EN	0xa0b1
> +				MX6SX_PAD_RGMII2_RXC__ENET2_RX_CLK	0x3081
> +				MX6SX_PAD_RGMII2_RD0__ENET2_RX_DATA_0	0x3081
> +				MX6SX_PAD_RGMII2_RD1__ENET2_RX_DATA_1	0x3081
> +				MX6SX_PAD_RGMII2_RD2__ENET2_RX_DATA_2	0x3081
> +				MX6SX_PAD_RGMII2_RD3__ENET2_RX_DATA_3	0x3081
> +				MX6SX_PAD_RGMII2_RX_CTL__ENET2_RX_EN	0x3081
>  			>;
>  		};
>  
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 888dd76..5a36053 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -875,7 +875,7 @@
>  			};
>  
>  			fec2: ethernet at 021b4000 {
> -				compatible = "fsl,imx6sx-fec";
> +				compatible = "fsl,imx6sx-fec", "fsl,imx6q-fec";

Why is this change is necessary?  If "fsl,imx6sx-fec" is supported by
driver, it can be matched.

Shawn

>  				reg = <0x021b4000 0x4000>;
>  				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 1.7.8
> 

From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2012 17:55:47 +0200
Subject: [PATCH 5/6] csb1724: Enable device tree based mv643xx ethernet
 support.
In-Reply-To: <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-6-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <20120730155547.GL18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:15:58PM +0100, Ian Molton wrote:
>     This patch enables mv643xx based ethernet built into the SoM on the
>     csb1724, via flattened device tree.
> 
>     Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  arch/arm/boot/dts/kirkwood-csb1724.dts |   25 ++++++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi        |   16 ++++++++++++
>  arch/arm/configs/csb1724_defconfig     |   45 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-csb1724.c |    3 +++
>  4 files changed, 89 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-csb1724.dts b/arch/arm/boot/dts/kirkwood-csb1724.dts
> index 44dfe9a..f652797 100644
> --- a/arch/arm/boot/dts/kirkwood-csb1724.dts
> +++ b/arch/arm/boot/dts/kirkwood-csb1724.dts
> @@ -25,6 +25,31 @@
>  			nr-ports = <2>;
>  			status = "ok";
>  		};
> +
> +		smi0: mdio at 72000 {
> +			status = "ok";
> +		};
> +
> +		smi1: mdio at 76000 {
> +			status = "ok";
> +		};
> +
> +		egiga0 {
> +			compatible = "marvell,mv643xx";
> +			mdio = <&smi0>;
> +			port_number = <0>;
> +			phy_addr = <0x80>;
> +			interrupts = <11>;
> +		};
> +
> +		egiga1 {
> +			compatible = "marvell,mv643xx";
> +			mdio = <&smi1>;
> +			port_number = <0>;
> +			phy_addr = <0x81>;
> +			interrupts = <15>;
> +		};
> +
>  	};
>  
>  };
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index cef9616..dd10422 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -105,5 +105,21 @@
>  			clock-frequency = <100000>;
>  			status = "disabled";
>  		};
> +
> +		smi0: mdio at 72000 {
> +			compatible = "marvell,mdio-mv643xx";
> +			reg = <0x72000 0x4000>;
> +			interrupts = <46>;
> +			status = "disabled";
> +		};
> +
> +		smi1: mdio at 76000 {
> +			compatible = "marvell,mdio-mv643xx";
> +			reg = <0x76000 0x4000>;
> +			interrupts = <47>;
> +			shared_smi = <&smi0>;
> +			status = "disabled";
> +		};
> +


Hi Ian

I'm trying to keep this in order. Currently i2c is in the wrong place,
but the rest are incremental. It looks like these should be between
wdt & sata.

What about default entries for egiga0 and egiga1 with status
"disabled"? It looks like the only thing which changes between boards
is phy_addr.

   Andrew

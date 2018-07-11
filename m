From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 11 Jul 2018 22:08:34 +0200
Subject: [PATCH 1/3 v3] ARM: dts: Add WAN ethernet port to the SQ201
In-Reply-To: <20180711194720.25266-1-linus.walleij@linaro.org>
References: <20180711194720.25266-1-linus.walleij@linaro.org>
Message-ID: <20180711200834.GE21430@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 09:47:18PM +0200, Linus Walleij wrote:
> This sets up the ethernet interface and PHY for the
> WAN ethernet port which uses a Marvell PHY.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - No changes, just resending.
> ChangeLog v1->v2:
> - Rename wrongly named "ethernet-phy" to "mdio"
> - Drop device_type from the ethernet phy
> ---
>  arch/arm/boot/dts/gemini-sq201.dts | 85 ++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
> index 7658e212e6d2..cc693e64faaf 100644
> --- a/arch/arm/boot/dts/gemini-sq201.dts
> +++ b/arch/arm/boot/dts/gemini-sq201.dts
> @@ -55,6 +55,21 @@
>  		};
>  	};
>  
> +	mdio0: ethernet-phy {

Hi Linus

mdio0: mdio {

This is not a phy. Which is odd, because v1->v2 should of fixed this...

> +		compatible = "virtual,mdio-gpio";
> +		/* Uses MDC and MDIO */
> +		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> +			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* This is a Marvell 88E1111 ethernet transciever */
> +		phy0: ethernet-phy at 1 {
> +			reg = <1>;
> +			device_type = "ethernet-phy";

???

I'm wondering if this is the correct version of these patches....

	Andrew

From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 8 Sep 2017 15:30:32 -0700
Subject: [PATCH 2/2] arm64: dts: stratix10: add ethernet/sdmmc support to
 the S10 devkit
In-Reply-To: <1504885734-9618-2-git-send-email-dinguyen@kernel.org>
References: <1504885734-9618-1-git-send-email-dinguyen@kernel.org>
 <1504885734-9618-2-git-send-email-dinguyen@kernel.org>
Message-ID: <4e289c38-bf04-6d07-5e72-f543b0f4cb0f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2017 08:48 AM, Dinh Nguyen wrote:
> Enable ethernet and sdmmc support on the Stratix10 devkit.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 41ea2db..ae0e8f3 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -34,6 +34,42 @@
>  	};
>  };
>  
> +&gmac0 {
> +	phy-mode = "rgmii";
> +	phy-addr = <0xffffffff>; /* probe for phy addr */

This is a deprecated property for stmmac, just use the correct PHY
address and use a phy-handle property to connect to it, along with a
proper mdio subnode to indicate it is connecting to the stmmac MDIO bus.

> +
> +	/*
> +	 * These skews assume the user's FPGA design is adding 600ps of delay
> +	 * for TX_CLK on Arria 10.
> +	 *
> +	 * All skews are offset since hardware skew values for the ksz9031
> +	 * range from a negative skew to a positive skew.
> +	 * See the micrel-ksz90x1.txt Documentation file for details.
> +	*/
> +	txd0-skew-ps = <0>; /* -420ps */
> +	txd1-skew-ps = <0>; /* -420ps */
> +	txd2-skew-ps = <0>; /* -420ps */
> +	txd3-skew-ps = <0>; /* -420ps */
> +	rxd0-skew-ps = <420>; /* 0ps */
> +	rxd1-skew-ps = <420>; /* 0ps */
> +	rxd2-skew-ps = <420>; /* 0ps */
> +	rxd3-skew-ps = <420>; /* 0ps */
> +	txen-skew-ps = <0>; /* -420ps */
> +	txc-skew-ps = <1860>; /* 960ps */
> +	rxdv-skew-ps = <420>; /* 0ps */
> +	rxc-skew-ps = <1680>; /* 780ps */

These are all PHY properties, and the driver and binding now recommend
using them as such, can you move that to the PHY node instead?

> +	max-frame-size = <3800>;
> +	status = "okay";
> +};
> +
> +&mmc {
> +	status = "okay";
> +	num-slots = <1>;
> +	cap-sd-highspeed;
> +	broken-cd;
> +	bus-width = <4>;
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> 


-- 
Florian

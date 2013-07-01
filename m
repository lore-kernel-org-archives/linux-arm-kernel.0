From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 20:58:21 +0800
Subject: [PATCH] ARM: dts: i.MX27: Add Secondary AHB Port definitions
In-Reply-To: <1372487325-14405-1-git-send-email-shc_work@mail.ru>
References: <1372487325-14405-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130701125819.GJ13206@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 10:28:45AM +0400, Alexander Shiyan wrote:
> Patch adds Secondary AHB Port definitions for i.MX27 SOC and
> moves NAND Flash Controller (NFC) under AHB Slave Port 1.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 86b6f5f..7c0179e 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -399,14 +399,30 @@
>  			};
>  		};
>  
> -		nfc: nand at d8000000 {
> +		ahb1: ahb at 80000000 { /* Secondary AHB Slave Port 1 */

We do not have the top level of AHB bus topology represented in device
tree.  Your patch introduces it, partially - all about Secondary AHB
Slave but nothing about Primary AHB.

I'm not really fond of the change, since it's not extremely useful to
me.  Do you have a real reason for the change?

Shawn

> +			compatible = "fsl,ahb-bus", "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			compatible = "fsl,imx27-nand";
> -			reg = <0xd8000000 0x1000>;
> -			interrupts = <29>;
> -			clocks = <&clks 54>;
> -			status = "disabled";
> +			reg = <0x80000000 0x20000000>;
> +			ranges;
> +		};
> +
> +		ahb2: ahb at a0000000 { /* Secondary AHB Slave Port 2 */
> +			compatible = "fsl,ahb-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0xa0000000 0x40000000>;
> +			ranges;
> +
> +			nfc: nand at d8000000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "fsl,imx27-nand";
> +				reg = <0xd8000000 0x1000>;
> +				interrupts = <29>;
> +				clocks = <&clks 54>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		iram: iram at ffff4c00 {
> -- 
> 1.8.1.5
> 

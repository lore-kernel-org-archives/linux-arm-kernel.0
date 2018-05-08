From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 8 May 2018 11:31:27 +0300
Subject: [PATCH 4/5] arm64: allwinner: h6: add USB3 device nodes
In-Reply-To: <20180507151817.55663-5-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
 <20180507151817.55663-5-icenowy@aosc.io>
Message-ID: <9a25a561-b643-a77b-3287-8082780fce60@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 5/7/2018 6:18 PM, Icenowy Zheng wrote:

> Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
> a custom PHY.
> 
> Add device tree nodes for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index c72da8cd9ef5..9564c938717c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -174,6 +174,44 @@
>   			status = "disabled";
>   		};
>   
> +		usb3: usb at 5200000 {

    I don't think <unit-address> is allowed for a node having no "reg" prop...

> +			compatible = "allwinner,sun50i-h6-dwc3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&ccu CLK_BUS_XHCI>;
> +			clock-names = "bus";
> +			resets = <&ccu RST_BUS_XHCI>;
> +			reset-names = "bus";
> +			status = "disabled";
> +
> +			dwc3: dwc3 {

    Contrariwise, need <unit-address> here...

> +				compatible = "snps,dwc3";
> +				reg = <0x5200000 0x10000>;
> +				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +				/*
> +				 * According to Wink from Allwinner, the
> +				 * USB3 port on H6 is not capable of OTG;
> +				 * the datasheet doesn't mention OTG at all
> +				 * either, so the dr_mode is default to
> +				 * "host" here.
> +				 */
> +				dr_mode = "host";
> +				phys = <&usb3phy>;
> +				phy-names = "usb3-phy";
> +				status = "disabled";
> +			};
> +		};
[...]

MBR, Sergei

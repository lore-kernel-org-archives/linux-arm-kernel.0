From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jan 2017 20:23:18 +0200
Subject: [PATCH v2 1/2] arm64: dts: exynos: Add USB 3.0 controller node
 for Exynos7
In-Reply-To: <1484665444-23365-2-git-send-email-pankaj.dubey@samsung.com>
References: <1484665444-23365-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170117150121epcas1p102bd1355f780a56e14a0a7a81bd6dfaf@epcas1p1.samsung.com>
 <1484665444-23365-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170117182318.fvatrazvyuzmdsor@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 08:34:03PM +0530, Pankaj Dubey wrote:
> From: Vivek Gautam <gautamvivek1987@gmail.com>
> 
> Add USB 3.0 DRD controller device node, with its clock
> and phy information to enable the same on Exynos7.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Javier's Reviewed-by should be at the end.

> ---
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index 9080a11..a2d8d11 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -603,6 +603,40 @@
>  				#include "exynos7-trip-points.dtsi"
>  			};
>  		};
> +
> +		usbdrd_phy: phy at 15500000 {
> +			compatible = "samsung,exynos7-usbdrd-phy";
> +			reg = <0x15500000 0x100>;
> +			clocks = <&clock_fsys0 ACLK_USBDRD300>,
> +			       <&clock_fsys0 OSCCLK_PHY_CLKOUT_USB30_PHY>,
> +			       <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER>,
> +			       <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PHYCLK_USER>,
> +			       <&clock_fsys0 SCLK_USBDRD300_REFCLK>;
> +			clock-names = "phy", "ref", "phy_pipe",
> +				"phy_utmi", "itp";
> +			samsung,pmu-syscon = <&pmu_system_controller>;
> +			#phy-cells = <1>;
> +		};
> +
> +		usbdrd3: usb at 15400000 {
> +			compatible = "samsung,exynos7-dwusb3";
> +			clocks = <&clock_fsys0 ACLK_USBDRD300>,
> +			       <&clock_fsys0 SCLK_USBDRD300_SUSPENDCLK>,
> +			       <&clock_fsys0 ACLK_AXIUS_USBDRD30X_FSYS0X>;
> +			clock-names = "usbdrd30", "usbdrd30_susp_clk",
> +				"usbdrd30_axius_clk";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			dwc3 {

dtc should complain here - you need:
	dwc3 at 15400000
In the same time I think the address node does not have to be put after
parent's usb.

Best regards,
Krzysztof

> +				compatible = "snps,dwc3";
> +				reg = <0x15400000 0x10000>;
> +				interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +				phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
>  	};
>  };
>  
> -- 
> 2.7.4
> 

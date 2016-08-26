From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 26 Aug 2016 13:49:21 -0400
Subject: [PATCH v2 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <4341f429-64a9-b14c-aeca-d61aac2ee81d@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chanwoo,

The patch looks good to me, I just have a few minor comments:

On 08/24/2016 09:49 AM, Chanwoo Choi wrote:

[snip]

> +
> +	reboot: syscon-reboot {
> +		compatible = "syscon-reboot";
> +		regmap = <&pmu_system_controller>;
> +		offset = <0x400>;

Maybe adding a comment that the register is SWRESET to be consistent with the
arm32 Exynos node definition in arch/arm/boot/dts/exynos-syscon-restart.dtsi?

[snip]

> +
> +		tmu_atlas0: tmu at 10060000 {
> +			compatible = "samsung,exynos5433-tmu";
> +			reg = <0x10060000 0x200>;
> +			interrupts = <0 95 0>;

For some interrupts definitions, you are using the GIC interrupt type macros
while for others like this you are using the constant numbers. I think would
be better to use the macros consistently (i.e: interrupts = <GIC_SPI 95 0>).

[snip]

> +		mipi_phy: video-phy at 105C0708 {
> +			compatible = "samsung,exynos5433-mipi-video-phy";
> +			#phy-cells = <1>;
> +			samsung,pmu-syscon = <&pmu_system_controller>;
> +			samsung,cam0-sysreg = <&syscon_cam0>;
> +			samsung,cam1-sysreg = <&syscon_cam1>;
> +			samsung,disp-sysreg = <&syscon_disp>;
> +		};

This node has a unit name but it doesn't have a reg property so dtc will
warn about the mismatch when executed with W=1.

[snip]

> +		usbdrd30: usb at 15400000 {
> +			compatible = "samsung,exynos5250-dwusb3";
> +			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
> +				<&cmu_fsys CLK_SCLK_USBDRD30>;
> +			clock-names = "usbdrd30", "usbdrd30_susp_clk";
> +			assigned-clocks =
> +				<&cmu_fsys CLK_MOUT_SCLK_USBDRD30_USER>,
> +				<&cmu_top CLK_MOUT_SCLK_USBDRD30>,
> +				<&cmu_top CLK_DIV_SCLK_USBDRD30>;
> +			assigned-clock-parents =
> +				<&cmu_top CLK_SCLK_USBDRD30_FSYS>,
> +				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
> +			assigned-clock-rates = <0>, <0>, <66700000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +

Ditto, the node has unit address but no reg property.

> +			dwc3 {
> +				compatible = "snps,dwc3";
> +				reg = <0x15400000 0x10000>;

Ditto, the node doesn't have a unit address but has reg property.

> +				interrupts = <0 231 0>;
> +				phys = <&usbdrd30_phy 0>, <&usbdrd30_phy 1>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
> +
> +
> +		usbhost30: usb at 15a00000 {
> +			compatible = "samsung,exynos5250-dwusb3";
> +			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
> +				<&cmu_fsys CLK_SCLK_USBHOST30>;
> +			clock-names = "usbdrd30", "usbdrd30_susp_clk";
> +			assigned-clocks =
> +				<&cmu_fsys CLK_MOUT_SCLK_USBHOST30_USER>,
> +				<&cmu_top CLK_MOUT_SCLK_USBHOST30>,
> +				<&cmu_top CLK_DIV_SCLK_USBHOST30>;
> +			assigned-clock-parents =
> +				<&cmu_top CLK_SCLK_USBHOST30_FSYS>,
> +				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
> +			assigned-clock-rates = <0>, <0>, <66700000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +

Ditto, the node has unit address but no reg property.

> +			usbdrd_dwc3_0: dwc3 {
> +				compatible = "snps,dwc3";
> +				reg = <0x15a00000 0x10000>;

Ditto, the node doesn't have a unit address but has reg property.

> +				interrupts = <0 244 0>;
> +				phys = <&usbhost30_phy 0>, <&usbhost30_phy 1>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
> +

[snip]

> +		audio-subsystem {
> +			compatible = "samsung,exynos5433-lpass";
> +			reg = <0x11400000 0x100>, <0x11500000 0x08>;

Ditto, the node doesn't have a unit address but has reg property.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

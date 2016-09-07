From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 7 Sep 2016 09:55:09 +0200
Subject: [PATCH v2 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <57C95B88.80909@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
 <CGME20160826174936epcas1p3e0fe5d9cd14e17aba25c3109ba899e83@epcas1p3.samsung.com>
 <4341f429-64a9-b14c-aeca-d61aac2ee81d@osg.samsung.com>
 <57C95B88.80909@samsung.com>
Message-ID: <38902a3f-6f9d-3a74-f082-dc44afdf928e@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chanwoo,

On 09/02/2016 12:59 PM, Chanwoo Choi wrote:
> Hi Javier,
> 
> On 2016? 08? 27? 02:49, Javier Martinez Canillas wrote:
>> Hello Chanwoo,
>>

[snip]

>>
>>> +		mipi_phy: video-phy at 105C0708 {
>>> +			compatible = "samsung,exynos5433-mipi-video-phy";
>>> +			#phy-cells = <1>;
>>> +			samsung,pmu-syscon = <&pmu_system_controller>;
>>> +			samsung,cam0-sysreg = <&syscon_cam0>;
>>> +			samsung,cam1-sysreg = <&syscon_cam1>;
>>> +			samsung,disp-sysreg = <&syscon_disp>;
>>> +		};
>>
>> This node has a unit name but it doesn't have a reg property so dtc will
>> warn about the mismatch when executed with W=1.
> 
> The mipi_phy address are included in the PMU (base 0x105c_0000).
> There is no memory map for only MIPI_PHY. Instead, the mipi_phy driver[1]
> uses the regmap (pmu, syscon_cam0/1/disp).
> [1] drivers/phy/phy-exynos-mipi-video.c don't use
>
> Also, the first MIPI_PHY's address is 0x105c0710. I'll fix it.
> 
> If you want to add the 'reg' property, I can add DT node as following:
> 
> 	mipi_phy: video-phy at 105c0710 {
> 		reg = <0x105c0710 0x0>;
> 		compatible = "samsung,exynos5433-mipi-video-phy";
> 		...
> 	};
> 
> But it looks strange because the mipi_phy driver[1] never gets
> the base address with of_iomap().
>

The DT should describe the actual HW regardless of the driver implementation.

I'm not sure what's the correct way to handle this (i.e: adding an unused reg
property or not having a unit name) but the mismatch should be fixed to avoid
dtc to complain about it.

>>
>> [snip]
>>
>>> +		usbdrd30: usb at 15400000 {
>>> +			compatible = "samsung,exynos5250-dwusb3";
>>> +			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
>>> +				<&cmu_fsys CLK_SCLK_USBDRD30>;
>>> +			clock-names = "usbdrd30", "usbdrd30_susp_clk";
>>> +			assigned-clocks =
>>> +				<&cmu_fsys CLK_MOUT_SCLK_USBDRD30_USER>,
>>> +				<&cmu_top CLK_MOUT_SCLK_USBDRD30>,
>>> +				<&cmu_top CLK_DIV_SCLK_USBDRD30>;
>>> +			assigned-clock-parents =
>>> +				<&cmu_top CLK_SCLK_USBDRD30_FSYS>,
>>> +				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
>>> +			assigned-clock-rates = <0>, <0>, <66700000>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges;
>>> +			status = "disabled";
>>> +
>>
>> Ditto, the node has unit address but no reg property.
> 
> The usbdrd[2] driver don't map the base address.
> So, this DT node don't include any code calling the of_iomap().
> [2] drivers/usb/dwc3/dwc3-exynos.c
>

Same comment than above.

> But, the usbdrd's base address is 0x15400000.
> 
>>
>>> +			dwc3 {
>>> +				compatible = "snps,dwc3";
>>> +				reg = <0x15400000 0x10000>;
>>
>> Ditto, the node doesn't have a unit address but has reg property.
> 
> OK. I'll modify it as following:
> 			dwc3 at 15400000 {
>

Ok.

>>
>>> +				interrupts = <0 231 0>;
>>> +				phys = <&usbdrd30_phy 0>, <&usbdrd30_phy 1>;
>>> +				phy-names = "usb2-phy", "usb3-phy";
>>> +			};
>>> +		};
>>> +
>>> +
>>> +		usbhost30: usb at 15a00000 {
>>> +			compatible = "samsung,exynos5250-dwusb3";
>>> +			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
>>> +				<&cmu_fsys CLK_SCLK_USBHOST30>;
>>> +			clock-names = "usbdrd30", "usbdrd30_susp_clk";
>>> +			assigned-clocks =
>>> +				<&cmu_fsys CLK_MOUT_SCLK_USBHOST30_USER>,
>>> +				<&cmu_top CLK_MOUT_SCLK_USBHOST30>,
>>> +				<&cmu_top CLK_DIV_SCLK_USBHOST30>;
>>> +			assigned-clock-parents =
>>> +				<&cmu_top CLK_SCLK_USBHOST30_FSYS>,
>>> +				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
>>> +			assigned-clock-rates = <0>, <0>, <66700000>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges;
>>> +			status = "disabled";
>>> +
>>
>> Ditto, the node has unit address but no reg property.
> 
> This case is same with above 'usbdrd30'.
>

Same comment than above. The DT shouldn't leak Linux implementation details.

>>
>>> +			usbdrd_dwc3_0: dwc3 {
>>> +				compatible = "snps,dwc3";
>>> +				reg = <0x15a00000 0x10000>;
>>
>> Ditto, the node doesn't have a unit address but has reg property.
> 
> I'll modify it as following:
> 			usbdrd_dwc3_0: dwc3 at 15a00000 {
> 
>>
>>> +				interrupts = <0 244 0>;
>>> +				phys = <&usbhost30_phy 0>, <&usbhost30_phy 1>;
>>> +				phy-names = "usb2-phy", "usb3-phy";
>>> +			};
>>> +		};
>>> +
>>
>> [snip]
>>
>>> +		audio-subsystem {
> 
> I'll modify it as following:
> 		audio-subsystem at 11400000 {
>

Ok.

>>> +			compatible = "samsung,exynos5433-lpass";
>>> +			reg = <0x11400000 0x100>, <0x11500000 0x08>;
>>
>> Ditto, the node doesn't have a unit address but has reg property.
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Thanks for your review.
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

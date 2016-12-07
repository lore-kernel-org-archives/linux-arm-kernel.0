From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 07 Dec 2016 18:09:16 +0100
Subject: [PATCH 4/9] arm64: dts: rockchip: support dwc3 USB for rk3399
In-Reply-To: <1480645653-36943-5-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <1480645653-36943-5-git-send-email-briannorris@chromium.org>
Message-ID: <2947180.ggfADt6cbn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Am Donnerstag, 1. Dezember 2016, 18:27:28 CET schrieb Brian Norris:
> Add the dwc3 usb needed node information for rk3399.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Somewhat rewritten from Caesar's reposting (v2) of my patch.
> 
> Changes:
>  * Include USB2 PHY (which is now in -next)
>  * Don't include USB3 PHY, as extcon support is not ready yet
>  * Drop non-upstream properties
>  * Fixup whitespace a bit
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 60
> ++++++++++++++++++++++++++++++++ 1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 4ca8f9a7601c..1e97fb8c6415
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -316,6 +316,66 @@
>  		};
>  	};
> 
> +	usbdrd3_0: usb at fe800000 {

insert location above usb at fe380000 is sorted wrong

> +		compatible = "rockchip,rk3399-dwc3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> +			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> +		clock-names = "clk_usb3otg0_ref", "clk_usb3otg0_suspend",
> +			      "aclk_usb3otg0", "aclk_usb3_rksoc_axi_perf",
> +			      "aclk_usb3", "aclk_usb3_grf";

clock-names do not match binding. The dwc3-of-simple does not care, as it just 
enables all of them it seems, but binding doc states the clock names as

- clock-names:  Should contain the following:
  "ref_clk"     Controller reference clk, have to be 24 MHz
  "suspend_clk" Controller suspend clk, have to be 24 MHz or 32 KHz
  "bus_clk"     Master/Core clock, have to be >= 62.5 MHz for SS
                operation and >= 30MHz for HS operation
  "grf_clk"     Controller grf clk

> +		resets = <&cru SRST_A_USB3_OTG0>;
> +		reset-names = "usb3-otg";

you could update the binding documentation to list this one.


Heiko

> +		status = "disabled";
> +
> +		usbdrd_dwc3_0: dwc3 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfe800000 0x0 0x100000>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> +			dr_mode = "otg";
> +			phys = <&u2phy0_otg>;
> +			phy-names = "usb2-phy";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-u2-freeclk-exists-quirk;
> +			snps,dis_u2_susphy_quirk;
> +			snps,dis-del-phy-power-chg-quirk;
> +			status = "disabled";
> +		};
> +	};
> +
> +	usbdrd3_1: usb at fe900000 {
> +		compatible = "rockchip,rk3399-dwc3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
> +			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
> +			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
> +		clock-names = "clk_usb3otg1_ref", "clk_usb3otg1_suspend",
> +			      "aclk_usb3otg1", "aclk_usb3_rksoc_axi_perf",
> +			      "aclk_usb3", "aclk_usb3_grf";
> +		resets = <&cru SRST_A_USB3_OTG1>;
> +		reset-names = "usb3-otg";
> +		status = "disabled";
> +
> +		usbdrd_dwc3_1: dwc3 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfe900000 0x0 0x100000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
> +			dr_mode = "otg";
> +			phys = <&u2phy1_otg>;
> +			phy-names = "usb2-phy";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-u2-freeclk-exists-quirk;
> +			snps,dis_u2_susphy_quirk;
> +			snps,dis-del-phy-power-chg-quirk;
> +			status = "disabled";
> +		};
> +	};
> +
>  	usb_host0_ehci: usb at fe380000 {
>  		compatible = "generic-ehci";
>  		reg = <0x0 0xfe380000 0x0 0x20000>;

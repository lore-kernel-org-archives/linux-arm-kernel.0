From: briannorris@chromium.org (Brian Norris)
Date: Wed, 30 Nov 2016 14:28:26 -0800
Subject: [PATCH v2 8/9] arm64: dts: rockchip: support dwc3 USB for rk3399
In-Reply-To: <1478697721-2323-9-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
 <1478697721-2323-9-git-send-email-wxt@rock-chips.com>
Message-ID: <20161130222825.GA71883@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Felipe, Arnd, others

Hi Caesar,

On Wed, Nov 09, 2016 at 09:22:00PM +0800, Caesar Wang wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> Add the dwc3 usb needed node information for rk3399.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Note that none of this can work yet (at least for host mode, which I've
been testing), because DWC3 still hasn't been patched for ARM64 support.
It's been 7+ months and multiple people have tried to patch the issue,
but nothing has been merged.

See for instance:

usb: dwc3: host: inherit dma configuration from parent dev
https://lkml.org/lkml/2016/4/25/813
https://lkml.org/lkml/2016/5/5/391

Thread was resurrected in September:
https://lkml.org/lkml/2016/9/1/715
but there's still no end in sight. Maybe the following is the latest
incarnation?

[PATCH v2 0/6] inherit dma configuration from parent dev
https://www.mail-archive.com/linux-usb at vger.kernel.org/msg82369.html

I guess nothing prevents a valid device tree being merged here, but it's
severely limited by the above bug still, so I just wanted to call
attention to it.

(Let me guess: you've still been testing an internal non-upstream tree
that has this patched already, Caesar?)

> ---
> 
> Changes in v2:
> - the original patches from brian posting on
>   https://chromium-review.googlesource.com/343603
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 09ebf4e..3659c56 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -353,6 +353,60 @@
>  		status = "disabled";
>  	};
>  
> +	usbdrd3_0: usb at fe800000 {
> +		compatible = "rockchip,rk3399-dwc3";
> +		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk", "grf_clk";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +		usbdrd_dwc3_0: dwc3 at fe800000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfe800000 0x0 0x100000>;
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> +			dr_mode = "otg";
> +			phys = <&tcphy0_usb3>;
> +			phy-names = "usb3-phy";

The USB3/TypeC PHY won't probe without extcon support, and no rk3399
platforms have proper extcon support upstream AFAIK, right? Seems like
it'd be better to leave this phy property off for now, with the hope of
at least getting USB2 working. We can add it later once somebody proves
USB3 support upstream.

> +			phy_type = "utmi_wide";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-u2-freeclk-exists-quirk;
> +			snps,dis_u2_susphy_quirk;
> +			snps,dis-del-phy-power-chg-quirk;
> +			snps,xhci-slow-suspend-quirk;

This property isn't supported upstream. Seems like we should drop it for
now.

Same comments on the other DWC3 instance below, of course.

Brian

> +			status = "disabled";
> +		};
> +	};
> +
> +	usbdrd3_1: usb at fe900000 {
> +		compatible = "rockchip,rk3399-dwc3";
> +		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
> +			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk", "grf_clk";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +		usbdrd_dwc3_1: dwc3 at fe900000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xfe900000 0x0 0x100000>;
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
> +			dr_mode = "host";
> +			phys = <&tcphy1_usb3>;
> +			phy-names = "usb3-phy";
> +			phy_type = "utmi_wide";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-u2-freeclk-exists-quirk;
> +			snps,dis_u2_susphy_quirk;
> +			snps,dis-del-phy-power-chg-quirk;
> +			snps,xhci-slow-suspend-quirk;
> +			status = "disabled";
> +		};
> +	};
> +
>  	gic: interrupt-controller at fee00000 {
>  		compatible = "arm,gic-v3";
>  		#interrupt-cells = <4>;
> -- 
> 2.7.4
> 

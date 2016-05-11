From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 11 May 2016 09:17:38 +0800
Subject: [PATCH 1/2] ARM64: dts: rockchip: add sdhci/emmc for rk3399
In-Reply-To: <1462924975-69072-1-git-send-email-briannorris@chromium.org>
References: <1462924975-69072-1-git-send-email-briannorris@chromium.org>
Message-ID: <3e257ce2-056a-592a-9481-970da1fe0627@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Huang Lin

On 2016/5/11 8:02, Brian Norris wrote:
> The bindings for rk3399's SDHCI + eMMC PHY have been accepted, so let's
> support eMMC now.
>
> Note that 'rockchip,rk3399-sdhci-5.1' is not documented, but per Heiko's
> previous suggestion, we don't want to clutter the arasan doc, and it's
> just a precautionary measure to have it.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 46f325a143b0..947d1221592d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -215,6 +215,17 @@
>  		status = "disabled";
>  	};
>
> +	sdhci: sdhci at fe330000 {
> +		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> +		reg = <0x0 0xfe330000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;

sdhci doesn't call clk_set_rate to explicitly assign clk_xin to 200MHz
as it always assumes sdhci controller should meet the highest speed of
each timing mode. And the internal divider will be used. So IMHO,
clk-rockchip for 3399 *haven't* made clk_xin to be 200MHz. Let's assign
the clk stuff to make sure it's 200MHz.

Another problem is that emmc_phy contains a configuration which should
be consistent with clk_out(namely clk_xin/internal dividor). Now I don't
submit unpstream patchset to expose these configurarion, but in
prevention of some misleading, I think it's better to to it.

How about adding these?

assigned-clocks = <&cru SCLK_EMMC>;
assigned-clock-parents = <&cru PLL_CPLL>; //may not need
assigned-clock-rates = <200000000>;

Still you limit your clk_out by adding max-frequency in dts for
specific requirment.

We here manually assigne the clk_xin to be 200MHz, so defaultly
when it's runing in HS200/HS400(ES) mode, internal divider won't
be used(by-pass mode). So the clk jitter is better when by-passing the
clock.

Thanks.

> +		clock-names = "clk_xin", "clk_ahb";
> +		phys = <&emmc_phy>;
> +		phy-names = "phy_arasan";
> +		status = "disabled";
> +	};
> +
>  	usb_host0_ehci: usb at fe380000 {
>  		compatible = "generic-ehci";
>  		reg = <0x0 0xfe380000 0x0 0x20000>;
> @@ -481,8 +492,18 @@
>  	};
>
>  	grf: syscon at ff770000 {
> -		compatible = "rockchip,rk3399-grf", "syscon";
> +		compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
>  		reg = <0x0 0xff770000 0x0 0x10000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		emmc_phy: phy at f780 {
> +			compatible = "rockchip,rk3399-emmc-phy";
> +			reg = <0xf780 0x20>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
>  	};
>
>  	watchdog at ff840000 {
>


-- 
Best Regards
Shawn Lin

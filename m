From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 31 Aug 2016 00:07:51 +0200
Subject: [PATCH 3/4] arm64: dts: rockchip: support gmac for rk3399
In-Reply-To: <1472589008-7713-4-git-send-email-wxt@rock-chips.com>
References: <1472589008-7713-1-git-send-email-wxt@rock-chips.com>
 <1472589008-7713-4-git-send-email-wxt@rock-chips.com>
Message-ID: <1912883.KWCSTxJEHB@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 31. August 2016, 04:30:06 schrieb Caesar Wang:
> This patch adds needed gamc information for rk3399,
> also support the gmac pd.
> 
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 90
> ++++++++++++++++++++++++++++++++ 1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 32aebc8..53ac651 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -200,6 +200,26 @@
>  		};
>  	};
> 
> +	gmac: eth at fe300000 {
> +		compatible = "rockchip,rk3399-gmac";
> +		reg = <0x0 0xfe300000 0x0 0x10000>;
> +		rockchip,grf = <&grf>;

should move below the reset-names .

> +		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "macirq";
> +		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
> +			 <&cru SCLK_MAC_TX>, <&cru SCLK_MACREF>,
> +			 <&cru SCLK_MACREF_OUT>, <&cru ACLK_GMAC>,
> +			 <&cru PCLK_GMAC>;
> +		clock-names = "stmmaceth", "mac_clk_rx",
> +			      "mac_clk_tx", "clk_mac_ref",
> +			      "clk_mac_refout", "aclk_mac",
> +			      "pclk_mac";
> +		resets = <&cru SRST_A_GMAC>;
> +		reset-names = "stmmaceth";
> +		power-domains = <&power RK3399_PD_GMAC>;

The driver core should handle regular power-domain handling on device creation 
already, right? So I should be able to apply patches 3 and 4 even without the 
dwmac patches, right?

Also if resending please move power-domains above resets


Heiko

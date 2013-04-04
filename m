From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 4 Apr 2013 23:35:17 +0200
Subject: [PATCH 3/5 v2] ARM: kirkwood: add device node entries for the
 gigabit interfaces
In-Reply-To: <1365071235-11611-4-git-send-email-florian@openwrt.org>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1365071235-11611-4-git-send-email-florian@openwrt.org>
Message-ID: <20130404213517.GB25904@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Thu, Apr 04, 2013 at 12:27:13PM +0200, Florian Fainelli wrote:
> This patch modifies kirkwood.dtsi to specify the various gigabit
> interfaces nodes available on kirkwood devices. They are disabled by
> default and should be enabled on a per-board basis. egiga0 and egiga1
> aliases are defined for convenience. The mdio node is also present and
> should be enabled on a per-board basis as well.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Changes since v1:
> - dropped change to arch/arm/mach-kirkwood/common.c to avoid merge conflicts

I think we should remove the clock aliases in
kirkwood_legacy_clk_init() in mach-kirkwood/dt-board.c (once we have
proper clock support, see my other mail).

> - fixed off-by 0x2000 ethernet-group nodes address
> 
>  arch/arm/boot/dts/kirkwood.dtsi |   46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index fada7e6..254f5a8 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -7,6 +7,8 @@
>  	aliases {
>  	       gpio0 = &gpio0;
>  	       gpio1 = &gpio1;
> +	       egiga0 = &egiga0;
> +	       egiga1 = &egiga1;
>  	};
>  	intc: interrupt-controller {
>  		compatible = "marvell,orion-intc", "marvell,intc";
> @@ -202,5 +204,49 @@
>  			clocks = <&gate_clk 4>;
>  			status = "disabled";
>  		};
> +
> +		mdio at 72004 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "marvell,orion-mdio";
> +			reg = <0x72004 0x84>;

Don't we need to add:

			interrupts = <46>;

here?


- Simon

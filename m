From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Sep 2016 09:29:33 +0200
Subject: [PATCH v3 5/9] ARM: dts: sun8i-h3: add sun8i-emac ethernet driver
In-Reply-To: <1473425117-18645-6-git-send-email-clabbe.montjoie@gmail.com>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-6-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160912072933.GC9449@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 02:45:13PM +0200, Corentin Labbe wrote:
> The sun8i-emac is an ethernet MAC hardware that support 10/100/1000
> speed.
> 
> This patch enable the sun8i-emac on the Allwinner H3 SoC Device-tree.
> The SoC H3 have an internal PHY, so optionals syscon and ephy are set.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index a39da6f..a3ac476 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -50,6 +50,10 @@
>  / {
>  	interrupt-parent = <&gic>;
>  
> +	aliases {
> +		ethernet0 = &emac;
> +	};
> +

This needs to be done at the board level.

>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -446,6 +450,21 @@
>  			status = "disabled";
>  		};
>  
> +		emac: ethernet at 1c30000 {
> +			compatible = "allwinner,sun8i-h3-emac";
> +			syscon = <&syscon>;
> +			reg = <0x01c30000 0x104>;
> +			reg-names = "emac";

You don't need reg-names anymore.

> +			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&ccu RST_BUS_EMAC>, <&ccu RST_BUS_EPHY>;
> +			reset-names = "ahb", "ephy";
> +			clocks = <&ccu CLK_BUS_EMAC>, <&ccu CLK_BUS_EPHY>;
> +			clock-names = "ahb", "ephy";

I still believe that having the same node for both the PHY and the MAC
is wrong.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160912/011b2815/attachment.sig>

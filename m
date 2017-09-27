From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Sep 2017 12:16:22 +0200
Subject: [PATCH v6 06/11] ARM: dts: sunxi: h3/h5: represent the mdio
 switch used by sun8i-h3-emac
In-Reply-To: <20170927073414.17361-7-clabbe.montjoie@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-7-clabbe.montjoie@gmail.com>
Message-ID: <20170927101622.v7odmreccwh7ldg2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 07:34:09AM +0000, Corentin Labbe wrote:
> Since dwmac-sun8i could use either an integrated PHY or an external PHY
> (which could be at same MDIO address), we need to represent this selection
> by a MDIO switch.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 3b7d953429a6..a8e9b8f378ba 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -422,14 +422,33 @@
>  			#size-cells = <0>;
>  			status = "disabled";
>  
> -			mdio: mdio {
> +			mdio0: mdio {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				int_mii_phy: ethernet-phy at 1 {
> -					compatible = "ethernet-phy-ieee802.3-c22";
> -					reg = <1>;
> -					clocks = <&ccu CLK_BUS_EPHY>;
> -					resets = <&ccu RST_BUS_EPHY>;
> +				compatible = "snps,dwmac-mdio";
> +
> +				mdio-mux {
> +					compatible = "mdio-mux";
> +					#address-cells = <1>;
> +					#size-cells = <0>;

Newline

> +					/* Only one MDIO is usable at the time */
> +					internal_mdio: mdio at 1 {
> +						reg = <1>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;

Newline

> +						int_mii_phy: ethernet-phy at 1 {
> +							compatible = "ethernet-phy-ieee802.3-c22";
> +							reg = <1>;
> +							clocks = <&ccu CLK_BUS_EPHY>;
> +							resets = <&ccu RST_BUS_EPHY>;
> +							phy-is-integrated;
> +						};
> +					};

Newline

> +					mdio: mdio at 2 {

This is quite confusing. Why not call the label external_mdio?

Thanks

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170927/dc5d60e0/attachment.sig>

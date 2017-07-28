From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Jul 2017 17:44:51 +0800
Subject: [PATCH 2/3] ARM: sunxi: h3/h5: Add sun8i-h3-ephy compatible
In-Reply-To: <20170728092818.23419-3-clabbe.montjoie@gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728092818.23419-3-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v67Lt5whR4=6+SDc=Ooi6zyiHuprW+7zbPh0njnKOCiFFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 5:28 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> This patch adds the sun8i-h3-ephy compatible to the internal PHY.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 3 ++-

To avoid repeating the past, this patch, if approved, will be merged
through the sunxi tree, not netdev nor net-next.

>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 4b599b5d26f6..7aaa837c2388 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -421,7 +421,8 @@
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>                                 int_mii_phy: ethernet-phy at 1 {
> -                                       compatible = "ethernet-phy-ieee802.3-c22";
> +                                       compatible = "allwinner,sun8i-h3-ephy",
> +                                                       "ethernet-phy-ieee802.3-c22";

Are you expecting people to override this properly?

As it currently is, any external phy at address 1 will simply
reuse the same device node. And if they don't override the
property correctly, the driver will end up trying to use
the internal phy, while the user is expecting the external
one to be used.

Maybe you could move this to some other address, maybe the last
valid one, or second last valid one?

ChenYu

>                                         reg = <1>;
>                                         clocks = <&ccu CLK_BUS_EPHY>;
>                                         resets = <&ccu RST_BUS_EPHY>;
> --
> 2.13.0
>

From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 21:00:32 +0800
Subject: [PATCH 75/77] ARM: dts: sun8i: r40: Fix Display Engine DTC
 warnings
In-Reply-To: <0cc6a433b87160e3559412c1cc1f96da7cff79be.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <0cc6a433b87160e3559412c1cc1f96da7cff79be.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64dKGLf+sUHRonstpLC76vYzz+kX-9Hd4qktzdjwM4Apg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our display engine endpoints trigger some DTC warnings due to the fact that
> we're having a single endpoint that doesn't need any reg property, and
> since we don't have a reg property, we don't need the address-cells and
> size-cells properties anymore.
>
> Fix those
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 6f4c9ca5a3ee..0a5ca0168a0c 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -587,12 +587,9 @@
>                                 #size-cells = <0>;
>
>                                 tcon_top_mixer0_in: port at 0 {
> -                                       #address-cells = <1>;
> -                                       #size-cells = <0>;
>                                         reg = <0>;
>
> -                                       tcon_top_mixer0_in_mixer0: endpoint at 0 {
> -                                               reg = <0>;
> +                                       tcon_top_mixer0_in_mixer0: endpoint {
>                                                 remote-endpoint = <&mixer0_out_tcon_top>;
>                                         };
>                                 };

So it doesn't complain for tcon_top_mixer1_in, which also only has
one child node? The reg property in both these nodes are used to
identify which mixer is connected. We need to teach the sun8i-mixer
driver to deal with an absent reg property first.

ChenYu

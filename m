From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 14 Jun 2018 22:39:56 +0530
Subject: [linux-sunxi] [PATCH v3 4/4] arm64: dts: allwinner: a64: add SRAM
 controller device tree node
In-Reply-To: <20180614153548.9644-5-wens@csie.org>
References: <20180614153548.9644-1-wens@csie.org>
 <20180614153548.9644-5-wens@csie.org>
Message-ID: <CAMty3ZARNpBOQKvS7knH8kWE2+bvjuJoAA4cFGZK8+GzTUQ5zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 9:05 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Allwinner A64 has a SRAM controller, and in the device tree currently
> we have a syscon node to enable EMAC driver to access the EMAC clock
> register. As SRAM controller driver can now export regmap for this
> register, replace the syscon node to the SRAM controller device node,
> and let EMAC driver to acquire its EMAC clock regmap.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> [wens at csie.org: Updated compatible string]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1b2ef28c42bd..87968dafe1dc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -169,9 +169,24 @@
>                 ranges;
>
>                 syscon: syscon at 1c00000 {
> -                       compatible = "allwinner,sun50i-a64-system-controller",
> -                               "syscon";
> +                       compatible = "allwinner,sun50i-a64-system-control";
>                         reg = <0x01c00000 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       sram_c: sram at 18000 {
> +                               compatible = "mmio-sram";
> +                               reg = <0x00018000 0x28000>;
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges = <0 0x00018000 0x28000>;
> +
> +                               de2_sram: sram-section at 0 {

So, this can attach to display-engine node through allwinner,sram and
add support to claim the sram on sun4i/sun4i_drv.c, correct?

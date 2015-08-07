From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 8 Aug 2015 00:21:17 +0800
Subject: [PATCH v2 5/7] ARM: sun8i: Add clock indices
In-Reply-To: <1438364782-3968-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1438364782-3968-1-git-send-email-maxime.ripard@free-electrons.com>
 <1438364782-3968-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64nvA1K=Ya7_99-2G1LtFjcuj+qQbO1GJaqsL+yPF+Xdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 1, 2015 at 1:46 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A23 and A33 gates have a non continuous set of clock IDs that are
> valid. Add the clock-indices property to the DT to express this.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 7abd0ae3143d..c318c770b6c1 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -180,6 +180,15 @@
>                         compatible = "allwinner,sun8i-a23-ahb1-gates-clk";
>                         reg = <0x01c20060 0x8>;
>                         clocks = <&ahb1>;
> +                       clock-indices = <1>, <6>,

Turns out the A33 (and I assume the same with the A23) has
an ahb1 clock gate for the Security System at clock-index <5>.

This is found in the updated A33 user manual.

> +                                       <8>, <9>, <10>,
> +                                       <13>, <14>,
> +                                       <19>, <20>,
> +                                       <21>, <24>, <26>,
> +                                       <29>, <32>, <36>,
> +                                       <40>, <44>, <46>,
> +                                       <52>, <54>,

<53> is ahb1 clock gate for msgbox, again found in A33 manual.

> +                                       <57>;

<58> is ahb1 clock gate for SAT, which seems to be part of the
display pipeline.

>                         clock-output-names = "ahb1_mipidsi", "ahb1_dma",
>                                         "ahb1_mmc0", "ahb1_mmc1", "ahb1_mmc2",
>                                         "ahb1_nand", "ahb1_sdram",
> @@ -196,6 +205,8 @@
>                         compatible = "allwinner,sun8i-a23-apb1-gates-clk";
>                         reg = <0x01c20068 0x4>;
>                         clocks = <&apb1>;
> +                       clock-indices = <0>, <5>,
> +                                       <12>, <13>;
>                         clock-output-names = "apb1_codec", "apb1_pio",
>                                         "apb1_daudio0", "apb1_daudio1";
>                 };
> @@ -213,6 +224,10 @@
>                         compatible = "allwinner,sun8i-a23-apb2-gates-clk";
>                         reg = <0x01c2006c 0x4>;
>                         clocks = <&apb2>;
> +                       clock-indices = <0>, <1>,
> +                                       <2>, <16>,
> +                                       <17>, <18>,
> +                                       <19>, <20>;
>                         clock-output-names = "apb2_i2c0", "apb2_i2c1",
>                                         "apb2_i2c2", "apb2_uart0",
>                                         "apb2_uart1", "apb2_uart2",
> --
> 2.4.6
>

Not sure if you want to add the clocks I mentioned together
in this patch, or do a separate patch.

The rest look good.

ChenYu

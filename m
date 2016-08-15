From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 15 Aug 2016 20:40:08 +0200
Subject: [PATCH] clk: gxbb: add MMC gate clocks, and expose for DT
In-Reply-To: <20160802214011.19077-1-khilman@baylibre.com>
References: <20160802214011.19077-1-khilman@baylibre.com>
Message-ID: <CAFBinCDaow3au1an8yKbVV3qNkzpjXsFOD-cUdRT+KOm-FGVJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 2, 2016 at 11:40 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Add the SD/eMMC gate clocks and expose them for use by DT.
>
> While at it, also explose FCLK_DIV2 since this is one of the input
> clocks to the mux internal to each of the SD/eMMC blocks.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
my Meson8b / GXBB DWMAC glue series needs this as well.
This worked fine during my tests, so:

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
> Applies on top of current clk-s905 branch.
>
>  drivers/clk/meson/gxbb.c              | 9 +++++++++
>  drivers/clk/meson/gxbb.h              | 7 +++++--
>  include/dt-bindings/clock/gxbb-clkc.h | 4 ++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 007b7157cf4b..4fc8e58feef9 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -581,6 +581,9 @@ static MESON_GATE(sdio, HHI_GCLK_MPEG0, 17);
>  static MESON_GATE(abuf, HHI_GCLK_MPEG0, 18);
>  static MESON_GATE(hiu_iface, HHI_GCLK_MPEG0, 19);
>  static MESON_GATE(assist_misc, HHI_GCLK_MPEG0, 23);
> +static MESON_GATE(emmc_a, HHI_GCLK_MPEG0, 24);
> +static MESON_GATE(emmc_b, HHI_GCLK_MPEG0, 25);
> +static MESON_GATE(emmc_c, HHI_GCLK_MPEG0, 26);
>  static MESON_GATE(spi, HHI_GCLK_MPEG0, 30);
>
>  static MESON_GATE(i2s_spdif, HHI_GCLK_MPEG1, 2);
> @@ -746,6 +749,9 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
>                 [CLKID_AO_AHB_BUS]          = &gxbb_ao_ahb_bus.hw,
>                 [CLKID_AO_IFACE]            = &gxbb_ao_iface.hw,
>                 [CLKID_AO_I2C]              = &gxbb_ao_i2c.hw,
> +               [CLKID_SD_EMMC_A]           = &gxbb_emmc_a.hw,
> +               [CLKID_SD_EMMC_B]           = &gxbb_emmc_b.hw,
> +               [CLKID_SD_EMMC_C]           = &gxbb_emmc_c.hw,
>         },
>         .num = NR_CLKS,
>  };
> @@ -845,6 +851,9 @@ static struct clk_gate *gxbb_clk_gates[] = {
>         &gxbb_ao_ahb_bus,
>         &gxbb_ao_iface,
>         &gxbb_ao_i2c,
> +       &gxbb_emmc_a,
> +       &gxbb_emmc_b,
> +       &gxbb_emmc_c,
>  };
>
>  static int gxbb_clkc_probe(struct platform_device *pdev)
> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
> index a2adf3448b59..217df516de44 100644
> --- a/drivers/clk/meson/gxbb.h
> +++ b/drivers/clk/meson/gxbb.h
> @@ -172,7 +172,7 @@
>  /* CLKID_CPUCLK */
>  #define CLKID_HDMI_PLL           2
>  #define CLKID_FIXED_PLL                  3
> -#define CLKID_FCLK_DIV2                  4
> +/* CLKID_FCLK_DIV2 */
>  #define CLKID_FCLK_DIV3                  5
>  #define CLKID_FCLK_DIV4                  6
>  #define CLKID_FCLK_DIV5                  7
> @@ -262,8 +262,11 @@
>  #define CLKID_AO_AHB_BUS         91
>  #define CLKID_AO_IFACE           92
>  #define CLKID_AO_I2C             93
> +/* CLKID_SD_EMMC_A */
> +/* CLKID_SD_EMMC_B */
> +/* CLKID_SD_EMMC_C */
>
> -#define NR_CLKS                          94
> +#define NR_CLKS                          97
>
>  /* include the CLKIDs that have been made part of the stable DT binding */
>  #include <dt-bindings/clock/gxbb-clkc.h>
> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
> index f889d80246cb..7d418643cdcc 100644
> --- a/include/dt-bindings/clock/gxbb-clkc.h
> +++ b/include/dt-bindings/clock/gxbb-clkc.h
> @@ -6,7 +6,11 @@
>  #define __GXBB_CLKC_H
>
>  #define CLKID_CPUCLK           1
> +#define CLKID_FCLK_DIV2                4
>  #define CLKID_CLK81            12
>  #define CLKID_ETH              36
> +#define CLKID_SD_EMMC_A                94
> +#define CLKID_SD_EMMC_B                95
> +#define CLKID_SD_EMMC_C                96
>
>  #endif /* __GXBB_CLKC_H */
> --
> 2.9.0
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

From: codekipper@gmail.com (Code Kipper)
Date: Mon, 4 Dec 2017 08:23:43 +0100
Subject: [PATCH 3/9] ASoC: sun8i-codec: Add quirk to specify aif1_lrck_div
 value
In-Reply-To: <20171203204157.20829-4-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-4-anarsoul@gmail.com>
Message-ID: <CAEKpxB=AmHqZwX+QhCTdNofsVdfVaXHy7fSYRMmDCp5CgBjXVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2017 at 21:41, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> LRCK divider for A64 differs from A33, so add a quirk to support that.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index 3dd183be08a4..054201d1de03 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/of_device.h>
>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -75,11 +76,22 @@
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK  GENMASK(8, 6)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK  GENMASK(12, 9)
>
> +/*
> + * struct sun8i_codec_quirks - Differences between SoC variants.
> + *
> + * @aif1_lrck_div: LRCK divider
> + */
> +struct sun8i_codec_quirks {
> +       unsigned int    aif1_lrck_div;
> +};
> +
> +
Extra line
>  struct sun8i_codec {
> -       struct device   *dev;
> -       struct regmap   *regmap;
> -       struct clk      *clk_module;
> -       struct clk      *clk_bus;
> +       struct device                   *dev;
> +       struct regmap                   *regmap;
> +       struct clk                      *clk_module;
> +       struct clk                      *clk_bus;
> +       const struct sun8i_codec_quirks *variant;
>  };
>
>  static int sun8i_codec_runtime_resume(struct device *dev)
> @@ -305,7 +317,7 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
>
>         regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>                            SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
> -                          SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16);
> +                          scodec->variant->aif1_lrck_div);
>
>         sample_rate = sun8i_codec_get_hw_rate(params);
>         if (sample_rate < 0)
> @@ -440,6 +452,10 @@ static const struct regmap_config sun8i_codec_regmap_config = {
>         .cache_type     = REGCACHE_FLAT,
>  };
>
> +static const struct sun8i_codec_quirks sun8i_a33_codec_quirks = {
> +       .aif1_lrck_div  = SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16,
> +};
> +
>  static int sun8i_codec_probe(struct platform_device *pdev)
>  {
>         struct resource *res_base;
> @@ -453,6 +469,13 @@ static int sun8i_codec_probe(struct platform_device *pdev)
>
>         scodec->dev = &pdev->dev;
>
> +       scodec->variant = of_device_get_match_data(&pdev->dev);
> +       if (!scodec->variant) {
> +               dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
> +               return -ENODEV;
> +       }
> +
> +
ditto
>         scodec->clk_module = devm_clk_get(&pdev->dev, "mod");
>         if (IS_ERR(scodec->clk_module)) {
>                 dev_err(&pdev->dev, "Failed to get the module clock\n");
> @@ -524,7 +547,10 @@ static int sun8i_codec_remove(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id sun8i_codec_of_match[] = {
> -       { .compatible = "allwinner,sun8i-a33-codec" },
> +       {
> +               .compatible = "allwinner,sun8i-a33-codec",
> +               .data = &sun8i_a33_codec_quirks,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> --
> 2.15.0
>

From: codekipper@gmail.com (Code Kipper)
Date: Tue, 4 Oct 2016 14:22:26 +0200
Subject: [PATCH 03/14] ASoC: sun4i-i2s: Add apb reset
In-Reply-To: <2c5abe6578c8e4e841cb59357d88ce397551a593.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <2c5abe6578c8e4e841cb59357d88ce397551a593.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <CAEKpxB=K2c128qNWYT1_bt5xB-9ouFzpf=pAAPge1=_JziLFNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 October 2016 at 11:46, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> Add APB deassert function for sun4i-i2s driver.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 687a8f8..f3f7026 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
> @@ -589,6 +590,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>  {
>         struct sun4i_i2s *i2s;
>         struct resource *res;
> +       struct reset_control *reset_apb;
>         void __iomem *regs;
>         int irq, ret;
>
> @@ -626,7 +628,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "Can't get our mod clock\n");
>                 return PTR_ERR(i2s->mod_clk);
>         }
> -
> +
> +       reset_apb = devm_reset_control_get(&pdev->dev, "apb_reset");
> +       if (IS_ERR(reset_apb)) {
> +               dev_err(&pdev->dev, "Can't get apb reset\n");
> +               return PTR_ERR(i2s->mod_clk);
> +       }
> +
> +       ret = reset_control_deassert(reset_apb);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Can't deassert apb reset (%d)\n", ret);
> +               return ret;
> +       }
> +
Is this functionality only required for A31 and onwards?,
CK
>         i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
>         i2s->playback_dma_data.maxburst = 4;
>
> --
> 2.9.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

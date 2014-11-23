From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 23 Nov 2014 13:51:08 +0900
Subject: [PATCH] thermal: exynos: add optional sclk support
In-Reply-To: <1416642356-8694-1-git-send-email-a.kesavan@samsung.com>
References: <1416642356-8694-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAGTfZH1T-pRmETfQUs1Scy1TLfA_DG9fEZGY83my7WVwtujqRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On Sat, Nov 22, 2014 at 4:45 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Exynos7 has a special clock required for the functional operation
> of the TMU that is not present in earlier SoCs. Add support for
> this optional clock and update the binding documentation.
>

Latest Exynos SoC needs the special clocks. It is different part from
previous Exynos SoC.
Exynos3250 must need the special clock for ADC IP like this patch.
So, I sent the smiliar patch[1] to support SCLK as following and merged it.

[1] https://lkml.org/lkml/2014/7/21/734

So, I suggest you that Exynos would use the similar method to support
special clock
on all of IPs for Exynos SoC.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
> This patch was earlier part of the series adding TMU support for
> Exynos7 [1]. It has been split out as it does not impact the on-going
> consolidation in the exynos tmu driver and can be considered
> independently.
>
>  .../devicetree/bindings/thermal/exynos-thermal.txt |    3 +++
>  drivers/thermal/samsung/exynos_tmu.c               |   27 ++++++++++++++++----
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> index ae738f5..2393eac 100644
> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> @@ -32,10 +32,13 @@
>  - clocks : The main clocks for TMU device
>         -- 1. operational clock for TMU channel
>         -- 2. optional clock to access the shared registers of TMU channel
> +       -- 3. optional special clock for functional operation
>  - clock-names : Thermal system clock name
>         -- "tmu_apbif" operational clock for current TMU channel
>         -- "tmu_triminfo_apbif" clock to access the shared triminfo register
>                 for current TMU channel
> +       -- "tmu_sclk" clock for functional operation of the current TMU
> +               channel
>  - vtmu-supply: This entry is optional and provides the regulator node supplying
>                 voltage to TMU. If needed this entry can be placed inside
>                 board/platform specific dts file.
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index d44d91d..6627937 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -128,6 +128,7 @@
>   * @lock: lock to implement synchronization.
>   * @clk: pointer to the clock structure.
>   * @clk_sec: pointer to the clock structure for accessing the base_second.
> + * @sclk: pointer to the clock structure for accessing the tmu special clk.
>   * @temp_error1: fused value of the first point trim.
>   * @temp_error2: fused value of the second point trim.
>   * @regulator: pointer to the TMU regulator structure.
> @@ -147,7 +148,7 @@ struct exynos_tmu_data {
>         enum soc_type soc;
>         struct work_struct irq_work;
>         struct mutex lock;
> -       struct clk *clk, *clk_sec;
> +       struct clk *clk, *clk_sec, *sclk;
>         u8 temp_error1, temp_error2;
>         struct regulator *regulator;
>         struct thermal_sensor_conf *reg_conf;
> @@ -883,10 +884,21 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                 goto err_clk_sec;
>         }
>
> +       data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
> +       if (IS_ERR(data->sclk)) {
> +               dev_err(&pdev->dev, "Failed to get optional special clock\n");

Exynos4, Exynos3250 etc may show error message always. I think It is not proper.
I recommend that you use additional 'needs_sclk' field. If 'needs_sclk' is true,
tmu driver will get the special clock of tmu without error message.

Also, How about just 'sclk' instead of 'tmu_sclk'?
I discussed the name of 'sclk' with Arnd Bergmann on following patch[2]

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/273557.html

> +       } else {
> +               ret = clk_prepare_enable(data->sclk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Failed to enable special clock\n");
> +                       goto err_clk;
> +               }
> +       }
> +
>         ret = exynos_tmu_initialize(pdev);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to initialize TMU\n");
> -               goto err_clk;
> +               goto err_sclk;
>         }
>
>         exynos_tmu_control(pdev, true);
> @@ -896,7 +908,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                                 sizeof(struct thermal_sensor_conf), GFP_KERNEL);
>         if (!sensor_conf) {
>                 ret = -ENOMEM;
> -               goto err_clk;
> +               goto err_sclk;
>         }
>         sprintf(sensor_conf->name, "therm_zone%d", data->id);
>         sensor_conf->read_temperature = (int (*)(void *))exynos_tmu_read;
> @@ -928,7 +940,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>         ret = exynos_register_thermal(sensor_conf);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to register thermal interface\n");
> -               goto err_clk;
> +               goto err_sclk;
>         }
>         data->reg_conf = sensor_conf;
>
> @@ -936,10 +948,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                 IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
> -               goto err_clk;
> +               goto err_sclk;
>         }
>
>         return 0;
> +err_sclk:
> +       if (!IS_ERR(data->sclk))
> +               clk_disable_unprepare(data->sclk);

I think IS_ERROR don't be necessary because
clk_disalbe_unprepare check the NULL pointer of clock pointer.

>  err_clk:
>         clk_unprepare(data->clk);
>  err_clk_sec:
> @@ -956,6 +971,8 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>
>         exynos_tmu_control(pdev, false);
>
> +       if (!IS_ERR(data->sclk))
> +               clk_disable_unprepare(data->sclk);

ditto.

Best Regards,
Chanwoo Choi

>         clk_unprepare(data->clk);
>         if (!IS_ERR(data->clk_sec))
>                 clk_unprepare(data->clk_sec);
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

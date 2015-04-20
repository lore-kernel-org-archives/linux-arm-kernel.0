From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 20 Apr 2015 16:17:30 +0200
Subject: [PATCH 12/13 v2] coresight: replicator: retrieve and handle atclk
In-Reply-To: <1429534746-3068-12-git-send-email-linus.walleij@linaro.org>
References: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
 <1429534746-3068-12-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFr+54aT0VxsaYk4borLQQzYwCq-RAyjTwg6W4XQRLk8Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2015 at 14:59, Linus Walleij <linus.walleij@linaro.org> wrote:
> As can be seen from the datasheet of the CoreSight
> Components, DDI0314 table A-4 the funnel has a clock signal
> apart from the AHB interconnect ("amba_pclk", that we're
> already handling) called ATCLK, ARM Trace Clock, that SoC
> implementers may provide from an entirely different clock
> source. So to model this correctly create an optional
> path for handling ATCLK alongside the PCLK so we don't
> break old platforms that only define PCLK ("amba_pclk") but
> still makes it possible for SoCs that have both clock signals
> (such as the DB8500) to fetch and prepare/enable/disable/
> unprepare both clocks.
>
> The ATCLK is enabled and disabled using the runtime PM
> callbacks. As the replicator is a platform device, the
> code is a bit different from the other CoreSight components
> and the bus core does not activate runtime PM by default,
> so we need a few extra calls.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebased on the coresight git tree.
> - Fix up runtime suspend/resume code as indicated by Ulf.
> - Added Ulf's review tag.
> ---
>  drivers/hwtracing/coresight/coresight-replicator.c | 65 ++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index cdf05537d574..68f3985f750d 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
>  #include <linux/coresight.h>
> @@ -27,10 +28,12 @@
>  /**
>   * struct replicator_drvdata - specifics associated to a replicator component
>   * @dev:       the device entity associated with this component
> + * @atclk:     optional clock for the core parts of the replicator.
>   * @csdev:     component vitals needed by the framework
>   */
>  struct replicator_drvdata {
>         struct device           *dev;
> +       struct clk              *atclk;
>         struct coresight_device *csdev;
>  };
>
> @@ -39,6 +42,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  {
>         struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> +       pm_runtime_get_sync(drvdata->dev);
>         dev_info(drvdata->dev, "REPLICATOR enabled\n");
>         return 0;
>  }
> @@ -48,6 +52,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  {
>         struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> +       pm_runtime_put(drvdata->dev);
>         dev_info(drvdata->dev, "REPLICATOR disabled\n");
>  }
>
> @@ -62,6 +67,7 @@ static const struct coresight_ops replicator_cs_ops = {
>
>  static int replicator_probe(struct platform_device *pdev)
>  {
> +       int ret;
>         struct device *dev = &pdev->dev;
>         struct coresight_platform_data *pdata = NULL;
>         struct replicator_drvdata *drvdata;
> @@ -80,11 +86,22 @@ static int replicator_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         drvdata->dev = &pdev->dev;
> +       drvdata->atclk = devm_clk_get(&pdev->dev, "atclk"); /* optional */
> +       if (!IS_ERR(drvdata->atclk)) {
> +               ret = clk_prepare_enable(drvdata->atclk);
> +               if (ret)
> +                       return ret;
> +       }
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
>         platform_set_drvdata(pdev, drvdata);
>
>         desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> -       if (!desc)
> -               return -ENOMEM;
> +       if (!desc) {
> +               ret = -ENOMEM;
> +               goto out_disable_pm;
> +       }
>
>         desc->type = CORESIGHT_DEV_TYPE_LINK;
>         desc->subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
> @@ -92,21 +109,60 @@ static int replicator_probe(struct platform_device *pdev)
>         desc->pdata = pdev->dev.platform_data;
>         desc->dev = &pdev->dev;
>         drvdata->csdev = coresight_register(desc);
> -       if (IS_ERR(drvdata->csdev))
> -               return PTR_ERR(drvdata->csdev);
> +       if (IS_ERR(drvdata->csdev)) {
> +               ret = PTR_ERR(drvdata->csdev);
> +               goto out_disable_pm;
> +       }
> +
> +       pm_runtime_put(&pdev->dev);
>
>         dev_info(dev, "REPLICATOR initialized\n");
>         return 0;
> +
> +out_disable_pm:
> +       if (!IS_ERR(drvdata->atclk))
> +               clk_disable_unprepare(drvdata->atclk);
> +       pm_runtime_disable(&pdev->dev);

I don't think it matters much, but you might want to restore the
runtime PM usage count as this point as well.

pm_runtime_put_noidle();

> +
> +       return ret;
>  }
>
>  static int replicator_remove(struct platform_device *pdev)
>  {
>         struct replicator_drvdata *drvdata = platform_get_drvdata(pdev);
>

Add:
pm_runtime_get_sync();
clk_disable_unprepare();

> +       pm_runtime_disable(&pdev->dev);

pm_runtime_put_noidle();

Maybe it's also appropriate to move all the above below the
coresight_unregister()?

>         coresight_unregister(drvdata->csdev);
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
> +static int replicator_runtime_suspend(struct device *dev)
> +{
> +       struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +       if (drvdata && !IS_ERR(drvdata->atclk))
> +               clk_disable_unprepare(drvdata->atclk);
> +
> +       return 0;
> +}
> +
> +static int replicator_runtime_resume(struct device *dev)
> +{
> +       struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +       if (drvdata && !IS_ERR(drvdata->atclk))
> +               clk_prepare_enable(drvdata->atclk);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops replicator_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(replicator_runtime_suspend,
> +                          replicator_runtime_resume, NULL)
> +};
> +
>  static struct of_device_id replicator_match[] = {
>         {.compatible = "arm,coresight-replicator"},
>         {}
> @@ -118,6 +174,7 @@ static struct platform_driver replicator_driver = {
>         .driver         = {
>                 .name   = "coresight-replicator",
>                 .of_match_table = replicator_match,
> +               .pm     = &replicator_dev_pm_ops,
>         },
>  };
>
> --
> 1.9.3
>

Kind regards
Uffe

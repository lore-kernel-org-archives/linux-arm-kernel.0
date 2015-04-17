From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 17 Apr 2015 11:20:04 +0200
Subject: [PATCH 09/13] coresight: tpiu: retrieve and handle atclk
In-Reply-To: <1429261140-13910-10-git-send-email-linus.walleij@linaro.org>
References: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
 <1429261140-13910-10-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFo2OWgtB_ieHT+jrZE-k5b5Fqv3NTLwOwEYMkRTxjMV-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2015 at 10:58, Linus Walleij <linus.walleij@linaro.org> wrote:
> As can be seen from the datasheet of the CoreSight
> Components, DDI0314H page A-19 the TPIU has a clock signal
> apart from the AHB interconnect ("amba_pclk", that we're
> already handling) called ATCLK, ARM Trace Clock, that SoC
> implementers may provide from an entirely different clock
> source. So to model this correctly create an optional
> path for handling ATCLK alongside the PCLK so we don't
> break old platforms that only define PCLK ("amba_pclk") but
> still makes it possible for SoCs that have both clock signals
> (such as the DB8500) to fetch and prepare/enable/disable/
> unprepare both clocks in conjunction.
>
> The ATCLK is enabled and disabled using the runtime PM
> callbacks.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/coresight/coresight-tpiu.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/coresight/coresight-tpiu.c b/drivers/coresight/coresight-tpiu.c
> index 688ba937069e..55faea7d55dd 100644
> --- a/drivers/coresight/coresight-tpiu.c
> +++ b/drivers/coresight/coresight-tpiu.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/coresight.h>
>  #include <linux/amba/bus.h>
> +#include <linux/clk.h>
>
>  #include "coresight-priv.h"
>
> @@ -50,11 +51,13 @@
>  /**
>   * @base:      memory mapped base address for this component.
>   * @dev:       the device entity associated to this component.
> + * @atclk:     optional clock for the core parts of the TPIU.
>   * @csdev:     component vitals needed by the framework.
>   */
>  struct tpiu_drvdata {
>         void __iomem            *base;
>         struct device           *dev;
> +       struct clk              *atclk;
>         struct coresight_device *csdev;
>  };
>
> @@ -111,6 +114,7 @@ static const struct coresight_ops tpiu_cs_ops = {
>
>  static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  {
> +       int ret;
>         void __iomem *base;
>         struct device *dev = &adev->dev;
>         struct coresight_platform_data *pdata = NULL;
> @@ -131,6 +135,12 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>                 return -ENOMEM;
>
>         drvdata->dev = &adev->dev;
> +       drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
> +       if (!IS_ERR(drvdata->atclk)) {
> +               ret = clk_prepare_enable(drvdata->atclk);
> +               if (ret)
> +                       return ret;
> +       }
>         dev_set_drvdata(dev, drvdata);
>
>         /* Validity for the resource is already checked by the AMBA core */
> @@ -170,6 +180,34 @@ static int tpiu_remove(struct amba_device *adev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
> +static int tpiu_runtime_suspend(struct device *dev)
> +{
> +       struct amba_device *adev = to_amba_device(dev);
> +       struct tpiu_drvdata *drvdata = amba_get_drvdata(adev);

Same comment as previous patch.

> +
> +       if (drvdata && !IS_ERR(drvdata->atclk))
> +               clk_disable_unprepare(drvdata->atclk);
> +
> +       return 0;
> +}
> +
> +static int tpiu_runtime_resume(struct device *dev)
> +{
> +       struct amba_device *adev = to_amba_device(dev);
> +       struct tpiu_drvdata *drvdata = amba_get_drvdata(adev);

Same comment as previous patch.


> +
> +       if (drvdata && !IS_ERR(drvdata->atclk))
> +               clk_prepare_enable(drvdata->atclk);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops tpiu_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(tpiu_runtime_suspend, tpiu_runtime_resume, NULL)
> +};
> +
>  static struct amba_id tpiu_ids[] = {
>         {
>                 .id     = 0x0003b912,
> @@ -186,6 +224,7 @@ static struct amba_driver tpiu_driver = {
>         .drv = {
>                 .name   = "coresight-tpiu",
>                 .owner  = THIS_MODULE,
> +               .pm     = &tpiu_dev_pm_ops,
>         },
>         .probe          = tpiu_probe,
>         .remove         = tpiu_remove,
> --
> 1.9.3
>

With the minor changes suggested.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

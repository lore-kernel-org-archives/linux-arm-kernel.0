From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 13 Oct 2015 10:48:46 -0600
Subject: [PATCH 2/3] drivers/hwtracing: make coresight-* explicitly
 non-modular
In-Reply-To: <1444613747-17715-3-git-send-email-paul.gortmaker@windriver.com>
References: <1444613747-17715-1-git-send-email-paul.gortmaker@windriver.com>
 <1444613747-17715-3-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CANLsYkyW+S-kc=D8Sab5+SH4P9OJ=ez69G=oMBAH_JuCGDCWxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2015 at 19:35, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> None of the Kconfig currently controlling compilation of any of
> the files here are tristate, meaning that none of it currently
> is being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the drivers there is no doubt they are builtin-only.
> All drivers get mostly the same changes, so they are handled in batch.
>
> The changes in this commit are as follows:
>   (1) convert from module_amba_driver to builtin_amba_driver
>   (2) delete module.h include where it is now unused
>   (3) relocate the description into the comments so we don't need
>       MODULE_DESCRIPTION and associated tags
>   (4) delete any ".remove" related functions that were added under
>       the presumption that module_exit would ever run here
>   (5) explicitly prevent anyone from mistakenly using the unbind
>       interface to call the (now removed) ".remove" functions, as that
>       never made sense for any of these drivers regardless.
>
> The etm3x and etm4x use module_param_named, and have been adjusted
> to just include moduleparam.h for that purpose.
>
> Since module_amba_driver() uses the same init level priority as
> builtin_amba_driver() the init ordering remains unchanged with
> this commit.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c      | 26 +++++--------------
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 29 ++++++---------------
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 19 +++-----------
>  drivers/hwtracing/coresight/coresight-funnel.c     | 25 +++++-------------
>  .../coresight/coresight-replicator-qcom.c          | 19 +++-----------
>  drivers/hwtracing/coresight/coresight-replicator.c | 30 +++++-----------------
>  drivers/hwtracing/coresight/coresight-tmc.c        | 28 +++++---------------
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 25 +++++-------------
>  drivers/hwtracing/coresight/coresight.c            |  3 ---
>  drivers/hwtracing/coresight/of_coresight.c         |  1 -
>  10 files changed, 49 insertions(+), 156 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 77d0f9c1118d..12f03cffa1ac 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -1,5 +1,7 @@
>  /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
>   *
> + * Description: CoreSight Embedded Trace Buffer driver
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
>   * only version 2 as published by the Free Software Foundation.
> @@ -11,7 +13,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> @@ -489,15 +490,6 @@ err_misc_register:
>         return ret;
>  }
>
> -static int etb_remove(struct amba_device *adev)
> -{
> -       struct etb_drvdata *drvdata = amba_get_drvdata(adev);
> -
> -       misc_deregister(&drvdata->miscdev);
> -       coresight_unregister(drvdata->csdev);
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int etb_runtime_suspend(struct device *dev)
>  {
> @@ -534,17 +526,13 @@ static struct amba_id etb_ids[] = {
>
>  static struct amba_driver etb_driver = {
>         .drv = {
> -               .name   = "coresight-etb10",
> -               .owner  = THIS_MODULE,
> -               .pm     = &etb_dev_pm_ops,
> +               .name                   = "coresight-etb10",
> +               .owner                  = THIS_MODULE,
> +               .pm                     = &etb_dev_pm_ops,
> +               .suppress_bind_attrs    = true,
>
>         },
>         .probe          = etb_probe,
> -       .remove         = etb_remove,
>         .id_table       = etb_ids,
>  };
> -
> -module_amba_driver(etb_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("CoreSight Embedded Trace Buffer driver");
> +builtin_amba_driver(etb_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index d630b7ece735..63f6113a6a3c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -1,5 +1,7 @@
>  /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
>   *
> + * Description: CoreSight Program Flow Trace driver
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
>   * only version 2 as published by the Free Software Foundation.
> @@ -11,7 +13,7 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> @@ -1877,17 +1879,6 @@ err_arch_supported:
>         return ret;
>  }
>
> -static int etm_remove(struct amba_device *adev)
> -{
> -       struct etm_drvdata *drvdata = amba_get_drvdata(adev);
> -
> -       coresight_unregister(drvdata->csdev);
> -       if (--etm_count == 0)
> -               unregister_hotcpu_notifier(&etm_cpu_notifier);
> -
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int etm_runtime_suspend(struct device *dev)
>  {
> @@ -1945,16 +1936,12 @@ static struct amba_id etm_ids[] = {
>
>  static struct amba_driver etm_driver = {
>         .drv = {
> -               .name   = "coresight-etm3x",
> -               .owner  = THIS_MODULE,
> -               .pm     = &etm_dev_pm_ops,
> +               .name                   = "coresight-etm3x",
> +               .owner                  = THIS_MODULE,
> +               .pm                     = &etm_dev_pm_ops,
> +               .suppress_bind_attrs    = true,
>         },
>         .probe          = etm_probe,
> -       .remove         = etm_remove,
>         .id_table       = etm_ids,
>  };
> -
> -module_amba_driver(etm_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("CoreSight Program Flow Trace driver");
> +builtin_amba_driver(etm_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index a6707642bb23..596932ebb67c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -15,7 +15,6 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> -#include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
> @@ -2684,17 +2683,6 @@ err_coresight_register:
>         return ret;
>  }
>
> -static int etm4_remove(struct amba_device *adev)
> -{
> -       struct etmv4_drvdata *drvdata = amba_get_drvdata(adev);
> -
> -       coresight_unregister(drvdata->csdev);
> -       if (--etm4_count == 0)
> -               unregister_hotcpu_notifier(&etm4_cpu_notifier);
> -
> -       return 0;
> -}
> -
>  static struct amba_id etm4_ids[] = {
>         {       /* ETM 4.0 - Qualcomm */
>                 .id     = 0x0003b95d,
> @@ -2711,11 +2699,10 @@ static struct amba_id etm4_ids[] = {
>
>  static struct amba_driver etm4x_driver = {
>         .drv = {
> -               .name   = "coresight-etm4x",
> +               .name                   = "coresight-etm4x",
> +               .suppress_bind_attrs    = true,
>         },
>         .probe          = etm4_probe,
> -       .remove         = etm4_remove,
>         .id_table       = etm4_ids,
>  };
> -
> -module_amba_driver(etm4x_driver);
> +builtin_amba_driver(etm4x_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 2e36bde7fcb4..943f747fcb02 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -1,5 +1,7 @@
>  /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
>   *
> + * Description: CoreSight Funnel driver
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
>   * only version 2 as published by the Free Software Foundation.
> @@ -11,7 +13,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> @@ -226,14 +227,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>         return 0;
>  }
>
> -static int funnel_remove(struct amba_device *adev)
> -{
> -       struct funnel_drvdata *drvdata = amba_get_drvdata(adev);
> -
> -       coresight_unregister(drvdata->csdev);
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int funnel_runtime_suspend(struct device *dev)
>  {
> @@ -270,16 +263,12 @@ static struct amba_id funnel_ids[] = {
>
>  static struct amba_driver funnel_driver = {
>         .drv = {
> -               .name   = "coresight-funnel",
> -               .owner  = THIS_MODULE,
> -               .pm     = &funnel_dev_pm_ops,
> +               .name                   = "coresight-funnel",
> +               .owner                  = THIS_MODULE,
> +               .pm                     = &funnel_dev_pm_ops,
> +               .suppress_bind_attrs    = true,
>         },
>         .probe          = funnel_probe,
> -       .remove         = funnel_remove,
>         .id_table       = funnel_ids,
>  };
> -
> -module_amba_driver(funnel_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("CoreSight Funnel driver");
> +builtin_amba_driver(funnel_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> index 584059e9e866..2d4bb628894e 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> @@ -15,7 +15,6 @@
>  #include <linux/clk.h>
>  #include <linux/coresight.h>
>  #include <linux/device.h>
> -#include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -156,15 +155,6 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
>         return 0;
>  }
>
> -static int replicator_remove(struct amba_device *adev)
> -{
> -       struct replicator_state *drvdata = amba_get_drvdata(adev);
> -
> -       pm_runtime_disable(&adev->dev);
> -       coresight_unregister(drvdata->csdev);
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int replicator_runtime_suspend(struct device *dev)
>  {
> @@ -204,12 +194,11 @@ static struct amba_id replicator_ids[] = {
>
>  static struct amba_driver replicator_driver = {
>         .drv = {
> -               .name   = "coresight-replicator-qcom",
> -               .pm     = &replicator_dev_pm_ops,
> +               .name                   = "coresight-replicator-qcom",
> +               .pm                     = &replicator_dev_pm_ops,
> +               .suppress_bind_attrs    = true,
>         },
>         .probe          = replicator_probe,
> -       .remove         = replicator_remove,
>         .id_table       = replicator_ids,
>  };
> -
> -module_amba_driver(replicator_driver);
> +builtin_amba_driver(replicator_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 963ac197c253..7a1cb0f9d60a 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -1,5 +1,7 @@
>  /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
>   *
> + * Description: CoreSight Replicator driver
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
>   * only version 2 as published by the Free Software Foundation.
> @@ -11,7 +13,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> @@ -127,20 +128,6 @@ out_disable_pm:
>         return ret;
>  }
>
> -static int replicator_remove(struct platform_device *pdev)
> -{
> -       struct replicator_drvdata *drvdata = platform_get_drvdata(pdev);
> -
> -       coresight_unregister(drvdata->csdev);
> -       pm_runtime_get_sync(&pdev->dev);
> -       if (!IS_ERR(drvdata->atclk))
> -               clk_disable_unprepare(drvdata->atclk);
> -       pm_runtime_put_noidle(&pdev->dev);
> -       pm_runtime_disable(&pdev->dev);
> -
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int replicator_runtime_suspend(struct device *dev)
>  {
> @@ -175,15 +162,12 @@ static const struct of_device_id replicator_match[] = {
>
>  static struct platform_driver replicator_driver = {
>         .probe          = replicator_probe,
> -       .remove         = replicator_remove,
>         .driver         = {
> -               .name   = "coresight-replicator",
> -               .of_match_table = replicator_match,
> -               .pm     = &replicator_dev_pm_ops,
> +               .name                   = "coresight-replicator",
> +               .of_match_table         = replicator_match,
> +               .pm                     = &replicator_dev_pm_ops,
> +               .suppress_bind_attrs    = true,
> +
>         },
>  };
> -
>  builtin_platform_driver(replicator_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("CoreSight Replicator driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index a57c7ec1661f..efe0de442a52 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -1,5 +1,7 @@
>  /* Copyright (c) 2012, The Linux Foundation. All rights reserved.
>   *
> + * Description: CoreSight Trace Memory Controller driver
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
>   * only version 2 as published by the Free Software Foundation.
> @@ -11,7 +13,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> @@ -770,19 +771,6 @@ err_devm_kzalloc:
>         return ret;
>  }
>
> -static int tmc_remove(struct amba_device *adev)
> -{
> -       struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
> -
> -       misc_deregister(&drvdata->miscdev);
> -       coresight_unregister(drvdata->csdev);
> -       if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
> -               dma_free_coherent(drvdata->dev, drvdata->size,
> -                                 &drvdata->paddr, GFP_KERNEL);
> -
> -       return 0;
> -}
> -
>  static struct amba_id tmc_ids[] = {
>         {
>                 .id     = 0x0003b961,
> @@ -793,15 +781,11 @@ static struct amba_id tmc_ids[] = {
>
>  static struct amba_driver tmc_driver = {
>         .drv = {
> -               .name   = "coresight-tmc",
> -               .owner  = THIS_MODULE,
> +               .name                   = "coresight-tmc",
> +               .owner                  = THIS_MODULE,
> +               .suppress_bind_attrs    = true,
>         },
>         .probe          = tmc_probe,
> -       .remove         = tmc_remove,
>         .id_table       = tmc_ids,
>  };
> -
> -module_amba_driver(tmc_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("CoreSight Trace Memory Controller driver");
> +builtin_amba_driver(tmc_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 7214efd10db5..079c02026141 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -1,5 +1,7 @@
>  /* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
>   *
> + * Description: CoreSight Trace Port Interface Unit driver
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
>   * only version 2 as published by the Free Software Foundation.
> @@ -11,7 +13,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> @@ -172,14 +173,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>         return 0;
>  }
>
> -static int tpiu_remove(struct amba_device *adev)
> -{
> -       struct tpiu_drvdata *drvdata = amba_get_drvdata(adev);
> -
> -       coresight_unregister(drvdata->csdev);
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM
>  static int tpiu_runtime_suspend(struct device *dev)
>  {
> @@ -220,16 +213,12 @@ static struct amba_id tpiu_ids[] = {
>
>  static struct amba_driver tpiu_driver = {
>         .drv = {
> -               .name   = "coresight-tpiu",
> -               .owner  = THIS_MODULE,
> -               .pm     = &tpiu_dev_pm_ops,
> +               .name                   = "coresight-tpiu",
> +               .owner                  = THIS_MODULE,
> +               .pm                     = &tpiu_dev_pm_ops,
> +               .suppress_bind_attrs    = true,
>         },
>         .probe          = tpiu_probe,
> -       .remove         = tpiu_remove,
>         .id_table       = tpiu_ids,
>  };
> -
> -module_amba_driver(tpiu_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("CoreSight Trace Port Interface Unit driver");
> +builtin_amba_driver(tpiu_driver);
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index a3dcafb81700..af273033ac53 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -11,7 +11,6 @@
>   */
>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
> @@ -721,5 +720,3 @@ void coresight_unregister(struct coresight_device *csdev)
>         mutex_unlock(&coresight_mutex);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);
> -
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index b0973617826f..28b5455923b8 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -10,7 +10,6 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> --
> 2.6.1
>

I've tested this on my side and everything is in order.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

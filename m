From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 29 Apr 2015 10:28:42 -0600
Subject: [PATCH 1/2] coresight: replicator: Add Qualcomm CoreSight
 Replicator driver
In-Reply-To: <1430310000-10867-2-git-send-email-ivan.ivanov@linaro.org>
References: <1430310000-10867-1-git-send-email-ivan.ivanov@linaro.org>
 <1430310000-10867-2-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <CANLsYkwfDYjTqBUvXp2da6E=SA8F2EbH7_Mi20Sba9NpJm9Y7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 April 2015 at 06:19, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
> From: Pratik Patel <pratikp@codeaurora.org>

Thanks for crediting the original author.

>
> This driver manages Qualcomm CoreSight Replicator device, which
> resides on the AMBA bus. Replicator has been made programmable to
> allow software to turn of the replicator branch to sink that is not
> being used. This avoids trace traffic to the unused/non-current sink
> from causing back pressure that results in overflows at the source.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---
>  .../devicetree/bindings/arm/coresight.txt          |   1 +
>  drivers/hwtracing/coresight/Kconfig                |   9 +
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  .../coresight/coresight-replicator-qcom.c          | 211 +++++++++++++++++++++
>  4 files changed, 222 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-replicator-qcom.c
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index f4d6a86..2314f2b 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -18,6 +18,7 @@ its hardware characteristcs.
>                 - "arm,coresight-funnel", "arm,primecell";
>                 - "arm,coresight-etm3x", "arm,primecell";
>                 - "arm,coresight-etm4x", "arm,primecell";
> +               - "qcom,coresight-replicator", "arm,primecell";

Is there some sort of versioning information we can add like it was
done for the "coresight-etmXY" bindings?  It makes things a lot
cleaner when a new (and possibly not backward compatible) version gets
released.

>
>         * reg: physical base address and length of the register
>           set(s) of the component.
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 6b331d4..165b681 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -68,4 +68,13 @@ config CORESIGHT_SOURCE_ETM4X
>           instructions that a processor is executing. This is primarily useful
>           for instruction level tracing. Depending on the implemented version
>           data tracing may also be available.
> +
> +config CORESIGHT_QCOM_REPLICATOR
> +       bool "Qualcomm CoreSight Replicator driver"
> +       help
> +         This enables support for CoreSight link and sink driver that are
> +         responsible for transporting and collecting the trace data
> +         respectively. Link and sinks are dynamically aggregated with a trace
> +         entity at run time to form a complete trace path.

The replicator is only a link entity.  It is only transporting trace
data information rather than collecting it.  Please review the
comment.  Also, can this specific version run on both V7 and V8
architecture.  If not the proper "depends" should be added.

> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 0af28d4..99f8e5f 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
>                                            coresight-replicator.o
>  obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o
>  obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
> +obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
> diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> new file mode 100644
> index 0000000..961f389
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
> @@ -0,0 +1,211 @@
> +/*
> + * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/clk.h>
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "coresight-priv.h"
> +
> +#define REPLICATOR_IDFILTER0           0x000
> +#define REPLICATOR_IDFILTER1           0x004
> +
> +/**
> + * struct replicator_state - specifics associated to a replicator component
> + * @base:      memory mapped base address for this component.
> + * @dev:       the device entity associated with this component
> + * @atclk:     optional clock for the core parts of the replicator.
> + * @csdev:     component vitals needed by the framework
> + */
> +struct replicator_state {
> +       void __iomem            *base;
> +       struct device           *dev;
> +       struct clk              *atclk;
> +       struct coresight_device *csdev;
> +};
> +
> +static int replicator_enable(struct coresight_device *csdev, int inport,
> +                            int outport)

Please use proper alignment.  "int outport" should be aligned with
"struct coresight_device *csdev".  Same comment for all the function
declarations.

> +{
> +       struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       pm_runtime_get_sync(drvdata->dev);
> +
> +       CS_UNLOCK(drvdata->base);
> +
> +       if (outport == 0) {
> +               writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER0);
> +               writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
> +       } else {
> +               writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER1);
> +               writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
> +       }

Please add comments to explain what those are doing.

> +
> +       CS_LOCK(drvdata->base);
> +
> +       dev_info(drvdata->dev, "REPLICATOR enabled\n");
> +       return 0;
> +}
> +
> +static void replicator_disable(struct coresight_device *csdev, int inport,
> +                              int outport)
> +{
> +       struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       CS_UNLOCK(drvdata->base);
> +
> +       if (outport == 0)
> +               writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
> +       else
> +               writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);

Comments please.

> +
> +       CS_LOCK(drvdata->base);
> +
> +       pm_runtime_put(drvdata->dev);
> +
> +       dev_info(drvdata->dev, "REPLICATOR disabled\n");
> +}
> +
> +static const struct coresight_ops_link replicator_link_ops = {
> +       .enable         = replicator_enable,
> +       .disable        = replicator_disable,
> +};
> +
> +static const struct coresight_ops replicator_cs_ops = {
> +       .link_ops       = &replicator_link_ops,
> +};
> +
> +static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +       int ret;
> +       struct device *dev = &adev->dev;
> +       struct resource *res = &adev->res;
> +       struct coresight_platform_data *pdata = NULL;
> +       struct replicator_state *drvdata;
> +       struct coresight_desc *desc;
> +       struct device_node *np = adev->dev.of_node;
> +       void __iomem *base;
> +
> +       if (np) {
> +               pdata = of_get_coresight_platform_data(dev, np);
> +               if (IS_ERR(pdata))
> +                       return PTR_ERR(pdata);
> +               adev->dev.platform_data = pdata;
> +       }
> +
> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
> +       drvdata->dev = &adev->dev;
> +       drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
> +       if (!IS_ERR(drvdata->atclk)) {
> +               ret = clk_prepare_enable(drvdata->atclk);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Validity for the resource is already checked by the AMBA core */
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       drvdata->base = base;
> +       dev_set_drvdata(dev, drvdata);
> +       pm_runtime_put(&adev->dev);
> +
> +       desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> +       if (!desc)
> +               return -ENOMEM;
> +
> +       desc->type = CORESIGHT_DEV_TYPE_LINK;
> +       desc->subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
> +       desc->ops = &replicator_cs_ops;
> +       desc->pdata = adev->dev.platform_data;
> +       desc->dev = &adev->dev;
> +       drvdata->csdev = coresight_register(desc);
> +       if (IS_ERR(drvdata->csdev))
> +               return PTR_ERR(drvdata->csdev);
> +
> +       dev_info(dev, "REPLICATOR initialized\n");

Please replace with "dev_info(dev, "%s initialized\n", (char
*)id->data);" and add the required .data information to the amba_id
cells as found in the official coresight "next" branch.

[1]. https://git.linaro.org/kernel/coresight.git/ next

> +       return 0;
> +}
> +
> +static int replicator_remove(struct amba_device *adev)
> +{
> +       struct replicator_state *drvdata = amba_get_drvdata(adev);
> +
> +       pm_runtime_disable(&adev->dev);
> +       coresight_unregister(drvdata->csdev);
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int replicator_runtime_suspend(struct device *dev)
> +{
> +       struct replicator_state *drvdata = dev_get_drvdata(dev);
> +
> +       if (drvdata && !IS_ERR(drvdata->atclk))
> +               clk_disable_unprepare(drvdata->atclk);
> +
> +       return 0;
> +}
> +
> +static int replicator_runtime_resume(struct device *dev)
> +{
> +       struct replicator_state *drvdata = dev_get_drvdata(dev);
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

Proper alignment please.

> +};
> +
> +static struct amba_id replicator_ids[] = {
> +       {
> +               .id     = 0x0003b909,
> +               .mask   = 0x0003ffff,
> +       },

Please add the ".data" field.  See comment above.

> +       { 0, 0},
> +};
> +
> +static struct amba_driver replicator_driver = {
> +       .drv = {
> +               .name   = "coresight-replicator-qcom",
> +               .owner  = THIS_MODULE,
> +               .pm     = &replicator_dev_pm_ops,
> +       },
> +       .probe          = replicator_probe,
> +       .remove         = replicator_remove,
> +       .id_table       = replicator_ids,
> +};
> +
> +module_amba_driver(replicator_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Qualcomm CoreSight Replicator driver");
> --
> 1.9.1
>

Thanks for the submission.
Mathieu

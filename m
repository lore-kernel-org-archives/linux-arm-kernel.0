From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 18 Jul 2017 10:11:57 +0100
Subject: [PATCH v3 01/18] coresight replicator: Cleanup programmable
 replicator naming
In-Reply-To: <20170717174535.GB21523@xps15>
References: <1500037463-19951-1-git-send-email-suzuki.poulose@arm.com>
 <1500037463-19951-2-git-send-email-suzuki.poulose@arm.com>
 <20170717174535.GB21523@xps15>
Message-ID: <eb13271f-00ce-a615-f039-ca8ca5439d6f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/17 18:45, Mathieu Poirier wrote:
> On Fri, Jul 14, 2017 at 02:04:06PM +0100, Suzuki K Poulose wrote:
>> The Linux coresight drivers define the programmable ATB replicator as
>> Qualcomm replicator, while this is designed by ARM. This can cause confusion
>> to a user selecting the driver. Cleanup all references to make it
>>  explicitly clear. This patch :
>>
>>  1) Replace the compatible string for the replicator :
>> 	qcom,coresight-replicator1x => arm,coresight-dynamic-replicator
>>  2) Changes the Kconfig symbol (since this is not part of any defconfigs)
>> 	 CORESIGHT_QCOM_REPLICATOR => CORESIGHT_DYNAMIC_REPLICATOR
>>  3) Improves the help message in the Kconfig.
>>  4) Changes the name of the driver and the file :
>> 	coresight-replicator-qcom => coresight-dynamic-replicator
>>
>> Cc: Pratik Patel <pratikp@codeaurora.org>
>> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: devicetree at vger.kernel.org
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Acked-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V1:
>>  - Since the driver doesn't use the compatible string, change the
>>    recommended compatible string.
>>  - Rename the driver file to coresight-dynamic-replicator.c
>> ---
>>  .../devicetree/bindings/arm/coresight.txt          |   4 +-
>>  drivers/hwtracing/coresight/Kconfig                |  10 +-
>>  drivers/hwtracing/coresight/Makefile               |   2 +-
>>  .../coresight/coresight-dynamic-replicator.c       | 195 ++++++++++++++++++++
>>  .../coresight/coresight-replicator-qcom.c          | 196 ---------------------
>>  5 files changed, 203 insertions(+), 204 deletions(-)
>>  create mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>>  delete mode 100644 drivers/hwtracing/coresight/coresight-replicator-qcom.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index fcbae6a..15ac8e8 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -34,8 +34,8 @@ its hardware characteristcs.
>>  		- Embedded Trace Macrocell (version 4.x):
>>  			"arm,coresight-etm4x", "arm,primecell";
>>
>> -		- Qualcomm Configurable Replicator (version 1.x):
>> -			"qcom,coresight-replicator1x", "arm,primecell";
>> +		- Coresight programmable Replicator :
>> +			"arm,coresight-dynamic-replicator", "arm,primecell";
>>
>>  		- System Trace Macrocell:
>>  			"arm,coresight-stm", "arm,primecell"; [1]
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 8d55d6d..ef9cb3c 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -70,13 +70,13 @@ config CORESIGHT_SOURCE_ETM4X
>>  	  for instruction level tracing. Depending on the implemented version
>>  	  data tracing may also be available.
>>
>> -config CORESIGHT_QCOM_REPLICATOR
>> -	bool "Qualcomm CoreSight Replicator driver"
>> +config CORESIGHT_DYNAMIC_REPLICATOR
>> +	bool "CoreSight Programmable Replicator driver"
>>  	depends on CORESIGHT_LINKS_AND_SINKS
>>  	help
>> -	  This enables support for Qualcomm CoreSight link driver. The
>> -	  programmable ATB replicator sends the ATB trace stream from the
>> -	  ETB/ETF to the TPIUi and ETR.
>> +	  This enables support for dynamic CoreSight replicator link driver.
>> +	  The programmable ATB replicator allows independent filtering of the
>> +	  trace data based on the traceid.
>>
>>  config CORESIGHT_STM
>>  	bool "CoreSight System Trace Macrocell driver"
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index 433d590..5bae90ce 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -14,6 +14,6 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
>>  					coresight-etm3x-sysfs.o
>>  obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
>>  					coresight-etm4x-sysfs.o
>> -obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
>> +obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
>>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> new file mode 100644
>> index 0000000..1675031
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> @@ -0,0 +1,195 @@
>> +/*
>> + * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/amba/bus.h>
>> +#include <linux/clk.h>
>> +#include <linux/coresight.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>> +
>> +#include "coresight-priv.h"
>> +
>> +#define REPLICATOR_IDFILTER0		0x000
>> +#define REPLICATOR_IDFILTER1		0x004
>> +
>> +/**
>> + * struct replicator_state - specifics associated to a replicator component
>> + * @base:	memory mapped base address for this component.
>> + * @dev:	the device entity associated with this component
>> + * @atclk:	optional clock for the core parts of the replicator.
>> + * @csdev:	component vitals needed by the framework
>> + */
>> +struct replicator_state {
>> +	void __iomem		*base;
>> +	struct device		*dev;
>> +	struct clk		*atclk;
>> +	struct coresight_device	*csdev;
>> +};
>> +
>> +static int replicator_enable(struct coresight_device *csdev, int inport,
>> +			      int outport)
>> +{
>> +	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +	CS_UNLOCK(drvdata->base);
>> +
>> +	/*
>> +	 * Ensure that the other port is disabled
>> +	 * 0x00 - passing through the replicator unimpeded
>> +	 * 0xff - disable (or impede) the flow of ATB data
>> +	 */
>> +	if (outport == 0) {
>> +		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER0);
>> +		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
>> +	} else {
>> +		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER1);
>> +		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
>> +	}
>> +
>> +	CS_LOCK(drvdata->base);
>> +
>> +	dev_info(drvdata->dev, "REPLICATOR enabled\n");
>> +	return 0;
>> +}
>> +
>> +static void replicator_disable(struct coresight_device *csdev, int inport,
>> +				int outport)
>> +{
>> +	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +	CS_UNLOCK(drvdata->base);
>> +
>> +	/* disable the flow of ATB data through port */
>> +	if (outport == 0)
>> +		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
>> +	else
>> +		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
>> +
>> +	CS_LOCK(drvdata->base);
>> +
>> +	dev_info(drvdata->dev, "REPLICATOR disabled\n");
>> +}
>> +
>> +static const struct coresight_ops_link replicator_link_ops = {
>> +	.enable		= replicator_enable,
>> +	.disable	= replicator_disable,
>> +};
>> +
>> +static const struct coresight_ops replicator_cs_ops = {
>> +	.link_ops	= &replicator_link_ops,
>> +};
>> +
>> +static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
>> +{
>> +	int ret;
>> +	struct device *dev = &adev->dev;
>> +	struct resource *res = &adev->res;
>> +	struct coresight_platform_data *pdata = NULL;
>> +	struct replicator_state *drvdata;
>> +	struct coresight_desc desc = { 0 };
>> +	struct device_node *np = adev->dev.of_node;
>> +	void __iomem *base;
>> +
>> +	if (np) {
>> +		pdata = of_get_coresight_platform_data(dev, np);
>> +		if (IS_ERR(pdata))
>> +			return PTR_ERR(pdata);
>> +		adev->dev.platform_data = pdata;
>> +	}
>> +
>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +
>> +	drvdata->dev = &adev->dev;
>> +	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>> +	if (!IS_ERR(drvdata->atclk)) {
>> +		ret = clk_prepare_enable(drvdata->atclk);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Validity for the resource is already checked by the AMBA core */
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	drvdata->base = base;
>> +	dev_set_drvdata(dev, drvdata);
>> +	pm_runtime_put(&adev->dev);
>> +
>> +	desc.type = CORESIGHT_DEV_TYPE_LINK;
>> +	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
>> +	desc.ops = &replicator_cs_ops;
>> +	desc.pdata = adev->dev.platform_data;
>> +	desc.dev = &adev->dev;
>> +	drvdata->csdev = coresight_register(&desc);
>> +	if (IS_ERR(drvdata->csdev))
>> +		return PTR_ERR(drvdata->csdev);
>> +
>> +	dev_info(dev, "initialized\n");
>
> Was it intentional to remove the original string?  If so please remove the

Yes, it doesn't make sense to display REPLICATOR 1.0, which isn't really any
formal name of the product of family.

> entire output as it doesn't give any information about the HW itself.

Sure, I can remove it.

Cheers
Suzuki

>
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int replicator_runtime_suspend(struct device *dev)
>> +{
>> +	struct replicator_state *drvdata = dev_get_drvdata(dev);
>> +
>> +	if (drvdata && !IS_ERR(drvdata->atclk))
>> +		clk_disable_unprepare(drvdata->atclk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int replicator_runtime_resume(struct device *dev)
>> +{
>> +	struct replicator_state *drvdata = dev_get_drvdata(dev);
>> +
>> +	if (drvdata && !IS_ERR(drvdata->atclk))
>> +		clk_prepare_enable(drvdata->atclk);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops replicator_dev_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(replicator_runtime_suspend,
>> +			   replicator_runtime_resume,
>> +			   NULL)
>> +};
>> +
>> +static struct amba_id replicator_ids[] = {
>> +	{
>> +		.id     = 0x0003b909,
>> +		.mask   = 0x0003ffff,
>> +	},
>> +	{ 0, 0 },
>> +};
>> +
>> +static struct amba_driver replicator_driver = {
>> +	.drv = {
>> +		.name	= "coresight-dynamic-replicator",
>> +		.pm	= &replicator_dev_pm_ops,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe		= replicator_probe,
>> +	.id_table	= replicator_ids,
>> +};
>> +builtin_amba_driver(replicator_driver);
>> diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
>> deleted file mode 100644
>> index 0a3d15f..0000000
>> --- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
>> +++ /dev/null
>> @@ -1,196 +0,0 @@
>> -/*
>> - * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 and
>> - * only version 2 as published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - */
>> -
>> -#include <linux/amba/bus.h>
>> -#include <linux/clk.h>
>> -#include <linux/coresight.h>
>> -#include <linux/device.h>
>> -#include <linux/err.h>
>> -#include <linux/init.h>
>> -#include <linux/io.h>
>> -#include <linux/kernel.h>
>> -#include <linux/of.h>
>> -#include <linux/pm_runtime.h>
>> -#include <linux/slab.h>
>> -
>> -#include "coresight-priv.h"
>> -
>> -#define REPLICATOR_IDFILTER0		0x000
>> -#define REPLICATOR_IDFILTER1		0x004
>> -
>> -/**
>> - * struct replicator_state - specifics associated to a replicator component
>> - * @base:	memory mapped base address for this component.
>> - * @dev:	the device entity associated with this component
>> - * @atclk:	optional clock for the core parts of the replicator.
>> - * @csdev:	component vitals needed by the framework
>> - */
>> -struct replicator_state {
>> -	void __iomem		*base;
>> -	struct device		*dev;
>> -	struct clk		*atclk;
>> -	struct coresight_device	*csdev;
>> -};
>> -
>> -static int replicator_enable(struct coresight_device *csdev, int inport,
>> -			      int outport)
>> -{
>> -	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
>> -
>> -	CS_UNLOCK(drvdata->base);
>> -
>> -	/*
>> -	 * Ensure that the other port is disabled
>> -	 * 0x00 - passing through the replicator unimpeded
>> -	 * 0xff - disable (or impede) the flow of ATB data
>> -	 */
>> -	if (outport == 0) {
>> -		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER0);
>> -		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
>> -	} else {
>> -		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER1);
>> -		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
>> -	}
>> -
>> -	CS_LOCK(drvdata->base);
>> -
>> -	dev_info(drvdata->dev, "REPLICATOR enabled\n");
>> -	return 0;
>> -}
>> -
>> -static void replicator_disable(struct coresight_device *csdev, int inport,
>> -				int outport)
>> -{
>> -	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
>> -
>> -	CS_UNLOCK(drvdata->base);
>> -
>> -	/* disable the flow of ATB data through port */
>> -	if (outport == 0)
>> -		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
>> -	else
>> -		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
>> -
>> -	CS_LOCK(drvdata->base);
>> -
>> -	dev_info(drvdata->dev, "REPLICATOR disabled\n");
>> -}
>> -
>> -static const struct coresight_ops_link replicator_link_ops = {
>> -	.enable		= replicator_enable,
>> -	.disable	= replicator_disable,
>> -};
>> -
>> -static const struct coresight_ops replicator_cs_ops = {
>> -	.link_ops	= &replicator_link_ops,
>> -};
>> -
>> -static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
>> -{
>> -	int ret;
>> -	struct device *dev = &adev->dev;
>> -	struct resource *res = &adev->res;
>> -	struct coresight_platform_data *pdata = NULL;
>> -	struct replicator_state *drvdata;
>> -	struct coresight_desc desc = { 0 };
>> -	struct device_node *np = adev->dev.of_node;
>> -	void __iomem *base;
>> -
>> -	if (np) {
>> -		pdata = of_get_coresight_platform_data(dev, np);
>> -		if (IS_ERR(pdata))
>> -			return PTR_ERR(pdata);
>> -		adev->dev.platform_data = pdata;
>> -	}
>> -
>> -	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> -	if (!drvdata)
>> -		return -ENOMEM;
>> -
>> -	drvdata->dev = &adev->dev;
>> -	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>> -	if (!IS_ERR(drvdata->atclk)) {
>> -		ret = clk_prepare_enable(drvdata->atclk);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>> -	/* Validity for the resource is already checked by the AMBA core */
>> -	base = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR(base))
>> -		return PTR_ERR(base);
>> -
>> -	drvdata->base = base;
>> -	dev_set_drvdata(dev, drvdata);
>> -	pm_runtime_put(&adev->dev);
>> -
>> -	desc.type = CORESIGHT_DEV_TYPE_LINK;
>> -	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
>> -	desc.ops = &replicator_cs_ops;
>> -	desc.pdata = adev->dev.platform_data;
>> -	desc.dev = &adev->dev;
>> -	drvdata->csdev = coresight_register(&desc);
>> -	if (IS_ERR(drvdata->csdev))
>> -		return PTR_ERR(drvdata->csdev);
>> -
>> -	dev_info(dev, "%s initialized\n", (char *)id->data);
>> -	return 0;
>> -}
>> -
>> -#ifdef CONFIG_PM
>> -static int replicator_runtime_suspend(struct device *dev)
>> -{
>> -	struct replicator_state *drvdata = dev_get_drvdata(dev);
>> -
>> -	if (drvdata && !IS_ERR(drvdata->atclk))
>> -		clk_disable_unprepare(drvdata->atclk);
>> -
>> -	return 0;
>> -}
>> -
>> -static int replicator_runtime_resume(struct device *dev)
>> -{
>> -	struct replicator_state *drvdata = dev_get_drvdata(dev);
>> -
>> -	if (drvdata && !IS_ERR(drvdata->atclk))
>> -		clk_prepare_enable(drvdata->atclk);
>> -
>> -	return 0;
>> -}
>> -#endif
>> -
>> -static const struct dev_pm_ops replicator_dev_pm_ops = {
>> -	SET_RUNTIME_PM_OPS(replicator_runtime_suspend,
>> -			   replicator_runtime_resume,
>> -			   NULL)
>> -};
>> -
>> -static struct amba_id replicator_ids[] = {
>> -	{
>> -		.id     = 0x0003b909,
>> -		.mask   = 0x0003ffff,
>> -		.data	= "REPLICATOR 1.0",
>> -	},
>> -	{ 0, 0 },
>> -};
>> -
>> -static struct amba_driver replicator_driver = {
>> -	.drv = {
>> -		.name	= "coresight-replicator-qcom",
>> -		.pm	= &replicator_dev_pm_ops,
>> -		.suppress_bind_attrs = true,
>> -	},
>> -	.probe		= replicator_probe,
>> -	.id_table	= replicator_ids,
>> -};
>> -builtin_amba_driver(replicator_driver);
>> --
>> 2.7.5
>>

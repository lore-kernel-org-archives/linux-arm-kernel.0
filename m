From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 30 Apr 2015 22:53:45 +0200
Subject: [PATCH 1/2] coresight: replicator: Add Qualcomm CoreSight
 Replicator driver
In-Reply-To: <1430310000-10867-2-git-send-email-ivan.ivanov@linaro.org>
References: <1430310000-10867-1-git-send-email-ivan.ivanov@linaro.org>
 <1430310000-10867-2-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1430427225.2187.15.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-29 at 15:19 +0300, Ivan T. Ivanov wrote:

> +config CORESIGHT_QCOM_REPLICATOR
> +	bool "Qualcomm CoreSight Replicator driver"
> +	help
> +	  This enables support for CoreSight link and sink driver that are
> +	  responsible for transporting and collecting the trace data
> +	  respectively. Link and sinks are dynamically aggregated with a trace
> +	  entity at run time to form a complete trace path.

> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile

> +obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o

CORESIGHT_QCOM_REPLICATOR is a bool symbol. So
coresight-replicator-qcom.o will never be part of a module.

(If that's incorrect, you can stop reading here.)

> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c

> +#include <linux/module.h>

Is this include needed?

> +static struct amba_driver replicator_driver = {
> +	.drv = {
> +		.name	= "coresight-replicator-qcom",
> +		.owner	= THIS_MODULE,

For built-in only code THIS_MODULE will be, basically, equivalent to
NULL (see include/linux/export.h). So I suppose this line can be
dropped.

> +		.pm	= &replicator_dev_pm_ops,
> +	},
> +	.probe		= replicator_probe,
> +	.remove		= replicator_remove,
> +	.id_table	= replicator_ids,
> +};
> +
> +module_amba_driver(replicator_driver);

For built-in only code this is, assuming I grepped this correctly,
equivalent to calling
    amba_driver_register(&replicator_driver);

from within a function marked with some sort of *initcall().

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Qualcomm CoreSight Replicator driver");

For built-in only code these macros will be effectively preprocessed
away.

Thanks,


Paul Bolle

From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 24 Apr 2015 18:05:23 +0300
Subject: [PATCH 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1429887923.5211.6.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 2015-04-22 at 16:40 -0600, Mathieu Poirier wrote:
> From: Pratik Patel <pratikp@codeaurora.org>
> 
> This driver manages the CoreSight ETMv4 (Embedded Trace Macrocell) IP block
> to support HW assisted tracing on ARMv7 and ARMv8 architectures.
> 
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> Signed-off-by: Mathieu Poirier poirier at linaro.org>

<snip>

> 

> +       pm_runtime_put(&adev->dev);
> +
> +       desc->type = CORESIGHT_DEV_TYPE_SOURCE;
> +       desc->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> +       desc->ops = &etm4_cs_ops;
> +       desc->pdata = pdata;
> +       desc->dev = dev;
> +       desc->groups = coresight_etmv4_groups;
> +       drvdata->csdev = coresight_register(desc);
> +       if (IS_ERR(drvdata->csdev)) {
> +               ret = PTR_ERR(drvdata->csdev);
> +               goto err_arch_supported;

double runtime put.

> +       }
> +
> +       dev_info(dev, "%s initialized\n", (char *)id->data);
> +
> +       if (boot_enable) {
> +               coresight_enable(drvdata->csdev);
> +               drvdata->boot_enable = true;
> +       }
> +
> +       return 0;
> +
> +err_arch_supported:
> +       pm_runtime_put(&adev->dev);
> +       if (--etm4_count == 0)
> +               unregister_hotcpu_notifier(&etm4_cpu_notifier);
> +       return ret;
> +}

Regards,
Ivan

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 13:30:06 +0200
Subject: [PATCH v3 21/22] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
In-Reply-To: <1506604306-20739-22-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-22-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a3pAFKM+Dq_yb7KYhB+xeneVuODBq_4nacEuw9creT6Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int scmi_cpufreq_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       handle = devm_scmi_handle_get(&pdev->dev);
> +
> +       if (IS_ERR_OR_NULL(handle) || !handle->perf_ops)
> +               return -EPROBE_DEFER;

As mentioned before, never create an interface that needs to use
IS_ERR_OR_NULL(), make it return either NULL on error, or always
have an error code.

> +
> +static struct platform_driver scmi_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "scmi-cpufreq",
> +       },
> +       .probe          = scmi_cpufreq_probe,
> +       .remove         = scmi_cpufreq_remove,
> +};

You appear to have split this driver into the 'cpufreq' side and
the 'protocol' handler in a different file. I already commented that
the way the main scmi driver knows about all the protocols looks
bad, here we can see another aspect of the same problem.

Rather than manually register a platform_device for the purpose
of connecting it to the cpufreq driver, there should be a way
to dynamically register the protocol from the cpufreq driver
and then have both in the same file.

      Arnd

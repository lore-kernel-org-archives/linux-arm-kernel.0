From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Oct 2013 11:00:44 +0100
Subject: [PATCH 6/6] cpufreq: probe the Integrator cpufreq driver from DT
In-Reply-To: <1380816238-3255-1-git-send-email-linus.walleij@linaro.org>
References: <1380816238-3255-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131008100044.GF28972@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding devicetree to Cc]

Hi Linus,

[...]

> +static int __init integrator_cpufreq_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	cm_base = of_iomap(np, 0);
> +	if (!cm_base)
> +		return -ENODEV;
>  	return cpufreq_register_driver(&integrator_driver);

If we fail to register the driver we could unmap cm_base, no?

>  }
>  
> -static void __exit integrator_cpu_exit(void)
> +static void __exit integrator_cpufreq_remove(struct platform_device *pdev)
>  {
>  	cpufreq_unregister_driver(&integrator_driver);

Unmap here?

>  }
>  
> +static const struct of_device_id integrator_cpufreq_match[] = {
> +	{ .compatible = "arm,core-module-integrator"},
> +	{ },
> +};

It feels a little scary that this also got handled by some other code in
the previous patch. Is no arbitrarion required between the two when
accessing the core module registers?

Cheers,
Mark.

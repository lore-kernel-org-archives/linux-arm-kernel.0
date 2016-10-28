From: oss@buserror.net (Scott Wood)
Date: Thu, 27 Oct 2016 23:45:56 -0500
Subject: [v13, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <1477625554-46700-6-git-send-email-yangbo.lu@nxp.com>
References: <1477625554-46700-1-git-send-email-yangbo.lu@nxp.com>
 <1477625554-46700-6-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1477629956.6812.15.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-28 at 11:32 +0800, Yangbo Lu wrote:
> +	guts->regs = of_iomap(np, 0);
> +	if (!guts->regs)
> +		return -ENOMEM;
> +
> +	/* Register soc device */
> +	machine = of_flat_dt_get_machine_name();
> +	if (machine)
> +		soc_dev_attr.machine = devm_kstrdup(dev, machine,
> GFP_KERNEL);
> +
> +	svr = fsl_guts_get_svr();
> +	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> +	if (soc_die) {
> +		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
> +						?????"QorIQ %s", soc_die-
> >die);
> +	} else {
> +		soc_dev_attr.family = devm_kasprintf(dev, GFP_KERNEL,
> "QorIQ");
> +	}
> +	soc_dev_attr.soc_id = devm_kasprintf(dev, GFP_KERNEL,
> +					?????"svr:0x%08x", svr);
> +	soc_dev_attr.revision = devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
> +					???????SVR_MAJ(svr), SVR_MIN(svr));
> +
> +	soc_dev = soc_device_register(&soc_dev_attr);
> +	if (IS_ERR(soc_dev))
> +		return PTR_ERR(soc_dev);

ioremap leaks on this error path. ?Use devm_ioremap_resource().

-Scott

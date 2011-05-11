From: joshc@linux.com (Josh Cartwright)
Date: Tue, 10 May 2011 21:47:09 -0500
Subject: [PATCH 2/4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110511024709.GA16868@kryptos.austin.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 09:16:38PM +0200, Linus Walleij wrote:
[]
> +
> +static int __init u300_pmx_probe(struct platform_device *pdev)
> +{
[]
> +	upmx->phybase = res->start;
> +	upmx->physize = resource_size(res);
> +
> +	if (request_mem_region(upmx->phybase, upmx->physize,
> +			       DRIVER_NAME) == NULL) {
> +		ret = -EBUSY;
> +		goto out_no_memregion;
> +	}
> +
> +	upmx->virtbase = ioremap(upmx->phybase, upmx->physize);
> +	if (!upmx->virtbase) {
> +		ret = -ENOMEM;
> +		goto out_no_remap;
> +	}
> +
> +	upmx->pmx = pinmux_register(&u300_pmx_desc, &pdev->dev, upmx);
> +	if (IS_ERR(upmx->pmx)) {
> +		ret = PTR_ERR(upmx->pmx);
> +		goto out_no_pmx;
> +	}
> +	platform_set_drvdata(pdev, upmx);
> +
> +	dev_info(&pdev->dev, "initialized U300 pinmux driver\n");
> +
> +	return 0;
> +
> +out_no_pmx:
> +	iounmap(upmx->virtbase);
> +out_no_remap:
> +	platform_set_drvdata(pdev, NULL);
> +out_no_memregion:
> +	release_mem_region(upmx->phybase, SZ_4K);

release_mem_region(upmx->phybase, upmx->physize); ?

-- 
                           joshc

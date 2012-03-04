From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Mar 2012 13:55:04 +0800
Subject: [PATCH v7 1/2] mfd: Add anatop mfd driver
In-Reply-To: <1330796352-6884-1-git-send-email-paul.liu@linaro.org>
References: <1330671641-6439-1-git-send-email-paul.liu@linaro.org>
 <1330796352-6884-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120304055500.GC10743@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, one more missing ...

On Sun, Mar 04, 2012 at 01:39:12AM +0800, Ying-Chun Liu (PaulLiu) wrote:
...
> +static int of_anatop_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	void *ioreg;
> +	struct anatop *drvdata;
> +
> +	ioreg = of_iomap(np, 0);
> +	if (!ioreg)
> +		return -EINVAL;
> +	drvdata = devm_kzalloc(dev, sizeof(struct anatop), GFP_KERNEL);

sizeof(*drvdata) please.

Documentation/CodingStyle, Chapter 14:

The preferred form for passing a size of a struct is the following:

        p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not.

> +	if (!drvdata)
> +		return -EINVAL;
> +	drvdata->ioreg = ioreg;
> +	spin_lock_init(&drvdata->reglock);
> +	platform_set_drvdata(pdev, drvdata);
> +	of_platform_bus_probe(np, of_anatop_subdevice_match, dev);
> +
> +	return 0;
> +}

-- 
Regards,
Shawn

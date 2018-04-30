From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 30 Apr 2018 15:58:32 +0200
Subject: [PATCH 06/17] irqchip/irq-mvebu-icu: switch to regmap
In-Reply-To: <20180421135537.24716-7-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-7-miquel.raynal@bootlin.com>
Message-ID: <20180430155832.62510f26@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 15:55:26 +0200, Miquel Raynal wrote:

> +	icu->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, NULL);
> +	if (IS_ERR(icu->regmap))
> +		return PTR_ERR(icu->regmap);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	icu->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(icu->base)) {
> -		dev_err(&pdev->dev, "Failed to map icu base address.\n");
> -		return PTR_ERR(icu->base);
> -	}
> +	if (!res)
> +		return -ENODEV;

Another issue with relying on the "syscon" compatible string: your ICU
driver now *requires* that the DT has the "syscon" compatible string.
Otherwise, no regmap is created, and your
syscon_regmap_lookup_by_phandle() call will fail.

In fact, there is a very good hint that something is wrong in terms of
backward compatibility: your patch

  arm64: dts: marvell: add syscon compatible to CP110 ICU node

comes early in the series, separated from other DT changes. It should
come at the end of the series, with the rest of the DT changes. By
doing this, you could test your series with the driver changes, but not
the DT changes, and would have realized that the driver change in this
patch (PATCH 06/17) breaks DT backward compatibility.

This is IMO another good reason to not use the "syscon" property, but
simply have the driver initialize the regmap by itself. This will work
even with old DTs, as it will become just an internal implementation
detail of the driver.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

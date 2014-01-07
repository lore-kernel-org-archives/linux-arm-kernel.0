From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 7 Jan 2014 21:57:19 +0100
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
Message-ID: <20140107205719.GL20094@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 19:57 +0100, Geert Uytterhoeven wrote:
> 
> @@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	spin_lock_init(&common->lock);
>  	common->dev = dev;
>  
> +	common->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(common->clk)) {
> +		dev_err(&pdev->dev, "cannot get clock\n");
> +		return PTR_ERR(common->clk);
> +	}
> +
> +	ret = clk_prepare(common->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to prepare clock\n");
> +		return ret;
> +	}
> +
> +	clk_enable(common->clk);
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);

clk_enable() can fail, too, so you should check its return value


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de

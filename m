From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Mar 2011 10:15:13 +0000
Subject: [PATCH] macb: detect IP version to determin if we are on at91
	or avr32
In-Reply-To: <1299863585-17263-1-git-send-email-plagnioj@jcrosoft.com>
References: <1299863585-17263-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110314101512.GA26085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 06:13:05PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> +	if (macb_is_at91(bp)) {
> +		bp->pclk = clk_get(&pdev->dev, "macb_clk");
> +		if (IS_ERR(bp->pclk)) {
> +			dev_err(&pdev->dev, "failed to get macb_clk\n");
> +			goto err_out_free_dev;
> +		}
> +		clk_enable(bp->pclk);
> +	} else {
> +		bp->pclk = clk_get(&pdev->dev, "pclk");
> +		if (IS_ERR(bp->pclk)) {
> +			dev_err(&pdev->dev, "failed to get pclk\n");
> +			goto err_out_free_dev;
> +		}
> +		bp->hclk = clk_get(&pdev->dev, "hclk");
> +		if (IS_ERR(bp->hclk)) {
> +			dev_err(&pdev->dev, "failed to get hclk\n");
> +			goto err_out_put_pclk;
> +		}
> +
> +		clk_enable(bp->pclk);
> +		clk_enable(bp->hclk);
> +	}

This is the same kind of sillyness that started getting OMAP into problems
with the clk API.  Just do this instead:

	bp->pclk = clk_get(&pdev->dev, "pclk");
	if (IS_ERR(bp->pclk)) {
		dev_err(&pdev->dev, "failed to get pclk\n");
		goto err_out_free_dev;
	}
	bp->hclk = clk_get(&pdev->dev, "hclk");
	if (IS_ERR(bp->hclk)) {
		dev_err(&pdev->dev, "failed to get hclk\n");
		goto err_out_put_pclk;
	}

	clk_enable(bp->pclk);
	clk_enable(bp->hclk);

And then require _all_ platforms using this driver to provide a pclk and
a hclk for this device, whether they exist in the SoC or not.  Where they
don't, provide dummy clocks for it.

This probably means you end up with _less_ bloat overall because you're
not having to build the above code.  You've less lines of source code to
maintain.  You have a simplified dirver with consistent requirements
across all platforms.  You don't need to read the version register, and
you don't need macb_is_at91() and macb_is_avr32().

With clkdev it's _cheap_ to provide these dummy clocks once you have one
dummy clock already in place.

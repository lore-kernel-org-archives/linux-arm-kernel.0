From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 3 Apr 2015 15:57:27 +0300
Subject: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
In-Reply-To: <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20150403125727.GT10964@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 02:42:02PM +0200, Geert Uytterhoeven wrote:
> +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
> +{
> +	struct clk *clk;
> +	int error;
> +
> +	pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
> +		 bsc->con_id, bsc->dev_id);
> +	clk = clk_get(NULL, bsc->clk);
> +	if (IS_ERR(clk)) {
> +		error = PTR_ERR(clk);
> +		pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
> +		return error;
> +	}
> +
> +	error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
> +	if (error)
> +		pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
> +		return error;

Missing curly braces.  Also it's weird that don't we need a clk_put()
on the error patch as well as the success path?

> +
> +	clk_put(clk);
> +	return 0;
> +}


regards,
dan carpenter

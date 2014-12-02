From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Dec 2014 09:48:05 +0100
Subject: [PATCH 1/2] clk: Do not complain about correctly set read-only
 muxes when assigning clock parents from device tree
In-Reply-To: <1417452162-20046-1-git-send-email-p.zabel@pengutronix.de>
References: <1417452162-20046-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20141202084805.GE2129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp,

On Mon, Dec 01, 2014 at 05:42:42PM +0100, Philipp Zabel wrote:
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index aad4796..ca8dc86 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -62,7 +62,8 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
>  			goto err;
>  		}
>  
> -		rc = clk_set_parent(clk, pclk);
> +		if (pclk != __clk_get_parent(clk))
> +			rc = clk_set_parent(clk, pclk);
>  		if (rc < 0)
>  			pr_err("clk: failed to reparent %s to %s: %d\n",
>  			       __clk_get_name(clk), __clk_get_name(pclk), rc);
I'd move the check for rc < 0 into the body of the if you introduced.
i.e.:

	if (pclk != __clk_get_parent(clk)) {
		rc = clk_set_parent(clk, pclk);
		if (rc < 0)
			...
	}

Semantically it doesn't make a difference because rc is zero when this
code is reached, but it makes it a bit clearer.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

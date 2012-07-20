From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 20 Jul 2012 16:43:49 +0300
Subject: [PATCH] clk: fix return value check in clk_get
In-Reply-To: <1342791397-11732-1-git-send-email-pdeschrijver@nvidia.com>
References: <1342791397-11732-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120720134349.GC9437@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 03:36:37PM +0200, Peter De Schrijver wrote:
> of_clk_get_by_name returns an ERR_PTR on failure. Hence we should use IS_ERR()
> and not just check for a non NULL value.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/clkdev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 8f87b0f..d423c9b 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -157,7 +157,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  
>  	if (dev) {
>  		clk = of_clk_get_by_name(dev->of_node, con_id);
> -		if (clk && __clk_get(clk))
> +		if (!IS_ERR(clk) && __clk_get(clk))
>  			return clk;
>  	}

http://www.spinics.net/lists/arm-kernel/msg184794.html introduces this
behaviour of of_clk_get_by_name()

Cheers,

Peter.

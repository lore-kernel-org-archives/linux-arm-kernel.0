From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 10 Feb 2011 17:37:57 +0800
Subject: [RFC, PATCH 3/3] clk: add warnings for incorrect
	enable/prepare semantics
In-Reply-To: <1297233693.243373.411051105619.3.gpush@pororo>
References: <1297233693.241680.897691111624.0.gpush@pororo>
	<1297233693.243373.411051105619.3.gpush@pororo>
Message-ID: <20110210093756.GA24710@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Wed, Feb 09, 2011 at 02:41:33PM +0800, Jeremy Kerr wrote:
> This change adds warnings to check for:
> 
>  1) enabling a clock that hasn't been prepared; and
> 
>  2) unpreparing a clock that is still enabled
> 
> While the correctness can't be guaranteed, the warnings should cover
> most situations, and won't indicate false positives.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  drivers/clk/clk.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index bbbdb0d..8c96623 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -29,6 +29,8 @@ EXPORT_SYMBOL_GPL(clk_prepare);
>  
>  void clk_unprepare(struct clk *clk)
>  {
> +	WARN_ON(clk->enable_count != 0);
> +
Other drivers may be using the clock and increased the enable_count.
This check may be moved to where we actually do unprepare.

Thanks
Richard
>  	mutex_lock(&clk->prepare_lock);
>  
>  	WARN_ON(clk->prepare_count == 0);
> @@ -45,6 +47,8 @@ int clk_enable(struct clk *clk)
>  	unsigned long flags;
>  	int ret = 0;
>  
> +	WARN_ON(clk->prepare_count == 0);
> +
>  	spin_lock_irqsave(&clk->enable_lock, flags);
>  	if (clk->enable_count == 0 && clk->ops->enable)
>  		ret = clk->ops->enable(clk);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

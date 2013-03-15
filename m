From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 17:45:58 +0000
Subject: [RFC v2 1/1] clk: Add notifier support in
 clk_prepare/clk_unprepare
In-Reply-To: <1363253464-3200-1-git-send-email-bilhuang@nvidia.com>
References: <1363253464-3200-1-git-send-email-bilhuang@nvidia.com>
Message-ID: <20130315174558.GS4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 02:31:04AM -0700, Bill Huang wrote:
> Add the below two notifier events so drivers which are interested in
> knowing the clock status can act accordingly. This is extremely useful
> in some of the DVFS (Dynamic Voltage Frequency Scaling) design.
> 
> CLK_PREPARED
> CLK_UNPREPARED
> 
> Signed-off-by: Bill Huang <bilhuang@nvidia.com>
> ---
>  drivers/clk/clk.c   |    3 +++
>  include/linux/clk.h |    2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed87b24..3292cec 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -550,6 +550,7 @@ void clk_unprepare(struct clk *clk)
>  {
>  	mutex_lock(&prepare_lock);
>  	__clk_unprepare(clk);
> +	__clk_notify(clk, CLK_UNPREPARED, clk->rate, clk->rate);
>  	mutex_unlock(&prepare_lock);
>  }
>  EXPORT_SYMBOL_GPL(clk_unprepare);
> @@ -598,6 +599,8 @@ int clk_prepare(struct clk *clk)
>  
>  	mutex_lock(&prepare_lock);
>  	ret = __clk_prepare(clk);
> +	if (!ret)
> +		__clk_notify(clk, CLK_PREPARED, clk->rate, clk->rate);

So, on prepare, we notify after we've prepared the clock.  On unprepare,
we notify after the clock has been shut down.  Are you sure that's the
correct ordering?  Would it not be better to view it in a stack-like
fashion, iow:

get
	prepare
		notify-prepare
			enable
			disable
		notify-unprepare
	unprepare
put

?

> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index b3ac22d..16c1d92 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -43,6 +43,8 @@ struct clk;
>  #define PRE_RATE_CHANGE			BIT(0)
>  #define POST_RATE_CHANGE		BIT(1)
>  #define ABORT_RATE_CHANGE		BIT(2)
> +#define CLK_PREPARED			BIT(3)
> +#define CLK_UNPREPARED			BIT(4)

This implies that we're only going to have a maximum of 32 reason codes
here.  Is that enough?

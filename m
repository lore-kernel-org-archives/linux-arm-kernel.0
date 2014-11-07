From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Nov 2014 18:58:44 +0000
Subject: [PATCH] clk: Propagate prepare and enable when reparenting orphans
In-Reply-To: <1415386312-23741-1-git-send-email-dianders@chromium.org>
References: <1415386312-23741-1-git-send-email-dianders@chromium.org>
Message-ID: <20141107185844.GR4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 10:51:52AM -0800, Doug Anderson wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 4896ae9..a3d3d58 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1650,6 +1650,17 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
>  	clk_reparent(clk, new_parent);
>  	__clk_recalc_accuracies(clk);
>  	__clk_recalc_rates(clk, POST_RATE_CHANGE);
> +
> +	if (clk->prepare_count) {
> +		unsigned long flags;
> +
> +		__clk_prepare(new_parent);
> +
> +		flags = clk_enable_lock();
> +		if (clk->enable_count)
> +			__clk_enable(new_parent);
> +		clk_enable_unlock(flags);
> +	}

I really don't understand why this isn't already done - I said this was
necessary a /long/ time ago.

However, the above isn't sufficient.  Think about the old parent - this
should be disabled and unprepared if it was prepared and enabled by the
child.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

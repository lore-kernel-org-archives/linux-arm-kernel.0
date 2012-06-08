From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 8 Jun 2012 15:37:57 -0700
Subject: [PATCH] clk: validate pointer in __clk_disable()
In-Reply-To: <20120607045259.GA16232@localhost>
References: <20120606214621.GA8892@localhost>
 <20120606145113.f0c8ddcf.akpm@linux-foundation.org>
 <20120606215951.GA9123@localhost>
 <20120606150619.8567afb4.akpm@linux-foundation.org>
 <20120606224225.GA9435@localhost>
 <20120606224958.GA20538@n2100.arm.linux.org.uk>
 <20120606230340.GA9990@localhost>
 <20120606235438.GB20538@n2100.arm.linux.org.uk>
 <20120607045259.GA16232@localhost>
Message-ID: <20120608153757.8df63e6b.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


(cc viresh kumar <viresh.linux@gmail.com>!)

On Thu, 7 Jun 2012 13:52:59 +0900
Fengguang Wu <fengguang.wu@intel.com> wrote:

> clk_get() returns -ENOENT on error and some careless caller might
> dereference it without error checking:
> 
> In mxc_rnga_remove():
> 
>         struct clk *clk = clk_get(&pdev->dev, "rng");
> 
> 	// ...
> 
>         clk_disable(clk);
> 
> Since it's insane to audit the lots of existing and future clk users,
> let's add a check in the callee to avoid kernel panic and warn about
> any buggy user.
> ---
>  drivers/clk/clk.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 687b00d..7bd795bf9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -464,6 +464,9 @@ static void __clk_disable(struct clk *clk)
>  	if (!clk)
>  		return;
>  
> +	if (WARN_ON(IS_ERR(clk)))
> +		return;
> +
>  	if (WARN_ON(clk->enable_count == 0))
>  		return;

Fair enough.

But the build breakage reported by Paul remains, and the patchset
remains unmerged.

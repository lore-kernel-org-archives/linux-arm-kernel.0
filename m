From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 13 Apr 2012 13:16:04 +0200
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
In-Reply-To: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
References: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
Message-ID: <20120413111604.GA20977@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 12:04:57PM +0530, Viresh Kumar wrote:
> clock lookups are required for few clocks for which we do clk_get() or
> clk_get_sys(). Adding clock lookups for them with new clock framework, would
> mean a lot of code for each platform. Simplify this by doing this allocation and
> addition to global list in clk_register() only.
> 
> This is done on request by the caller, i.e. only if user passes valid pointers
> in "dev_id" OR "con_id" fields.
> 
> A lot of changes at other places/files/comments are also required, that i would
> do separately. This is the initial version to get initial feedback.
> 
> Pointer to original discussion:
> http://www.spinics.net/lists/arm-kernel/msg169133.html
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/clk/clk.c            |   33 ++++++++++++++++++++++++++-------
>  include/linux/clk-provider.h |    4 +++-
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2bcce5a..16ce136 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1373,19 +1375,36 @@ struct clk *clk_register(struct device *dev, const char *name,
>  		}
>  	}
>  
>  	ret = __clk_init(dev, clk);
> -	if (!ret)
> -		return clk;
> +	if (ret)
> +		goto free_parents;
> +
> +	if (dev_id || con_id) {
> +		struct clk_lookup *lookup;
> +
> +		lookup = clkdev_alloc(clk, dev_id, con_id);
> +		if (!lookup) {
> +			ret = ENODEV;
> +			goto free_parents;
> +		}
> +
> +		clkdev_add(lookup);
> +
> +		if (cl)
> +			*cl = lookup;
> +	}
> +
> +	return clk;

Basically this is the amount of code you want to save all around, right?

Why can't be this moved in a different function? So only who wants to
register the lookup will invoke it after clk_register().

cheers,
Domenico

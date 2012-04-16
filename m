From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 16 Apr 2012 12:25:03 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
Message-ID: <20120416102503.GA32687@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 10:49:37AM +0530, Viresh Kumar wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> With common clock framework, clks are allocated at runtime. Some of them require
> clkdevs to be allocated and added in global clkdev list.
> 
> This patch introduces helper routines to:
> 
>  - allocate and add single clkdev for a single clk structure.
>  - add multiple clkdevs for a single clk structure.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/clk/clkdev.c   |   33 +++++++++++++++++++++++++++++++++
>  include/linux/clkdev.h |    3 +++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 6db161f..6a98177 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -173,3 +173,36 @@ void clkdev_drop(struct clk_lookup *cl)
>  	kfree(cl);
>  }
>  EXPORT_SYMBOL(clkdev_drop);
> +
> +int clk_register_single_clkdev(struct clk *clk, const char *dev_id,
> +		const char *con_id)
> +{
> +	struct clk_lookup *cl;
> +
> +	if (!clk || (!dev_id && !con_id))
> +		return -ENOMEM;

I would return -EINVAL here.

> +
> +	cl = clkdev_alloc(clk, con_id, "%s", dev_id);

clkdev_alloc() allows you to specify dev_fmt and possibly other arguments
to build the dev_id on the fly, could clk_register_single_clkdev()
preserve this ability?

> +	if (!cl)
> +		return -ENOMEM;
> +
> +	clkdev_add(cl);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_register_single_clkdev);
> +
> +int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
> +{
> +	unsigned i;
> +
> +	if (!clk || !cl || !num)
> +		return -ENOMEM;

I would return -EINVAL here as well.

> +
> +	for (i = 0; i < num; i++, cl++) {
> +		cl->clk = clk;
> +		clkdev_add(cl);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_register_clkdevs);

cheers,
Domenico

From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 16:10:12 +0530
Subject: [PATCH v3 05/16] ARM: davinci: add set_parent callback for mux
 clocks
In-Reply-To: <1458863503-31121-6-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-6-git-send-email-david@lechnology.com>
Message-ID: <570B7F0C.8000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 05:21 AM, David Lechner wrote:
> Introduce a set_parent callback that will be used for mux clocks, such as
> the USB PHY muxes and the async3 clock domain mux.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes: none.
> 
> 
>  arch/arm/mach-davinci/clock.c | 17 ++++++++++++++++-
>  arch/arm/mach-davinci/clock.h |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> index a5c2629..dfc2eb3 100644
> --- a/arch/arm/mach-davinci/clock.c
> +++ b/arch/arm/mach-davinci/clock.c
> @@ -195,6 +195,13 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  		return -EINVAL;
>  
>  	mutex_lock(&clocks_mutex);
> +	if (clk->set_parent) {
> +		int ret = clk->set_parent(clk, parent);

Need empty line here.

> +		if (ret) {
> +			mutex_unlock(&clocks_mutex);
> +			return ret;
> +		}
> +	}
>  	clk->parent = parent;
>  	list_del_init(&clk->childnode);
>  	list_add(&clk->childnode, &clk->parent->children);
> @@ -224,8 +231,16 @@ int clk_register(struct clk *clk)
>  
>  	mutex_lock(&clocks_mutex);
>  	list_add_tail(&clk->node, &clocks);
> -	if (clk->parent)
> +	if (clk->parent) {
> +		if (clk->set_parent) {
> +			int ret = clk->set_parent(clk, clk->parent);

Here too. Applying this patch with these local changes.

BTW, checkpatch complained about these. Please try to address all
warnings unless there is a good reason not to fix one.

Thanks,
Sekhar

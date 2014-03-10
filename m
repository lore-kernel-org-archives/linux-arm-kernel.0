From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Mar 2014 10:51:17 +0000
Subject: [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for
 indices field
In-Reply-To: <1394196400-17112-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394196400-17112-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20140310105116.GG14999@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 12:46:40PM +0000, Ben Dooks wrote:
> Add comaptibiltiy for older device trees by checking to see if
> the clock-indices property is there and falling back to the
> older renesas,clock-indices field.

Why are these two separate patches? This temporarily breaks
compatibility.

> 
> This can be removed once all device-trees are converted.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/clk/shmobile/clk-mstp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index 95a2aa7..fe63d40 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -156,6 +156,7 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
>  static void __init cpg_mstp_clocks_init(struct device_node *np)
>  {
>  	struct mstp_clock_group *group;
> +	const char *idxname;
>  	struct clk **clks;
>  	unsigned int i;
>  
> @@ -184,6 +185,11 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>  	for (i = 0; i < MSTP_MAX_CLOCKS; ++i)
>  		clks[i] = ERR_PTR(-ENOENT);
>  
> +	if (of_find_property(np, "clock-indices", &i))

s/&i/NULL/ (or use of_property_read_bool).

Cheers,
Mark.

> +		idxname = "clock-indices";
> +	else
> +		idxname = "renesas,clock-indices";
> +
>  	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
>  		const char *parent_name;
>  		const char *name;
> @@ -197,8 +203,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>  			continue;
>  
>  		parent_name = of_clk_get_parent_name(np, i);
> -		ret = of_property_read_u32_index(np, "clock-indices", i,
> -						 &clkidx);
> +		ret = of_property_read_u32_index(np, idxname, i, &clkidx);
>  		if (parent_name == NULL || ret < 0)
>  			break;
>  
> -- 
> 1.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

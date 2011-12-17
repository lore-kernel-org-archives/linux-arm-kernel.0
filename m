From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 17:37:04 -0700 (MST)
Subject: [PATCH 2/2] OMAP4: mcbsp: Clock reparenting support
In-Reply-To: <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com>
References: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
 <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1112161730080.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi P?ter

On Thu, 15 Dec 2011, Peter Ujfalusi wrote:

> With OMAP4 the clock names are different compared to OMAP2/3. The 
> internal fclk name depends on the McBSP instance number. In case of 
> MCBSP_TYPE4 (OMAP4) we should use different clock selection method 
> compared to OMAP2/3.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |   29 ++++++++++++++++++++++++++---
>  1 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 9129003..829f4c7 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -111,6 +111,23 @@ static int omap2_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
>  	return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
>  }
>  
> +/* McBSP CLKS source switching for OMAP4 */
> +static int omap4_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
> +				   const char *src)
> +{
> +	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
> +	char fck_src_name[30];
> +
> +	if (!strcmp(src, "clks_ext"))
> +		strcpy(fck_src_name, "pad_clks_ck");
> +	else if (!strcmp(src, "clks_fclk"))
> +		sprintf(fck_src_name, "mcbsp%d_sync_mux_ck", mcbsp->id);
> +	else
> +		return -EINVAL;
> +
> +	return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
> +}

What do you think about using clkdev alias lines and hwmod optional clks 
for this instead?  With these mechanisms, you can give clocks a consistent 
"role name" for a given device, even if the underlying clock changes on 
different platforms.

So in the mach-omap2/clock*_data.c files, you'd do something like

	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,  CK_3XXX),

for OMAP3, and 

	CLK("omap-mcbsp.1",	"pad_fck",	&pad_clks_clk,  CK_44XX),

for OMAP4.

Then in the hwmod data files, you'd add them as optional clocks - 
something like:

static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
	{ .role = "pad_fck", .clk = "mcbsp_clks" },
};

for OMAP3, and

static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
	{ .role = "pad_fck", .clk = "pad_clks_clk" },
};

for OMAP4.

I think this might work for your needs?


- Paul

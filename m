From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 May 2012 01:49:21 -0600 (MDT)
Subject: [PATCH] ARM: OMAP3+: dpll: optimize noncore dpll locking logic
In-Reply-To: <1337369838-15185-1-git-send-email-nm@ti.com>
References: <1337369838-15185-1-git-send-email-nm@ti.com>
Message-ID: <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth

On Fri, 18 May 2012, Nishanth Menon wrote:

> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> If the dpll is already locked, code can be optimized
> to return much earlier than doing redundent set of lock mode
> and wait on idlest.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Did you intend to add your Signed-off-by: to this patch?

Also, just FYI, no need to add the Cc: lines for the mailing lists in the 
bottom of the patch description.

- Paul


> ---
>  arch/arm/mach-omap2/dpll3xxx.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index fc56745..3cfd7c4 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -135,11 +135,20 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
>   */
>  static int _omap3_noncore_dpll_lock(struct clk *clk)
>  {
> +	const struct dpll_data *dd;
>  	u8 ai;
> -	int r;
> +	u8 state = 1;
> +	int r = 0;
>  
>  	pr_debug("clock: locking DPLL %s\n", clk->name);
>  
> +	dd = clk->dpll_data;
> +	state <<= __ffs(dd->idlest_mask);
> +
> +	/* Check if already locked */
> +	if ((__raw_readl(dd->idlest_reg) & dd->idlest_mask) == state)
> +		goto done;
> +
>  	ai = omap3_dpll_autoidle_read(clk);
>  
>  	omap3_dpll_deny_idle(clk);
> @@ -151,6 +160,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
>  	if (ai)
>  		omap3_dpll_allow_idle(clk);
>  
> +done:
>  	return r;
>  }
>  
> -- 
> 1.7.9.5
> 


- Paul

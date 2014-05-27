From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 May 2014 10:49:32 -0700
Subject: linux-next: manual merge of the arm-soc tree with the  tree
In-Reply-To: <20140527104526.5c6f819e@canb.auug.org.au>
References: <20140527104526.5c6f819e@canb.auug.org.au>
Message-ID: <20140527174932.GB18063@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [140526 17:46]:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-omap2/omap-mpuss-lowpower.c between commit 4e4bb5c72f6b
> ("ARM: l2c: omap2: avoid reading directly from the L2 registers in
> platform code") from the arm tree and commit edfaf05c2fcb ("ARM:
> OMAP2+: raw read and write endian fix") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

OK thanks. FYI, looks like for this one the subject is missing which
tree it conflicts with.

Regards,

Tony
 
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@@ -187,15 -187,19 +187,15 @@@ static void l2x0_pwrst_prepare(unsigne
>    * in every restore MPUSS OFF path.
>    */
>   #ifdef CONFIG_CACHE_L2X0
>  -static void save_l2x0_context(void)
>  +static void __init save_l2x0_context(void)
>   {
> - 	__raw_writel(l2x0_saved_regs.aux_ctrl,
> - 		     sar_base + L2X0_AUXCTRL_OFFSET);
> - 	__raw_writel(l2x0_saved_regs.prefetch_ctrl,
> - 		     sar_base + L2X0_PREFETCH_CTRL_OFFSET);
>  -	u32 val;
>  -	void __iomem *l2x0_base = omap4_get_l2cache_base();
>  -	if (l2x0_base) {
>  -		val = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
>  -		writel_relaxed(val, sar_base + L2X0_AUXCTRL_OFFSET);
>  -		val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
>  -		writel_relaxed(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
>  -	}
> ++	writel_relaxed(l2x0_saved_regs.aux_ctrl,
> ++		       sar_base + L2X0_AUXCTRL_OFFSET);
> ++	writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
> ++		       sar_base + L2X0_PREFETCH_CTRL_OFFSET);
>   }
>   #else
>  -static void save_l2x0_context(void)
>  +static void __init save_l2x0_context(void)
>   {}
>   #endif
>   

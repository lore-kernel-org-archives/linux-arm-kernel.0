From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 09:22:23 +0000
Subject: [PATCH v3] clkdev: Detect errors in clk_hw_register_clkdev() for
 mass registration
In-Reply-To: <1477033358-7934-1-git-send-email-geert@linux-m68k.org>
References: <1477033358-7934-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20161031092223.GW1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 09:02:38AM +0200, Geert Uytterhoeven wrote:
> Unlike clk_register_clkdev(), clk_hw_register_clkdev() doesn't check for
> passed error objects from a previous registration call. Hence the caller
> of clk_hw_register_*() has to check for errors before calling
> clk_hw_register_clkdev*().
> 
> Make clk_hw_register_clkdev() more similar to clk_register_clkdev() by
> adding this error check, removing the burden from callers that do mass
> registration.
> 
> Fixes: e4f1b49bda6d6aa2 ("clkdev: Add clk_hw based registration APIs")
> Fixes: 944b9a41e004534f ("clk: ls1x: Migrate to clk_hw based OF and registration APIs")
> Fixes: 44ce9a9ae977736f ("MIPS: TXx9: Convert to Common Clock Framework")
> Fixes: f48d947a162dfa9d ("clk: clps711x: Migrate to clk_hw based OF and registration APIs")
> Fixes: b4626a7f489238a5 ("CLK: Add Loongson1C clock support")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Please put this in the patch system, thanks.

> ---
> v3:
>   - Add more Fixes tags for drivers not checking errors in v4.9-rc1,
> 
> v2:
>   - Correct wrong function references
>     s/clkdev_{,hw_}create/clk_{,hw_}register_clkdev/
> ---
>  drivers/clk/clkdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 97ae60fa15849954..bb8a77a5985f8627 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -448,12 +448,20 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
>   *
>   * con_id or dev_id may be NULL as a wildcard, just as in the rest of
>   * clkdev.
> + *
> + * To make things easier for mass registration, we detect error clk_hws
> + * from a previous clk_hw_register_*() call, and return the error code for
> + * those.  This is to permit this function to be called immediately
> + * after clk_hw_register_*().
>   */
>  int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
>  	const char *dev_id)
>  {
>  	struct clk_lookup *cl;
>  
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
>  	/*
>  	 * Since dev_id can be NULL, and NULL is handled specially, we must
>  	 * pass it as either a NULL format string, or with "%s".
> -- 
> 1.9.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

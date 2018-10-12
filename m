From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Fri, 12 Oct 2018 15:51:19 +0200
Subject: [PATCH resend] clk: at91: Fix division by zero in PLL
 recalc_rate()
In-Reply-To: <trinity-9c3a7e1f-73af-4a1a-b82c-cafd5aefa5e4-1539179694006@3c-app-gmx-bs12>
References: <trinity-9c3a7e1f-73af-4a1a-b82c-cafd5aefa5e4-1539179694006@3c-app-gmx-bs12>
Message-ID: <20181012135119.nufiexxssamzig6x@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 03:54:54PM +0200, Ronald Wahl wrote:
> Commit a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached MUL
> and DIV values") removed a check that prevents a division by zero. This
> now causes a stacktrace when booting the kernel on a at91 platform if
> the PLL DIV register contains zero. This commit reintroduces this check.
> 
> Fixes: a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached...")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ronald Wahl <rwahl@gmx.de>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/clk/at91/clk-pll.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 72b6091eb7b9..dc7fbc796cb6 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -133,6 +133,9 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
>  {
>  	struct clk_pll *pll = to_clk_pll(hw);
>  
> +	if (!pll->div || !pll->mul)
> +		return 0;
> +
>  	return (parent_rate / pll->div) * (pll->mul + 1);
>  }
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

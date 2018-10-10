From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 10 Oct 2018 15:26:15 +0200
Subject: [PATCH] clk: at91: Fix division by zero in PLL recalc_rate()
In-Reply-To: <fd2a1c19-8cb5-4db0-a2bb-6b0129162029@raritan.com>
References: <fd2a1c19-8cb5-4db0-a2bb-6b0129162029@raritan.com>
Message-ID: <20181010132615.f5xctpfywlf6n6ob@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ronald,

On Wed, Oct 10, 2018 at 10:31:31AM +0000, Ronald WAHL wrote:
> Commit a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached MUL
> and DIV values") removed a check that prevents a division by zero. This
> now causes a stacktrace when booting the kernel on a at91 platform if
> the PLL DIV register contains zero. This commit reintroduces this check.
> 
> Fixes: a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached...")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
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
>  struct clk_pll *pll = to_clk_pll(hw);
> 
> +if (!pll->div || !pll->mul)
> +return 0;
> +
>  return (parent_rate / pll->div) * (pll->mul + 1);
>  }

Weird indentation here. Patch doesn't apply.

Otherwise,
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Regards

Ludovic

From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 12 Jun 2013 23:19:42 +0200
Subject: [PATCH v4 1/6] clk: samsung: Use clk->base instead of directly
 using clk->con0 for PLL3xxx
In-Reply-To: <CAD=FV=VTLkH9oDqr263Kyv=wCEbuQ40VL7mtC73SCMt20NPwgQ@mail.gmail.com>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
 <1370272196-4346-2-git-send-email-yadi.brar@samsung.com>
 <CAD=FV=VTLkH9oDqr263Kyv=wCEbuQ40VL7mtC73SCMt20NPwgQ@mail.gmail.com>
Message-ID: <1501124.EVQA8KO0ic@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 12 of June 2013 13:33:50 Doug Anderson wrote:
> Yadwinder,
> 
> On Mon, Jun 3, 2013 at 8:09 AM, Yadwinder Singh Brar
> 
> <yadi.brar@samsung.com> wrote:
> > This patch unifies clk strutures used for PLL35xx & PLL36xx and uses
> > clk->base instead of directly using clk->con0, so that possible
> > common code can be factored out.
> > It also introdues common pll_[readl/writel] macros for the users of
> > common samsung_clk_pll struct.
> > 
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > Tested-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> > ---
> > 
> >  drivers/clk/samsung/clk-exynos4.c    |   10 ++++--
> >  drivers/clk/samsung/clk-exynos5250.c |   14 ++++----
> >  drivers/clk/samsung/clk-pll.c        |   54
> >  ++++++++++++++++++--------------- drivers/clk/samsung/clk-pll.h     
> >    |    4 +-
> >  4 files changed, 44 insertions(+), 38 deletions(-)
> 
> So.  We just found that this type of solution doesn't work on
> exynos5420, since the LOCK and CON registers aren't always 0x100 away
> from each other.

Oops, this is what I've been afraid of, ever since we assumed this first 
time in our internal patches.

> Perhaps you can adjust to use a solution like Andrew
> proposed in <https://gerrit.chromium.org/gerrit/#/c/58411/>?  That way
> we can avoid some churn of changing this code twice.
> 
> The number of parameters to the register PLL function is starting to
> get unwieldy.  At some point we'll probably want to pass in a
> structure.  I wonder if now would be the time?  Certainly it would be
> easier to handle changes to the code without touching all of the
> exynos variants...

Hmm, if done properly, it could simplify PLL registration in SoC clock 
initialization code a lot.

I'm not sure if this is really the best solution (feel free to suggest 
anything better), but we could put PLLs in an array, like other clocks, 
e.g.

	... exynos4210_pll_clks[] = {
		CLK_PLL45XX(...),
		CLK_PLL45XX(...),
		CLK_PLL46XX(...),
		CLK_PLL46XX(...),
	};

and then just call a helper like

	samsung_clk_register_pll(exynos4210_pll_clks,
			ARRAY_SIZE(exynos4210_pll_clks));

Best regards,
Tomasz

> Thanks!
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to
> majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

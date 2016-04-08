From: ralf@linux-mips.org (Ralf Baechle)
Date: Fri, 8 Apr 2016 12:06:00 +0200
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <20160408003328.GA14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
Message-ID: <20160408100600.GI1668@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 05:33:28PM -0700, Stephen Boyd wrote:

> On 04/05, Masahiro Yamada wrote:
> > The clk_disable() in the common clock framework (drivers/clk/clk.c)
> > returns immediately if a given clk is NULL or an error pointer.  It
> > allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
> > checking if drivers are only used with the common clock framework.
> > 
> > Unfortunately, NULL/error checking is missing from some of non-common
> > clk_disable() implementations.  This prevents us from completely
> > dropping NULL/error checking from callers.  Let's make it tree-wide
> > consistent by adding IS_ERR_OR_NULL(clk) to all callees.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Greg Ungerer <gerg@uclinux.org>
> > Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> > ---
> > 
> > Stephen,
> > 
> > This patch has been unapplied for a long time.
> > 
> > Please let me know if there is something wrong with this patch.
> > 
> 
> I'm mostly confused why we wouldn't want to encourage people to
> call clk_disable or unprepare on a clk that's an error pointer.
> Typically an error pointer should be dealt with, instead of
> silently ignored, so why wasn't it dealt with by passing it up
> the probe() path?

While your argument makes perfect sense, Many clk_disable implementations
are already doing similar checks, for example:

arch/arm/mach-davinci/clock.c:

void clk_disable(struct clk *clk)
{
	unsigned long flags;

	if (clk == NULL || IS_ERR(clk))
		return;
[...]

arch/arm/mach-omap1/clock.c

void clk_disable(struct clk *clk)
{
        unsigned long flags;

        if (clk == NULL || IS_ERR(clk))
                return;
[...]

arch/avr32/mach-at32ap/clock.c

void clk_disable(struct clk *clk)
{
        unsigned long flags;

        if (IS_ERR_OR_NULL(clk))
                return;
[...]

arch/mips/lantiq/clk.c:

static inline int clk_good(struct clk *clk)
{
	return clk && !IS_ERR(clk);
}

[...]

void clk_disable(struct clk *clk)
{
	if (unlikely(!clk_good(clk)))
		return;

	if (clk->disable)
[...]

So should we go and weed out these checks?

  Ralf

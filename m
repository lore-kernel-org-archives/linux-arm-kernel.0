From: mhban@samsung.com (mhban)
Date: Tue, 19 Oct 2010 11:55:53 +0900
Subject: [PATCH] ARM: SAMSUNG: Bug fix spin_lock recursion in clk_enable()
	and clk_disable()
In-Reply-To: <AANLkTimWLcPGTYp+ShXzVu11TtzThj5O57rWxqOfZV=0@mail.gmail.com>
References: <1286843980-23684-1-git-send-email-jc.lee@samsung.com>
	<4CBCD3A5.5070701@fluff.org>
	<AANLkTimWLcPGTYp+ShXzVu11TtzThj5O57rWxqOfZV=0@mail.gmail.com>
Message-ID: <1287456953.19640.43.camel@puffmine-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-10-19 at 10:12 +0900, Jassi Brar wrote:
> On Tue, Oct 19, 2010 at 8:09 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On 12/10/10 01:39, Jaecheol Lee wrote:
> >> From: Minho Ban <mhban@samsung.com>
> >>
> >> The clk_enable() and clk_disable() can be used process and ISR either.
> >> So spin_lock_irqsave should be used instead.
> >>
> >> Signed-off-by: Minho Ban <mhban@samsung.com>
> >> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> >> ---
> >>  arch/arm/plat-samsung/clock.c |   12 ++++++++----
> >>  1 files changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> >> index e8d20b0..2a991a5 100644
> >> --- a/arch/arm/plat-samsung/clock.c
> >> +++ b/arch/arm/plat-samsung/clock.c
> >> @@ -138,31 +138,35 @@ void clk_put(struct clk *clk)
> >>
> >>  int clk_enable(struct clk *clk)
> >>  {
> >> +     unsigned long flags;
> >> +
> >>       if (IS_ERR(clk) || clk == NULL)
> >>               return -EINVAL;
> >>
> >>       clk_enable(clk->parent);
> >>
> >> -     spin_lock(&clocks_lock);
> >> +     spin_lock_irqsave(&clocks_lock, flags);
> >>
> >>       if ((clk->usage++) == 0)
> >>               (clk->enable)(clk, 1);
> >>
> >> -     spin_unlock(&clocks_lock);
> >> +     spin_unlock_irqrestore(&clocks_lock, flags);
> >>       return 0;
> >>  }
> >>
> >>  void clk_disable(struct clk *clk)
> >>  {
> >> +     unsigned long flags;
> >> +
> >>       if (IS_ERR(clk) || clk == NULL)
> >>               return;
> >>
> >> -     spin_lock(&clocks_lock);
> >> +     spin_lock_irqsave(&clocks_lock, flags);
> >>
> >>       if ((--clk->usage) == 0)
> >>               (clk->enable)(clk, 0);
> >>
> >> -     spin_unlock(&clocks_lock);
> >> +     spin_unlock_irqrestore(&clocks_lock, flags);
> >>       clk_disable(clk->parent);
> >
> > I'm not sure, but I don't belive that the clk_ api has
> > ever been callable from non-sleepable contexts such as
> > interrupt handlers.
> >
> > I would welcome RMK's response (or any other response)
> > about this issue?
> >
> > Personally, given that some clk_ calls may sleep esp.
> > for pll enables, I would prefer to see this patch
> > dropped in favour of fixing the users.
> 
> I tend to agree.
> I would like to know any such case where enabling/disabling of some
> clock is so urgent as to require doing from ISR and not from a tasklet
> scheduled from ISR.
> Also let us not make it impossible in future to switch to common clock api
> by Jeremy Kerr, that doesn't allow calls from IRQ context.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello,

Mostly you are right but it would require some explicit comment in clk.h
(eg, clk_get/put) not to be confusing to the driver developer.

Thanks.

Regards,
Minho Ban

-- 
Minho Ban (mhban at samsung.com)
Senior Engineer
Platform R&D Team,  Mobile Comm.
SAMSUNG ELECTRONICS Co.Ltd.

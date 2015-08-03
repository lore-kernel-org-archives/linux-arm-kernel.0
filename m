From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 03 Aug 2015 22:50:33 +0200
Subject: [PATCH v1 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <CAD=FV=WCGtBgzy6=dWqZ5ZKLhxUsxLom56UfWwXNp+ospR4JRA@mail.gmail.com>
References: <1438574211-4887-1-git-send-email-hl@rock-chips.com>
 <1438574211-4887-2-git-send-email-hl@rock-chips.com>
 <CAD=FV=WCGtBgzy6=dWqZ5ZKLhxUsxLom56UfWwXNp+ospR4JRA@mail.gmail.com>
Message-ID: <2472708.6oReK8jXV2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. August 2015, 13:21:27 schrieb Doug Anderson:
> hl
> 
> On Sun, Aug 2, 2015 at 8:56 PM, huang lin <hl@rock-chips.com> wrote:
> > gpio can keep state even the clock disable, for save power
> > consumption, only enable gpio clock when it setting
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: huang lin <hl@rock-chips.com>
> > 
> > Signed-off-by: huang lin <hl@rock-chips.com>
> 
> Your "Signed-off-by"s are a little wonky here...  Can you fix up?
> 
> > ---
> > 
> >  drivers/pinctrl/pinctrl-rockchip.c | 60
> >  ++++++++++++++++++++++++++++++++++---- 1 file changed, 54 insertions(+),
> >  6 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> > b/drivers/pinctrl/pinctrl-rockchip.c index cc2843a..445829f 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > @@ -945,17 +945,20 @@ static int _rockchip_pmx_gpio_set_direction(struct
> > gpio_chip *chip,> 
> >         if (ret < 0)
> >         
> >                 return ret;
> > 
> > +       clk_enable(bank->clk);
> > 
> >         spin_lock_irqsave(&bank->slock, flags);
> > 
> > -       data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
> > +       data = readl(bank->reg_base + GPIO_SWPORT_DDR);
> 
> I am a little curious why you need to change the readl_relaxed() to a
> read().  Are you trying to ensure that the clock was on before the
> read happened?  If so, I think this won't help.  I see:
> 
> #define readl(c) ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> 
> ...so that means that the iormb() is _after_ the readl.
> 
> ...but I would believe that the clk_enable() call itself would be
> guaranteeing that the clock was enabled in time.  ...and if not then
> grabbing the spinlock is another barrier, right?  I think you do this
> in a few places...
> 
> Other than that this patch looks good to me....

I think that was my fault ... looking at stuff before figuring out that we're 
actually loosing the pd_pmu clock, and then forgetting to take this out again, 
before getting it to hl.

In retospect it also seems silly to have changed them in the first place ;-) .
So yes, they should be changed back to their original.


Heiko

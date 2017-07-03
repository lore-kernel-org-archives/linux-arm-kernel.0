From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Jul 2017 12:53:24 +0100
Subject: [PATCH 2/3] clk: WARN_ON about to disable a critical clock
In-Reply-To: <d83d608a-246f-7b18-20d1-10a2060395e1@de.bosch.com>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-3-git-send-email-lee.jones@linaro.org>
 <20160211004327.26445.27416@quark.deferred.io>
 <d83d608a-246f-7b18-20d1-10a2060395e1@de.bosch.com>
Message-ID: <20170703115324.5re2d32bd3slutcb@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jun 2017, Dirk Behme wrote:

> On 11.02.2016 01:43, Michael Turquette wrote:
> > Quoting Lee Jones (2016-01-18 06:28:50)
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Looks good to me.
> > 
> > Regards,
> > Mike
> > 
> > > ---
> > >   drivers/clk/clk.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 835cb85..178b364 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -575,6 +575,9 @@ static void clk_core_unprepare(struct clk_core *core)
> > >          if (WARN_ON(core->prepare_count == 0))
> > >                  return;
> > > +       if (WARN_ON(core->prepare_count == 1 && core->flags & CLK_IS_CRITICAL))
> > > +               return;
> > > +
> > >          if (--core->prepare_count > 0)
> > >                  return;
> > > @@ -680,6 +683,9 @@ static void clk_core_disable(struct clk_core *core)
> > >          if (WARN_ON(core->enable_count == 0))
> > >                  return;
> > > +       if (WARN_ON(core->enable_count == 1 && core->flags & CLK_IS_CRITICAL))
> > > +               return;
> > > +
> > >          if (--core->enable_count > 0)
> > >                  return;
> 
> 
> I have a question regarding this patch, which is mainline meanwhile [1]:
> 
> Having the following clock configuration:
> 
>                                         |--> child clk '1' (crit)
> clk source --> parent clk 'A' (crit) -->|
>                                         |--> child clk '2'
> 
> 
> Clock '2' might be used, or not. It might be disabled or not. It doesn't
> matter. Clock '1' is not allowed to be disabled. Therefore its marked as
> critical.
> 
> Parent clock 'A' is marked as critical because its not allowed to be
> disabled, even if the enable_count of all child clocks is 0. To avoid that
> by disabling parent clock 'A' the child clock '1' is disabled, too, whats
> not allowed as its marked as critical.
> 
> 
> Now, child clock '2' is used and enabled & disabled continuously by a (SPI)
> driver. What is ok. But:
> 
> Disabling child clock '2' results in the attempt to disable parent clock
> 'A', too, which has correct enable_count 1 (from enabling the child '2').
> What results
> 
> a) in the WARN_ON output
> 
> and
> 
> b) enable_count of 'A' never decreases to 0. Being off by one after the
> WARN_ON
> 
> 
> It sounds like both is wrong for a configuration like above.

Clock A still has one user, Clock 1.

Why is that wrong?

> Opinions or proposal how to fix/change this?
> 
> 
> Best regards
> 
> Dirk
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/clk.c?id=2e20fbf592621b2c2aeddd82e0fa3dad053cce03

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

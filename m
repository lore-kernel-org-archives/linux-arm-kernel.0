From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 06 Aug 2013 12:09:47 -0700
Subject: [PATCH] clk: gate: add CLK_GATE_ALWAYS_ON
In-Reply-To: <CAKohpomdHvJULWiE44NVq+rqmOtp4K5OxcsYUd3UWDxB5W-8EQ@mail.gmail.com>
References: <1375761457-16364-1-git-send-email-shaojie.sun@linaro.com>
 <CAKohpomdHvJULWiE44NVq+rqmOtp4K5OxcsYUd3UWDxB5W-8EQ@mail.gmail.com>
Message-ID: <20130806190947.5348.93477@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2013-08-05 21:45:56)
> Added linaro-kernel & patches at linaro.org in cc list..
> 
> On 6 August 2013 09:27, Shaojie Sun <shaojie.sun@linaro.org> wrote:
> > By default gate clock could be enable and disable. but
> > in some debug condition, must keep clock on, and never be closed.
> > setting this flag then gate clock never be closed.
> 
> Consider rewriting it as:
> 
> By default gate clk can be enabled/disabled but during debugging we
> may want to disable clk-disabling feature.
> 
> This patch adds a flag for it..
> 
> > Signed-off-by: Shaojie Sun <shaojie.sun@linaro.com>
> > ---
> >  drivers/clk/clk-gate.c       |   24 ++++++++++++++++++++++++
> >  include/linux/clk-provider.h |    4 ++++
> >  2 files changed, 28 insertions(+)
> 
> Honestly speaking, I am not sure if this patch is really required or not.
> And so Mike can decide on that. I will do a simple code review in
> that time.

I don't think this feature should be merged. Since it is purely for
debug purposes, and the change is small and domain-specific, I'd rather
have developers implement something like this locally during debug
instead of merging it into mainline. An early return in clk_disable
would suffice to do the same thing.

If many other developers find this to be extremely useful then I'll
reconsider.

Thanks,
Mike

> 
> > diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> > index 790306e..cc2b00e 100644
> > --- a/drivers/clk/clk-gate.c
> > +++ b/drivers/clk/clk-gate.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/io.h>
> >  #include <linux/err.h>
> >  #include <linux/string.h>
> > +#include <linux/device.h>
> 
> why?
> 
> >  /**
> >   * DOC: basic gatable clock which can gate and ungate it's ouput
> > @@ -48,6 +49,9 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
> >         unsigned long flags = 0;
> >         u32 reg;
> >
> > +       if (!enable && (gate->flags & CLK_GATE_ALWAYS_ON))
> > +               return;
> > +
> >         set ^= enable;
> >
> >         if (gate->lock)
> > @@ -159,5 +163,25 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
> >         if (IS_ERR(clk))
> >                 kfree(gate);
> >
> > +       if (clk_gate_flags & CLK_GATE_ALWAYS_ON) {
> > +               int ret;
> > +               if (flags & CLK_SET_PARENT_GATE)
> > +                       pr_debug("%s: %salways on, but need parent gate.\n",
> > +                                       __func__, name);
> > +
> > +               ret = clk_prepare(clk);
> > +               if (ret) {
> > +                       pr_debug("%s: %s could not be prepared.\n",
> > +                                       __func__, name);
> > +                       return clk;
> > +               }
> > +               ret = clk_enable(clk);
> > +               if (ret) {
> > +                       pr_debug("%s: %s could not be enabled.\n",
> > +                                       __func__, name);
> > +                       clk_unprepare(clk);
> > +               }
> 
> Call clk_prepare_enable instead.
> 
> > +       }
> > +
> >         return clk;
> >  }
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 1ec14a7..641422c 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -214,6 +214,9 @@ void of_fixed_clk_setup(struct device_node *np);
> >   *   of this register, and mask of gate bits are in higher 16-bit of this
> >   *   register.  While setting the gate bits, higher 16-bit should also be
> >   *   updated to indicate changing gate bits.
> > + * CLK_GATE_ALWAYS_ON - by default this clock could be enable and disable. but
> > + *   in some debug condition, must keep this clock on, and never be closed.
> > + *   setting this flag then this clock never be closed.
> 
> Copy some part from the commit log I just suggested..
> 
> If this flag is only for debugging we may name it that way.
> Maybe: CLK_GATE_DBG_ALWAYS_ON ??

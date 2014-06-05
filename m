From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jun 2014 18:01:00 +0200
Subject: [PATCH v7 2/8] clk: sunxi: Implement MMC phase control
In-Reply-To: <20140602213134.10062.14293@quantum>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100221.15040.47203.stgit@pagira.o2s.ch>
 <20140218141532.GH3142@lukather>
 <20140219052125.8345.70717@quantum>
 <20140219083606.GR3142@lukather>
 <20140223203143.22529.81640@quantum>
 <20140602213134.10062.14293@quantum>
Message-ID: <20140605160100.GH5765@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

(I don't know what happened with your mailer, but all the recipients
but devictree's ml, david had their mail address broken.)

On Mon, Jun 02, 2014 at 02:31:34PM -0700, Mike Turquette wrote:
> Quoting Mike Turquette (2014-02-23 12:31:43)
> > Quoting Maxime Ripard (2014-02-19 00:36:06)
> > > Hi Mike,
> > > 
> > > On Tue, Feb 18, 2014 at 09:21:25PM -0800, Mike Turquette wrote:
> > > > Quoting Maxime Ripard (2014-02-18 06:15:32)
> > > > > Hi,
> > > > > 
> > > > > On Mon, Feb 17, 2014 at 11:02:21AM +0100, David Lanzend?rfer wrote:
> > > > > > From: Emilio L?pez <emilio@elopez.com.ar>
> > > > > > 
> > > > > > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > > > > 
> > > > > You're missing your Signed-off-by here too.  Remember, for every patch
> > > > > you send, your Signed-off-by must be there, regardless wether you're
> > > > > the author or not.
> > > > > 
> > > > > A commit log would be very much welcome too.
> > > > > 
> > > > > Now, down to the patch itself, I remember Mike saying that he would
> > > > > prefer adding a function in the framework instead of hardcoding
> > > > > it. Mike, what's your feeling on this? Would merging this seem
> > > > > reasonnable to you as is, or do you want to take this to the
> > > > > framework?
> > > > 
> > > > Hi Maxime & Emilio,
> > > > 
> > > > Maybe something like the following RFC? If it seems sufficient for this
> > > > case then I will post to the wider list with an eye towards merging it
> > > > for 3.15. I've Cc'd Dinh since this came up on the socfpga thread as
> > > > well.
> > > > 
> > > > Regards,
> > > > Mike
> > > > 
> > > > 
> > > > 
> > > > From 56fa297591be5c5e22df6d2ca43fccf285a45636 Mon Sep 17 00:00:00 2001
> > > > From: Mike Turquette <mturquette@linaro.org>
> > > > Date: Tue, 18 Feb 2014 20:33:50 -0800
> > > > Subject: [PATCH] clk: introduce clk_set_phase function & callback
> > > > 
> > > > A common operation for a clock signal generator is to shift the phase of
> > > > that signal. This patch introduces a new function to the clk.h API to
> > > > dynamically adjust the phase of a clock signal. Additionally this patch
> > > > introduces support for the new function in the common clock framework
> > > > via the .set_phase call back in struct clk_ops.
> > > > 
> > > > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > > > ---
> > > > This patch is totally untested. It may make your board burst into
> > > > flames.
> > > > 
> > > >  drivers/clk/clk.c            | 84 +++++++++++++++++++++++++++++++++++++++++---
> > > >  include/linux/clk-private.h  |  1 +
> > > >  include/linux/clk-provider.h |  5 +++
> > > >  include/linux/clk.h          | 29 +++++++++++++++
> > > >  4 files changed, 115 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index ea2ca9f..635170a 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -106,11 +106,11 @@ static void clk_summary_show_one(struct seq_file *s, struct clk *c, int level)
> > > >       if (!c)
> > > >               return;
> > > >  
> > > > -     seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu",
> > > > +     seq_printf(s, "%*s%-*s %-11d %-12d %-10lu %-11lu %-3d",
> > > >                  level * 3 + 1, "",
> > > >                  30 - level * 3, c->name,
> > > >                  c->enable_count, c->prepare_count, clk_get_rate(c),
> > > > -                clk_get_accuracy(c));
> > > > +                clk_get_accuracy(c), clk_get_phase(c));
> > > >       seq_printf(s, "\n");
> > > >  }
> > > >  
> > > > @@ -132,8 +132,8 @@ static int clk_summary_show(struct seq_file *s, void *data)
> > > >  {
> > > >       struct clk *c;
> > > >  
> > > > -     seq_printf(s, "   clock                        enable_cnt  prepare_cnt  rate        accuracy\n");
> > > > -     seq_printf(s, "---------------------------------------------------------------------------------\n");
> > > > +     seq_printf(s, "   clock                        enable_cnt  prepare_cnt  rate        accuracy   phase\n");
> > > > +     seq_printf(s, "-----------------------------------------------------------------------------------------\n");
> > > >  
> > > >       clk_prepare_lock();
> > > >  
> > > > @@ -171,6 +171,7 @@ static void clk_dump_one(struct seq_file *s, struct clk *c, int level)
> > > >       seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
> > > >       seq_printf(s, "\"rate\": %lu", clk_get_rate(c));
> > > >       seq_printf(s, "\"accuracy\": %lu", clk_get_accuracy(c));
> > > > +     seq_printf(s, "\"phase\": %d", clk_get_phase(c));
> > > >  }
> > > >  
> > > >  static void clk_dump_subtree(struct seq_file *s, struct clk *c, int level)
> > > > @@ -257,6 +258,11 @@ static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
> > > >       if (!d)
> > > >               goto err_out;
> > > >  
> > > > +     d = debugfs_create_u32("clk_phase", S_IRUGO, clk->dentry,
> > > > +                     (u32 *)&clk->phase);
> > > > +     if (!d)
> > > > +             goto err_out;
> > > > +
> > > >       d = debugfs_create_x32("clk_flags", S_IRUGO, clk->dentry,
> > > >                       (u32 *)&clk->flags);
> > > >       if (!d)
> > > > @@ -1766,6 +1772,76 @@ out:
> > > >  EXPORT_SYMBOL_GPL(clk_set_parent);
> > > >  
> > > >  /**
> > > > + * clk_set_phase - adjust the phase shift of a clock signal
> > > > + * @clk: clock signal source
> > > > + * @degrees: number of degrees the signal is shifted
> > > > + *
> > > > + * Shifts the phase of a clock signal by the specified degrees. Returns 0 on
> > > > + * success, -EERROR otherwise.
> > > > + *
> > > > + * This function makes no distiction about the input or reference signal that
> > > > + * we adjust the clock signal phase against. For example phase locked-loop
> > > > + * clock signal generators we may shift phase with respect to feedback clock
> > > > + * signal input, but for other cases the clock phase may be shifted with
> > > > + * respect to some other, unspecified signal.
> > > > + *
> > > > + * Additionally the concept of phase shift does not propagate through the clock
> > > > + * tree hierarchy, which sets it appart from clock rates and clock accuracy. A
> > > > + * parent clock phase attribute does not have an impact on the phase attribute
> > > > + * of a child clock.
> > > > + */
> > > > +int clk_set_phase(struct clk *clk, int degrees)
> > > 
> > > Actually, while this is what I had in mind too, we'd need a bit more
> > > control here. We have two phases to control (namely, input and
> > > sample).
> > > 
> > > Maybe passing an additional enum to tell which phase we want to
> > > adjust, that could easily be extended by new drivers need would fit
> > > our need here?
> > 
> > Maxime,
> > 
> > Do you have any documentation you could share with me on your
> > requirements? I'd like to better understand them so we can get the API
> > right.
> > 
> > Shifting phase with respect to an input signal makes a lot of sense to
> > me, but I don't really understand "sample".
> 
> Hi Maxime,
> 
> I'd like to merge this after -rc1 drops. I don't have documentation for
> your platform so I can't investigate your needs any further.

Unfortunately, I don't have either (on this part at least).

> Some epic guesswork and rambling follows:
> 
> I do wonder if the two different phase adjustments you need to do are
> not properties of the *output* signal that corresponds to the MMC clock,
> but instead they are properties of the input signal to two other nodes
> that are not enumerated as struct clk's in Linux?
> 
> As an example, consider the CLK & PERHIPHCLK on an OMAP4 Pandaboard, as
> defined by the Cortex-A9 MPCORE TRM [1]. These clock signals are real,
> but they don't show up anywhere inside of TI's OMAP4 TRM [2]. These
> clocks are fed by OMAP4's dpll_mpu_m2_ck clock node, which is part of
> OMAP4's Power Reset & Clock Manager, which acts as a clock signal
> generator.
> 
> As a thought exercise, let's say that we need to shift the phase by 90?
> for the MPU to work properly. If we only have the dpll_mpu_m2_ck object
> in the clock framework, it might be tempting to call clk_set_phase() on
> it, but is that really the right thing? Perhaps what is missing is
> properly modeling the hardware clock signals, and instead another struct
> clk object should exist downstream of dpll_mpu_m2_ck, which belongs to
> the MPU IP block, that shifts the phase for the MPU.
> 
> Anyways, that might make things more confusing, I don't know. But the
> point is that in Linux we tend to model an individual part of the clock
> signal chain with a single struct clk object. That's why a struct clk
> *foo doesn't output two different frequencies: it can only output one.
> And struct clk *bar can have multiple possible parents, but only one
> active parent feeding it a signal.
> 
> Setting the phase should be the same way. If we set the phase for a
> struct clk *baz in the CCF, then it must imply that the phase is shifted
> for all downstream children. I'm worried that we're not modeling that
> quite right for your MMC case.

I do agree with you on the one software clock per hardware clock
thing. It's definitely something we need to work on, and we want to
fit in that model.

The MMC clock tree, from what I understood is actually composed of 3
clocks.

  - The MMC clock that we have support for right now, which is a basic
    factor clock. This clock has three outputs:
      * The clock that goes to the SD card itself.
      * an "output" clock
      * and a "sample" clock

The output and sample clocks are used to output/sample the
commands/response/data that are exchanged with the SD card and are the
one we change the phase of.

The only thing that remains to be understood is what the values we put
there are. The only indication that we have is that a value of 0 means
a phase of 180?, which is why we're stalled on this.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/2d85cf88/attachment.sig>

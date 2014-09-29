From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Sep 2014 17:57:18 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140929135358.GC30998@ulmo>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo>
Message-ID: <20140929155718.GD4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 03:54:00PM +0200, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
> > On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> > > > >> Plus, speaking more specifically about the clocks, that won't prevent
> > > > >> your clock to be shut down as a side effect of a later clk_disable
> > > > >> call from another driver.
> > > > 
> > > > > Furthermore isn't it a bug for a driver to call clk_disable() before a
> > > > > preceding clk_enable()? There are patches being worked on that will
> > > > > enable per-user clocks and as I understand it they will specifically
> > > > > disallow drivers to disable the hardware clock if other drivers are
> > > > > still keeping them on via their own referenc.
> > > > 
> > > > Calling clk_disable() preceding clk_enable() is a bug.
> > > > 
> > > > Calling clk_disable() after clk_enable() will disable the clock (and
> > > > its parents)
> > > > if the clock subsystem thinks there are no other users, which is what will
> > > > happen here.
> > > 
> > > Right. I'm not sure this is really applicable to this situation, though.
> > 
> > It's actually very easy to do. Have a driver that probes, enables its
> > clock, fails to probe for any reason, call clk_disable in its exit
> > path. If there's no other user at that time of this particular clock
> > tree, it will be shut down. Bam. You just lost your framebuffer.
> > 
> > Really, it's just that simple, and relying on the fact that some other
> > user of the same clock tree will always be their is beyond fragile.
> 
> Perhaps the meaning clk_ignore_unused should be revised, then. What you
> describe isn't at all what I'd expect from such an option. And it does
> not match the description in Documentation/kernel-parameters.txt either.

Well, it never says that it also prevent them from being disabled
later on. But it's true it's not very explicit.

> > > Either way, if there are other users of a clock then they will just as
> > > likely want to modify the rate at which point simplefb will break just
> > > as badly.
> > 
> > And this can be handled just as well. Register a clock notifier,
> > refuse any rate change, done. But of course, that would require having
> > a clock handle.
> > 
> > Now, how would *you* prevent such a change?
> 
> Like I said in the other thread. If you have two drivers that use the
> same clock but need different frequencies you've lost anyway.

Except that the driver that has the most logic (ie not simplefb) will
have a way to recover and deal with that. You prevented the clock rate
*and* your system can react, I guess you actually won.

But sure, you can still try to point new issues, get an obvious and
robust solution, and then discard the issue when the solution doesn't
go your way...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/4245fc55/attachment.sig>

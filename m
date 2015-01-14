From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 14 Jan 2015 23:55:16 +0100
Subject: [PATCH v2 1/5] irqchip: add dumb demultiplexer implementation
In-Reply-To: <CAL_JsqLwBvV5s531_YsA=sCE4_LG=eXTua8mh069ufRjSNFhng@mail.gmail.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAL_JsqJ5DSo6jmAuHPDdV6pMca8BVbg5V-GZ5=2qu96_QYXMtQ@mail.gmail.com>
 <alpine.DEB.2.11.1501141110190.5526@nanos>
 <CAL_JsqLwBvV5s531_YsA=sCE4_LG=eXTua8mh069ufRjSNFhng@mail.gmail.com>
Message-ID: <20150114235516.7a1a5844@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, 14 Jan 2015 16:24:32 -0600
Rob Herring <robherring2@gmail.com> wrote:

> On Wed, Jan 14, 2015 at 4:36 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 13 Jan 2015, Rob Herring wrote:
> >> On Tue, Jan 13, 2015 at 12:46 PM, Boris Brezillon
> >> <boris.brezillon@free-electrons.com> wrote:
> >> > Some interrupt controllers are multiplexing several peripheral IRQs on
> >> > a single interrupt line.
> >> > While this is not a problem for most IRQs (as long as all peripherals
> >> > request the interrupt with IRQF_SHARED flag set), multiplexing timers and
> >> > other type of peripherals will generate a WARNING (mixing IRQF_NO_SUSPEND
> >> > and !IRQF_NO_SUSPEND is prohibited).
> >> >
> >> > Create a dumb irq demultiplexer which simply forwards interrupts to all
> >> > peripherals (exactly what's happening with IRQ_SHARED) but keep a unique
> >> > irq number for each peripheral, thus preventing the IRQF_NO_SUSPEND
> >> > and !IRQF_NO_SUSPEND mix on a given interrupt.
> >>
> >> This really seems like a work-around for how IRQF_SHARED works. It
> >
> > It's a workaround for a short coming of IRQF_SHARED.
> >
> > IRQF_SHARED has a massive short coming versus suspend and wakeup
> > interrupts. If one of the demultiplexed interrupts is a valid wakeup
> > source then we have no sane way to express this with IRQF_SHARED
> > simply because the drivers need to be aware whether they run on stupid
> > or well designed hardware.
> 
> Unfortunately, the drivers will still have to know this. They cannot
> assume that they can call disable_irq and their device irq state does
> not matter.
> 
> Perhaps we need a debug feature such that disable_irq/enable_irq are
> nops with IRQF_SHARED?
> 
> >> seems like what is really desired is just per handler disabling. It is
> >
> > So you want a magic API like disable/enable_irq_action()?
> >
> > Certainly not.
> 
> Agreed.
> 
> > You'd open just another can of worms which will bring us abuse and
> > hard to debug problems because driver writers think it's a good idea
> > to use it for random purposes.
> >
> > Aside of that it would add another conditional into the interrupt
> > delivery hotpath which is not desired either.
> >
> >> fragile in that devices can deadlock the system if the drivers don't
> >> disable the interrupt source before calling disable_irq. But unlike
> >
> > Any misdesigned driver can do that for you.
> >
> >> IRQF_SHARED, there is nothing explicit in the driver indicating it is
> >> designed to work properly with a shared interrupt line.
> >
> > IRQF_SHARED is a pretty bad indicator. Look at all the drivers which
> > slap this flag onto request_irq() and have no single line of code
> > which makes sure that the driver would ever work on a shared line.
> >
> > If it's just for annotational purposes, we can add a new IRQF flag,
> > which is required to request such a interrupt line.
> >
> >> I see no reason to accept this into DT either. We already can support
> >> shared lines and modeling an OR gate as an interrupt controller is
> >> pointless.
> >
> > It's absolutely not pointless.
> >
> > All attempts to work around that have resulted in horrible bandaids so
> > far. That's why I guided Boris to implement this dummy demultiplexing
> > mechanism. It solves the problem at hand nicely without adding nasty
> > hackarounds into the suspend/resume code and inflicting platform
> > knowledge on multi-platform device drivers.
> 
> This change will break on old kernels with a new dtb. Would you be
> happy if a BIOS update required a new kernel? Fixing this for any
> platform requires a dtb update which may not be possible on some
> platforms. I don't have a problem with this breakage for 1 platform
> and the at91 guys may not care, but we'd ultimately be changing how
> all shared irqs are specified for all DT. Maybe we decide that this is
> how we want to describe things, but that needs much wider discussion
> and agreement.

I tried really hard on finding a DT representation that would not break
the DT ABI, but didn't find any easy solution.
How about keeping all platforms with the shared irq pattern, except for
those that really have an irq line shared by a timer and several other
devices (not sure yet, but at91 seems to be the only impacted platform
so far).

> 
> > If you have a proper solution for the problem at hand which
> >
> >    - avoids the demux dummy
> >
> >    - works straight forward with suspend/resume/wakeup
> >
> >    - does not add horrible new APIs
> >
> >    - does not add conditionals to the interrupt hotpath
> >
> >    - does not inflict platform knowledge about interrupt chip details
> >      on drivers
> >
> > then I'm happy to take it.
> >
> > But as long as you can't come up with anything sane, the demux dummy
> > is the best solution for this problem we've seen so far.
> 
> What if during suspend you move all actions w/o IRQF_NO_SUSPEND to a
> suspended action list? This would leave only the actions with
> IRQF_NO_SUSPEND set in the active action list. The cost would be a
> pointer in irq_desc and moving the actions during suspend and resume.

That really looks like what I suggested here [1].

> 
> There are probably ways to do this demux irqchip without a DT change.
> Since we can't just move Linux irq numbers to different irq_chips
> during request_irq, we would have to parse the DT up front to find all
> shared interrupts and create a demux irqchip for them. That wouldn't
> be very efficient, but is straight-forward. Then we'd have to handle
> the translation into Linux irq numbers correctly which is probably the
> more difficult part.

I'm really interested in seeing how you would do this.

Best Reagrds,

Boris

[1]https://lkml.org/lkml/2014/12/15/551

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

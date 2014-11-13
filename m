From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Nov 2014 15:45:52 -0800
Subject: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
In-Reply-To: <alpine.DEB.2.11.1411132251170.3935@nanos>
References: <alpine.DEB.2.10.1409190710320.5612@nanos>
 <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos>
 <20140919191649.GQ14505@atomide.com>
 <alpine.DEB.2.10.1409191233590.4213@nanos>
 <20141002034345.GH3122@atomide.com>
 <20141106204629.GF31454@atomide.com>
 <alpine.DEB.2.11.1411131053050.3935@nanos>
 <20141113174030.GM26481@atomide.com>
 <alpine.DEB.2.11.1411132251170.3935@nanos>
Message-ID: <20141113234551.GR26481@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [141113 14:27]:
> On Thu, 13 Nov 2014, Tony Lindgren wrote:
> > Oops thanks for catching that. As the devres stuff is separate, I've
> > updated the patch to keep it that way by adding a minimal manage.h.
> > This avoids including internals.h in devres.c. Does that seem usable
> > for you?
> 
> What's wrong with internals.h? devres.c is core code, so it is not
> affected of the ban to include internals.h :)

No problem, just that we need to bring in few other includes and
devres.c is currently free of any core irq stuff :) I can switch to
internals.h no problem if you prefer that.
  
> > + *	So if replaying the lost device interrupts is absolutely needed from the
> > + *	hardware point of view, it's probably best to set up a completely
> > + *	separate wake-up interrupt handler for the wake-up interrupt in the
> > + *	device driver because of the reasons above.
> 
> Can we please kill this last paragraph? I'm already seeing the
> gazillion of "I think it is required to do so for my soooo special
> chip" implementations in random drivers which all get it wrong again.

OK :)
 
> So I'd rather provide a mechanism upfront which lets the driver know
> that the wakeup interrupt originated from that device, i.e. let the
> wake up handler call
> 
>      pm_wakeup_irq(dev);
> 
> which calls:
> 
>       pm_runtime_mark_last_busy(dev);
>       pm_request_resume(dev);
> 
> and aside of that tells the device via a flag or preferrably a
> sequence counter that the wakeup irq has been triggered. So affected
> devices can handle it based on that information w/o implementing the
> next broken variant of wakeup irq handlers.

OK I'll take a look if we can just set some pm_runtime flag and use
the pm_runtime counters for that.

> That also allows to remove the wakeflags check for level/edge.
> 
> > + */
> > +int init_disabled_wakeirq(struct device *dev, unsigned int wakeirq,
> > +			  unsigned long wakeflags)
> > +{
> > +	if (!(dev && wakeirq)) {
> 
> This is the second time I stumbled over this. While it is correct it
> would be simpler to parse 
> 
>       if (!dev || !wakeirq) {
> 
> At least for my review damaged brain :)

Heh !!true.
 
> > +		pr_err("Missing device or wakeirq for %s irq %d\n",
> > +		       dev_name(dev), wakeirq);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!(wakeflags & IRQF_ONESHOT)) {
> > +		pr_err("Invalid wakeirq for %s irq %d, must be oneshot\n",
> > +		       dev_name(dev), wakeirq);
> > +		return -EINVAL;
> > +	}
> 
> Is there a reason why we force the wakeirq into a threaded handler?

Yes the drivers may need to restore hardware state in the pm_runtime
calls and who knows what else drivers will be doing. So that too might
be a good reason to just set a flag in pm_runtime land.

Anyways, thanks for your comments. I'll post a complete series after
looking into the wake-up counters a bit.

Regards,

Tony

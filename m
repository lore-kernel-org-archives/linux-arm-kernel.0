From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Sep 2014 12:57:38 -0700
Subject: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
In-Reply-To: <alpine.DEB.2.10.1409191233590.4213@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com>
 <1411067086-16613-4-git-send-email-nm@ti.com>
 <alpine.DEB.2.10.1409181749170.4206@nanos>
 <20140919030333.GA6088@kahuna>
 <alpine.DEB.2.10.1409190710320.5612@nanos>
 <20140919161927.GA28613@kahuna>
 <alpine.DEB.2.10.1409191027330.5612@nanos>
 <20140919191649.GQ14505@atomide.com>
 <alpine.DEB.2.10.1409191233590.4213@nanos>
Message-ID: <20140919195738.GR14505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner <tglx@linutronix.de> [140919 12:47]:
> On Fri, 19 Sep 2014, Tony Lindgren wrote:
> > * Thomas Gleixner <tglx@linutronix.de> [140919 10:37]:
> > >From hardware point of view the wake-up events behave like interrupts
> > and could also be used as the only interrupt in some messed up cases.
> > That avoids all kinds of custom APIs from driver point.
> > 
> > The re-entrancy problem we've most likely had ever since we enabled
> > the PRCM interrupts, and maybe that's why I did not even consider
> > that part. I think before that we were calling the driver interrupt
> > after waking up from the PM code..
> > 
> > Anyways, how about the following to deal with the re-entrancy problem:
> > 
> > 1. The wake-up interrupt handler must have a separate interrupt
> >    handler that just calls tasklet_schedule()
> > 
> > 2. The device interrupt handler also just calls tasklet_schedule()
> > 
> > 3. The tasklet then does pm_runtime_get, handles the registers, and
> >    so on.
> > 
> > Or would we still have a re-entrancy problem somewhere else with
> > that?
> 
> Why on earth are you wanting tasklets in there? That's just silly,
> really.

Lack of a framework on driver side to cope with this in a generic
way? :p
 
> The wakeup handler is supposed to bring the thing out of deep sleep
> and nothing else. All you want it to do is to mask itself and save the
> information that the real device irq is pending.

Yes that is enough.
 
> A stub handler for the wakeup irq is enough. We can have that in the
> irq/pm core and all it would do is simply:
> 
> irqreturn_t handle_jinxed_wakeup_irq(unsigned irq, void *dev_id)
> {
> 	unsigned device_irq = get_dev_irq(dev_id);
> 
> 	force_mask(irq);
> 	set_irq_pending(device_irq);
> 	return HANDLED;	
> }
> 
> So on resume_device_irqs() the real device interrupt gets reenabled
> and unmasked (if it was masked) and the interrupt gets resent either
> in hardware (level or retrigger) or by the software resend mechanism.
> 
> That completely avoids tasklets, reentrant irq handlers and all other
> crap which might be required.

Okie dokie, that sounds good to me. Having this generic for the
drivers would be excellent, that's the missing piece.

Thanks,

Tony

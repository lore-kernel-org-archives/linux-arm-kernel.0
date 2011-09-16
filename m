From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Sep 2011 11:41:00 +0200 (CEST)
Subject: [RFC PATCH 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <4E7318CB.8010105@arm.com>
References: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
	<1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
	<alpine.LFD.2.02.1109152207010.2723@ionos>
	<4E7318CB.8010105@arm.com>
Message-ID: <alpine.LFD.2.02.1109161138360.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Sep 2011, Marc Zyngier wrote:
> On 15/09/11 23:49, Thomas Gleixner wrote:
> >> +
> >> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> >> +
> >> +	unregister_handler_proc(irq, action);
> >> +
> >> +	/* Make sure it's not being used on another CPU: */
> >> +	synchronize_irq(irq);
> > 
> > That's not helping w/o making synchronize_irq() aware of the percpu
> > stuff. Also there is the question whether we need the ability to
> > remove such interrupts in the first place. The target users are low
> > level arch interrupts not some random device drivers.
> 
> Again, there is no need for this at the moment (the timer code runs
> running forever), and this is only there for completeness.
> 
> I'll see if I can come up with a synchronize_percpu_irq() without adding
> too much bloat to irqdesc.

You'd need a PROGRESS flag per cpu, which is overkill. What you can do
is to check whether the percpu enabled cpumask is completely empty and
return with a WARN when not.

Thanks,

	tglx

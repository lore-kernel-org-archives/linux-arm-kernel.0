From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Sep 2011 00:29:03 +0100
Subject: [RFC PATCH 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <alpine.LFD.2.02.1109152207010.2723@ionos>
References: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
	<1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
	<alpine.LFD.2.02.1109152207010.2723@ionos>
Message-ID: <20110915232903.GA22533@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 12:49:10AM +0200, Thomas Gleixner wrote:
> Marc,
> 
> On Thu, 15 Sep 2011, Marc Zyngier wrote:
> > +
> > +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> > +
> > +	unregister_handler_proc(irq, action);
> > +
> > +	/* Make sure it's not being used on another CPU: */
> > +	synchronize_irq(irq);
> 
> That's not helping w/o making synchronize_irq() aware of the percpu
> stuff. Also there is the question whether we need the ability to
> remove such interrupts in the first place. The target users are low
> level arch interrupts not some random device drivers.

You do - think local timers which go away on hotunplug and come back
on hotplug.  The alternative is requiring every local timer code to
remember whether it registered its per-cpu handler on each CPU or not,
and that just gets more messy than having them unregister on hotunplug.
Not only would that be more prone to bugs but it will also mean extra
complexity in arch code.

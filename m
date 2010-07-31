From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 31 Jul 2010 20:48:52 +0530
Subject: [PATCH] ARM: update show_interrupts for online cpu's only
In-Reply-To: <20100731150518.GD27064@n2100.arm.linux.org.uk>
References: <1280585333-4870-1-git-send-email-santosh.shilimkar@ti.com>
	<20100731143627.GC27064@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C638105A@dbde02.ent.ti.com>
	<20100731150518.GD27064@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C638105E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, July 31, 2010 8:35 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: update show_interrupts for online cpu's only
> 
> On Sat, Jul 31, 2010 at 08:18:05PM +0530, Shilimkar, Santosh wrote:
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > > Sent: Saturday, July 31, 2010 8:06 PM
> > > To: Shilimkar, Santosh
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH] ARM: update show_interrupts for online cpu's only
> > >
> > > On Sat, Jul 31, 2010 at 07:38:53PM +0530, Santosh Shilimkar wrote:
> > > > Even after CPUx is logically offline, it's interrupt are displayed
> > > > in proc entry
> > > >
> > > > This patch fixes the same by use of 'for_each_online_cpu' instead
> > > > of 'for_each_present_cpu' in 'show_interrupts' function
> > >
> > > What's the synchronisation mechanism between CPUs being brought on or
> > > offline and this file being read?
> > >
> > Isn't that taken care by "cpu_online_mask" mask ?
> 
> The problem comes when you have:
> 
> 	for_each_online_cpu(cpu)
> 		do_something(cpu);
> 
> 	/* cpu goes offline */
> 
> 	for_each_online_cpu(cpu)
> 		do_something_else(cpu);
> 
> This causes first iterates over more CPUs than the second.  When you
> consider we iterate over the online CPU mask for each interrupt, which
> could cross a read() call, it's possible that a CPU can go offline
> in the middle of reading /proc/interrupts.
> 
> The real question is whether this matters.  If you're reading this
> file as part of a daemon which is controlling the hotplug CPUs based
> on interrupt load, then probably not.
> 
> If you're reading this as part of a daemon involved with balancing IRQs
> across several CPUs, and CPU2 of 4 CPUs goes offline, you could get
> confused (but hopefully your parser is good enough to spot the format
> change and signal an exception.)
> 
> I feel rather uneasy about files which can spontaneously change format
> on a reader at any time.
I see your point. Thanks for clarifying it.
Do you think this change is such a problem? 
I just though from correctness point of view and if daemons
like irqbalance depend on this entry, it's likely going to get
confused.

Regards,
Santosh

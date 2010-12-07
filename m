From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 15:02:03 +0000
Subject: generic irq handler and stack?
In-Reply-To: <201012071356.16281.tim.sander@hbm.com>
References: <201012071129.26211.tim.sander@hbm.com>
	<20101207104116.GA20264@n2100.arm.linux.org.uk>
	<201012071356.16281.tim.sander@hbm.com>
Message-ID: <20101207150203.GA23589@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 01:56:16PM +0100, Tim Sander wrote:
> Hi
> 
> > > The interrupt handling on the i.mx35x seems to handle only one interrupt
> > > at a time. This generates larger then nessecary interrupt jitter. I am
> > > currently investigating to reprogram the AVIC to enable higher priority
> > > interrupts to interrupt lower priority interrupts. The mechanism is
> > > outlined in section 13,3.8 of the IMX35 Reference Manual.
> > 
> > The kernel now runs _all_ interrupts with IRQs masked on the CPU.  See
> > e58aa3d2d0cc01ad8d6f7f640a0670433f794922.
>
> Thanks Russell for your  quick answer. But as far as i understand this is only
> one step to get better interrupt latency on i.mx35x since the AVIC by default
> only allows one interrupt at a time. So any idea which is the cleanest way to 
> push the SPSR_irq register on the stack.

We don't run interrupts in IRQ mode.  The exception is entered in IRQ
mode, but we then save what state is necessary and switch to SVC mode.

We have supported nested interrupts since the 1.x kernel days - there's
no code changes needed to support having one interrupt handler interrupt
another handler - merely re-enabling interrupts in your own handlers
will allow it to happen if your IRQ controller will also allow it.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jul 2013 12:40:10 +0100
Subject: [PATCH 08/10] ARM: clps711x: Add CLPS711X cpuidle driver
In-Reply-To: <20130721081138.75cf5437bc30f42284f12e47@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-9-git-send-email-shc_work@mail.ru>
 <51EB0433.3050308@linaro.org>
 <20130721081138.75cf5437bc30f42284f12e47@mail.ru>
Message-ID: <20130722114010.GL24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 21, 2013 at 08:11:38AM +0400, Alexander Shiyan wrote:
> > > +static int clps711x_cpuidle_halt(struct cpuidle_device *dev,
> > > +				 struct cpuidle_driver *drv, int index)
> > > +{
> > > +	writel(1, clps711x_halt);
> > 
> > In what the 'clps711x_halt' differs from the usual WFI (cpu_do_idle) ?
> 
> AFAIK, ARM720T does not implement the WFI instruction.
> "HALT" register in CLPS711X do the same:
> "A write to this location will put the system into the Idle State by
> halting the clock to the processor until an interrupt is generated."
> 
> > > +	asm volatile ("mov r0, r0");
> > > +	asm volatile ("mov r0, r0");
> > 
> > Why are needed these two volatile ?
> 
> Two NOP instructions necessary following the enable or disable of the MMU.
> Documentation not say anything about using this for "HALT", maybe it's the
> remnants of the old code. I will remove it.

However, bear in mind that this is not how you insert two nops after
something; the compiler is free to add anything it likes before,
between separate asm() statements, or after them, even if they're
marked volatile.

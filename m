From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Sep 2014 13:46:14 +0100
Subject: [PATCH 1/3] arm: ls1: add CPU hotplug platform support
In-Reply-To: <20140926122003.GP5182@n2100.arm.linux.org.uk>
References: <1411730703-25836-1-git-send-email-chenhui.zhao@freescale.com>
 <1411730703-25836-2-git-send-email-chenhui.zhao@freescale.com>
 <20140926122003.GP5182@n2100.arm.linux.org.uk>
Message-ID: <20140926124614.GD7422@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 01:20:04PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 26, 2014 at 07:25:01PM +0800, Chenhui Zhao wrote:
> > +static inline void ls1_do_lowpower(unsigned int cpu, int *spurious)
> > +{
> > +	/*
> > +	 * there is no power-control hardware on this platform, so all
> > +	 * we can do is put the core into WFI; this is safe as the calling
> > +	 * code will have already disabled interrupts
> > +	 */
> > +	for (;;) {
> > +		wfi();
> > +
> > +		if (pen_release == cpu_logical_map(cpu)) {
> > +			/*OK, proper wakeup, we're done*/
> > +			break;
> > +		}
> > +
> > +		/*
> > +		 * Getting here, means that we have come out of WFI without
> > +		 * having been woken up - this shouldn't happen
> > +		 *
> > +		 * Just note it happening - when we're woken, we can report
> > +		 * its occurrence.
> > +		 */
> > +		(*spurious)++;
> > +	}
> > +}
> 
> This is pretty much unacceptable - this breaks kexec(), and suspend
> support because your secondary CPUs aren't really sleeping, they're
> sitting in a loop doing nothing.

Agreed.

This looks to be a carbon copy of the vexpress pseudo-hotplug in
arch/arm/mach-vexpress/hotplug.c, which is obviously broken in the way
you describe above. Perhaps we should go about ripping that out?

Mark.

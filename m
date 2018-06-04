From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jun 2018 19:08:06 +0100
Subject: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <20180604094241.GE9482@arm.com>
References: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
 <20180604094241.GE9482@arm.com>
Message-ID: <20180604180806.GC6920@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 10:42:43AM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Fri, Jun 01, 2018 at 12:00:16PM +0100, Russell King wrote:
> > Executing loops such as:
> > 
> > 	while (1)
> > 		cpu_relax();
> >
> > with interrupts disabled results in a livelock of the entire system,
> > as other CPUs are prevented making progress.  This is most noticable
> > as a failure of crashdump kexec, which stops just after issuing:
> > 
> > 	Loading crashdump kernel...
> > 
> > to the system console.  Two other locations of these loops within the
> > ARM code have been identified and fixed up.
> 
> Can you confirm that this only happens if CONFIG_ARM_ERRATA_754327=y?

CONFIG_ARM_ERRATA_754327=y + patch => works
CONFIG_ARM_ERRATA_754327=y => fails
CONFIG_ARM_ERRATA_754327=n => works

> The only erratum I can find for A9 that matches this behaviour exists
> when the body of the tight loop contains a DMB and some of the possible
> workarounds are:
> 
>   - Add ten NOPs after the DMB
>   - Use DSB instead of DMB in the tight loop
>   - Set bit 16 in the diagnostic control register (p15, c1, 5, 0, c0, 1)

Yes, I think you pointed me at that.  It may be appropriate to mitigate
the cases where we have a tight loop where the loop has a termination
condition, but in these cases, all the loops are infinite - finding some
way to avoid spinning in this case is probably a good idea in any case.

What I'm more interested in this patch is to fix kexec crashdump when
CONFIG_ARM_ERRATA_754327=y on OMAP4 (and similar) platforms.

> WFE is probably fine (the write-up isn't clear), but if this only occurs
> due to CONFIG_ARM_ERRATA_754327=y it would be nice to mitigate it in the
> alternative cpu_relax() definition itself, which isn't generally possible
> with WFE.

With the WFE, it is no longer "a tight loop", although WFE is just a
hint to the processor, it could ultimately ignore it.  That said, in
all these cases, either:

- we're either talking about a secondary CPU, so SMP must be supported
  (which presumably guarantees implementation of SEV/WFE)
or:
- we're the only CPU so this problem doesn't apply to the infinite loop
  case.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

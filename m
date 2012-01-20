From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 17:44:57 +0000
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
Message-ID: <20120120174456.GB11845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 04:45:40PM +0100, Linus Walleij wrote:
> On Fri, Jan 20, 2012 at 2:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jan 20, 2012 at 01:59:16PM +0100, Per Fransson wrote:
> >> Use irq_set_affinity() to initialize the kernel view of irq affinity
> >> when programming the GIC registers.
> >
> > Why is this necessary?
> 
> Necessary: we don't quite know. (Maybe should have been RFC, but
> this patch is better than being silent of it...)

I'm afraid Per Fransson took the thread off the mailing lists,
so my reply to him also wasn't public.  Here's what I said:

| The affinity starts off as "all CPUs", and the implementation is free
| to route the IRQ to any of those CPUs.  On x86, some hardware is smart
| enough to route the IRQ to one of a set of CPUs, choosing which CPU
| to target in hardware.
| 
| We don't have that ability, and trying to do that in software proved to
| be very problematic to get it to work satisfactorily.  Given that there
| is a userspace daemon which helps to solve the problem, it was decided
| that we wouldn't bother with this i the kernel.
| 
| So, we have to choose a CPU to route the IRQ to from the mask being
| requested - and the requested mask may contain anything from a single CPU
| to multiple CPUs.
| 
| We choose to route it to the first online CPU in the set.  That fits with
| the model, and does not require us to report back which CPU it's currently
| routed to.  Indeed, architectures such as x86 can't tell you which CPU
| the next interrupt will hit.
| 
| So we shouldn't even try to do this on ARM.  Yes, we end up with all IRQs
| targetting CPU0 at boot, and with the masks showing 'all CPUs' but that's
| not a problem.  Really not a problem.

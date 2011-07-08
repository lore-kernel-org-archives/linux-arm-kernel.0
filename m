From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2011 10:04:45 +0100
Subject: [RFC PATCH 16/17] ARM: PM: enhance idle pm notifiers
In-Reply-To: <CAMbhsRQ61aCvb4rJHXAr5sxK0CKEuKnre7sMzXiMrf4x6Y1yJA@mail.gmail.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-17-git-send-email-lorenzo.pieralisi@arm.com>
	<CAMbhsRQ61aCvb4rJHXAr5sxK0CKEuKnre7sMzXiMrf4x6Y1yJA@mail.gmail.com>
Message-ID: <20110708090445.GA31777@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 10:20:47PM +0100, Colin Cross wrote:
> adding Rafael, since he was interested in cpu_pm notifiers.
> 
> On Thu, Jul 7, 2011 at 8:50 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > This patch adds notifiers to manage low-power entry/exit in a platform
> > independent manner through a series of callbacks.
> > The goal is to enhance CPU specific notifiers with a different notifier
> > chain that executes callbacks defined to put the system into low-power
> > states (C-state). The callback must be executed with IRQ disabled
> > and caches still up and running, which in particular means that spinlocks
> > implemented as ldrex/strex are still usable on ARM.
> >
> > The callbacks are a means to achieve common idle code, where the
> > platform_pm_enter()/exit() functions trigger the actions required to
> > enter/exit low-power states (PCU, clock tree and power domain
> > programming) for a specific platform.
> >
> > Within the common idle code for ARM, the callbacks executed upon
> > platform_pm_enter/exit run with a virtual mapping cloned from init_mm
> > which means that the virtual address space is still accessible.
> >
> > The notifier is passed a (void *) argument, that in the context of
> > common idle code is meant to define cpu and cluster states in order to allow
> > the platform specific callback to handle power down/up actions accordingly.
> 
> Can you explain how this is different from the cpu_pm notifiers,
> besides the name?  Would they get called at a different point in the
> idle path?  Could they be the same notifier list as the cpu_pm
> notifiers, but with different enum values?

That is what I did in my previous version, meaning adding an enum to avoid 
duplicating it, then I decided to change the code to two independent chains.

For the patchset to be generic I have to have a way to call into platform
code to do every action needed to program power control unit registers
or send firmware commands to put che CPU/Cluster in the required power
state. The actions taken are different from cpu_pm and I thought that
avoid sharing the same notifier chain would be better.

I just pass a (void *) to platform code through the notifier 
as a way to decode the required cpu and cluster states that have to be hit.

I call platform_pm_enter before cleaning and invalidating/disabling caching,
which might not be proper because some platforms have a fixed time frame
to enter low power from the moment power control is programmed and this
does not go hand in hand with the variable number of dirty cache lines 
which can imply different timing required to clean/invalidate them.

> 
> If this is purely for platform idle ops, maybe something more like the
> struct platform_suspend_ops would be more appropriate?
> 

I will look into that, that was planned, I have to check/test if and how
I can adapt it to the patchset and if that is proper.

> Rafael wanted cpu_pm moved to somewhere outside of ARM, but these
> platform notifiers sound specific to an ARM common idle
> implementation, in which case you might need to find another place to
> put them besides cpu_pm.c.

I understand. It would be nice if we came up with a solution to tackle
both requirements in one single place.

> 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/include/asm/cpu_pm.h |   15 +++++++
> >  arch/arm/kernel/cpu_pm.c      |   92 +++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 103 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/cpu_pm.h b/arch/arm/include/asm/cpu_pm.h
> > index b4bb715..19b8106 100644
> > --- a/arch/arm/include/asm/cpu_pm.h
> > +++ b/arch/arm/include/asm/cpu_pm.h
> > @@ -42,8 +42,21 @@ enum cpu_pm_event {
> 
> <snip>
> 
> >  int cpu_pm_register_notifier(struct notifier_block *nb);
> >  int cpu_pm_unregister_notifier(struct notifier_block *nb);
> > +int platform_pm_register_notifier(struct notifier_block *nb);
> > +int platform__pm_unregister_notifier(struct notifier_block *nb);
> 
> Extra underscore
> 

Gah.., will fix it.

Thanks,
Lorenzo

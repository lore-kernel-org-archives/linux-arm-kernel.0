From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 18:00:35 +0100
Subject: [PATCH 10/17] ARM: mvebu: implement suspend/resume support for
 Armada XP
In-Reply-To: <5458A3CE.70900@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <5458A3CE.70900@free-electrons.com>
Message-ID: <20141113180035.774d8f9d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 04 Nov 2014 11:00:46 +0100, Gregory CLEMENT wrote:

> > +static int mvebu_pm_enter(suspend_state_t state)
> > +{
> > +	if (state != PM_SUSPEND_MEM)
> > +		return -EINVAL;
> > +
> > +	cpu_pm_enter();
> > +	cpu_cluster_pm_enter();
> 
> Why do you use this function?
> 
> It notifies the listeners with CPU_CLUSTER_PM_ENTER but currently only omap2
> and the gic are waiting for it.
> 
> Do you already plan to be compatible with the cortex A9 based mvebu SoC?

Indeed, using cpu_cluster_pm_enter() is not necessary for the moment,
it was just a stupid copy and paste from the PM code for other SoCs.

Support for the Cortex A9 based mvebu SoCs is indeed planned at some
point, but for the moment I don't know how much PM code will be shared,
and it will anyway be time to re-add these cpu_cluster_pm_enter and
cpu_cluster_pm_exit calls, so for now I removed them.

> By the way the gic doesn't use the suspend and resume operation from syscore_ops
> but the notification. Is there any particular reason for using
> syscore_ops in the irq-armada-370-xp driver?

Well, the syscore_ops strategy was already used in irq-metag-ext,
irq-vic and irq-sirfsoc, while the notifier-based strategy is only used
by irq-gic. Plus I'm using the syscore_ops strategy in all other core
drivers (clock, mvebu-mbus, etc.), so to me it makes sense to use the
same strategy in the irqchip driver, especially if other irqchip
drivers are doing the same thing.

Though this is definitely not a very strong opinion, and if the irqchip
maintainers would like to see the notifier-based strategy used here,
I'd do the change without a problem.

Thanks for your comments!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

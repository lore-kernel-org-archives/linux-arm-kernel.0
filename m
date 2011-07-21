From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Jul 2011 11:27:36 +0100
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <4E27E40C.6020006@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
	<4E27E40C.6020006@ti.com>
Message-ID: <20110721102736.GA3087@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 09:32:12AM +0100, Santosh Shilimkar wrote:
> Lorenzo, Colin,
> 
> On 7/7/2011 9:20 PM, Lorenzo Pieralisi wrote:
> > From: Colin Cross<ccross@android.com>
> >
> > When the cpu is powered down in a low power mode, the gic cpu
> > interface may be reset, and when the cpu complex is powered
> > down, the gic distributor may also be reset.
> >
> > This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
> > and restore the gic cpu interface registers, and the
> > CPU_COMPLEX_PM_ENTER and CPU_COMPLEX_PM_EXIT notifiers to save
> > and restore the gic distributor registers.
> >
> > Signed-off-by: Colin Cross<ccross@android.com>
> > ---
> >   arch/arm/common/gic.c |  212 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 files changed, 212 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> > index 4ddd0a6..8d62e07 100644
> > --- a/arch/arm/common/gic.c
> > +++ b/arch/arm/common/gic.c
> 
> [...]
> 
> I missed one more comment in the last review.
> 
> > +static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i<  MAX_GIC_NR; i++) {
> > +		switch (cmd) {
> > +		case CPU_PM_ENTER:
> > +			gic_cpu_save(i);
> On OMAP, GIC cpu interface context is lost only when CPU cluster
> is powered down.

Yes, it's true, but that's the only chance we have to save the GIC CPU IF 
state if the GIC context is lost, right ?
It is a private memory map per processor; I agree, it might be useless 
if just one CPU is shutdown, but at that point in time you do not know
the state of other CPUs. If the cluster moves to a state where GIC context
is lost at least you had the GIC CPU IF state saved. If we do not
save it, well, there is no way to do that anymore since the last CPU cannot
access other CPUs GIC CPU IF registers (or better, banked GIC distributor
registers).
If you force hotplug on CPUs other than 0 (that's the way it is done on OMAP4 
in cpuidle, right ?) to hit deep low-power states you reinit the GIC CPU IF 
state as per cold boot, so yes, it is useless there.

> > +			break;
> > +		case CPU_PM_ENTER_FAILED:
> > +		case CPU_PM_EXIT:
> > +			gic_cpu_restore(i);
> > +			break;
> > +		case CPU_COMPLEX_PM_ENTER:
> > +			gic_dist_save(i);
> > +			break;
> > +		case CPU_COMPLEX_PM_ENTER_FAILED:
> > +		case CPU_COMPLEX_PM_EXIT:
> > +			gic_dist_restore(i);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> Entire GIC is kept in CPU cluster power domain and
> hence GIC CPU interface context won't be lost whenever
> CPU alone enters in the deepest power state.
> 

Already commented above, it is the same on the dev board I am using.

> If it is different on other SOC's then the common
> notifiers won't match to all the SOC designs.
> 

Ditto.

> Looks like exporting these functions directly or
> adding them to gen irq and then invoking them
> from platform code based on power sequence need
> might be better.

I will have a look into that for the next version.

Thank you very much,
Lorenzo

From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Jan 2011 17:32:57 +0530
Subject: [PATCH 4/5] ARM: scu: Move register defines to header file
In-Reply-To: <20110125114635.GB13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
	<20110125114635.GB13300@n2100.arm.linux.org.uk>
Message-ID: <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:17 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> ccross at android.com; linus.ml.walleij at gmail.com; linux-
> omap at vger.kernel.org
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Mon, Jan 24, 2011 at 02:21:18PM +0530, Santosh Shilimkar wrote:
> > This patch moves SCU register defines from smp_scu.c to smp_scu.h
> > so that its available for platforms to use
> >
> > The SCU CPU power status registers is used for power management
> > on OMAP4.
>
> Could we instead have an API inside smp_scu.c rather than having
> each
> SoC implement its own SCU PM stuff?
>
I have similar patch implemented but what it does is just
prepares the value to be programmed and stores it to a scratchpad.
I see your point but below patch may now work well. The reason is the SCU
register needs to accessed at the lowest level. May be even when
stack is not available. Also this register needs to be cleared in cases
where the attempted power state is failed for some reason.

Also note that this register can be blocked using trust-zone which
again makes it platform dependent because direct write won't be
allowed in that case.

> Maybe this.  Note that scu_power_mode() needs to be called from a
> non-
> preemptible context, which is sane as we don't want to be
> rescheduled
> onto a different CPU between scu_power_mode() and the wfi/wfe
> required
> to enter the selected mode.
>
I would prefer the header export if there is no major
objection since there is already a possibility of custom
implementation with trust zone.

On OMAP4, on ES1.0 we need to use a secure API to achieve
this where as on ES2.0, it can be directly accessed.

Regards,
Santosh

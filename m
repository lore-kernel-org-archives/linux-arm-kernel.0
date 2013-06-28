From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 28 Jun 2013 17:27:58 +0100
Subject: [PATCH v7 0/6] xen/arm/arm64: CONFIG_PARAVIRT and stolen ticks
 accounting
In-Reply-To: <20130628160156.GH1643@arm.com>
References: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
 <20130628155840.GA13468@phenom.dumpdata.com> <20130628160156.GH1643@arm.com>
Message-ID: <alpine.DEB.2.02.1306281717150.4782@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013, Catalin Marinas wrote:
> On Fri, Jun 28, 2013 at 04:58:40PM +0100, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jun 28, 2013 at 12:19:54PM +0100, Stefano Stabellini wrote:
> > > Hi all,
> > > this patch series introduces stolen ticks accounting for Xen on ARM and
> > > ARM64.
> > > Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
> > > typically because Linux is running in a virtual machine and the vcpu has
> > > been descheduled.
> > > To account for these ticks we introduce CONFIG_PARAVIRT and pv_time_ops
> > > so that we can make use of:
> > > 
> > > kernel/sched/cputime.c:steal_account_process_tick
> > > 
> > > 
> > > Stefano Stabellini (6):
> > >       xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
> > >       kernel: missing include in cputime.c
> > >       arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
> > >       arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
> > >       core: remove ifdef CONFIG_PARAVIRT
> > >       xen/arm: account for stolen ticks
> > > 
> > >  arch/arm/Kconfig                  |   20 ++++++++
> > >  arch/arm/include/asm/paravirt.h   |   20 ++++++++
> > >  arch/arm/kernel/Makefile          |    1 +
> > >  arch/arm/kernel/paravirt.c        |   25 ++++++++++
> > >  arch/arm/xen/enlighten.c          |   21 +++++++++
> > >  arch/arm64/Kconfig                |   20 ++++++++
> > >  arch/arm64/include/asm/paravirt.h |   20 ++++++++
> > >  arch/arm64/kernel/Makefile        |    1 +
> > >  arch/arm64/kernel/paravirt.c      |   25 ++++++++++
> > >  arch/ia64/xen/time.c              |   48 +++-----------------
> > >  arch/x86/xen/time.c               |   76 +------------------------------
> > 
> > This is going to hit some of the patches that David
> > has sent to tglx, I think. You might want to try to rebase on top
> > of them (tip/time/for-xen, or something like that ) when they
> > are ready.
> > 
> > But for the Xen generic maintainer I am OK with these changes
> > so you can stick Acked-by on them.
> > 
> > Are you thinking to push them yourself or via the arm64 maintainer?
> 
> Once the core Xen support is pushed via the arm64 tree (queued for
> 3.11-rc1), I'm happy for the subsequent Xen patches to go directly
> (similarly for KVM). But it's -rc7 now and I'm not taking any more
> patches for the upcoming merging window (unless they are fixes).

The problem is that I haven't received any comments on the arm32
changes. Until I get a "go ahead" from Russell I don't feel comfortable
with sending a pull request to Linus with the third patch of the series
in it.

As a consequence I think I'll have to skip the next merge window.

After that, I might consider making this patch series arm64 only and
send it to Linus myself or via Catalin.

From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Feb 2014 12:22:30 +0000
Subject: [Xen-devel] [PATCH v9 0/5] xen/arm/arm64: CONFIG_PARAVIRT and
 stolen ticks accounting
In-Reply-To: <20140204150727.GA1529@andromeda.dapyr.net>
References: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
 <20140204150727.GA1529@andromeda.dapyr.net>
Message-ID: <alpine.DEB.2.02.1402171220520.27926@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Feb 2014, Konrad Rzeszutek Wilk wrote:
> On Thu, Jan 09, 2014 at 06:15:07PM +0000, Stefano Stabellini wrote:
> > Hi all,
> > this patch series introduces stolen ticks accounting for Xen on ARM and
> > ARM64.
> > Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
> > typically because Linux is running in a virtual machine and the vcpu has
> > been descheduled.
> > To account for these ticks we introduce CONFIG_PARAVIRT and pv_time_ops
> > so that we can make use of:
> > 
> > kernel/sched/cputime.c:steal_account_process_tick
> > 
> > 
> > Changes in v9:
> > - added back missing new files from patches;
> > - fix compilation on avr32 (remove patch #5, revert to previous version
> >   of patch #2).
> > 
> > 
> > 
> > Stefano Stabellini (5):
> >       xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
> >       kernel: missing include in cputime.c
> >       arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
> >       arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
> >       xen/arm: account for stolen ticks
> > 
> >  arch/arm/Kconfig                  |   20 ++++++++
> >  arch/arm/include/asm/paravirt.h   |   20 ++++++++
> >  arch/arm/kernel/Makefile          |    2 +
> >  arch/arm/kernel/paravirt.c        |   25 ++++++++++
> >  arch/arm/xen/enlighten.c          |   21 +++++++++
> >  arch/arm64/Kconfig                |   20 ++++++++
> >  arch/arm64/include/asm/paravirt.h |   20 ++++++++
> >  arch/arm64/kernel/Makefile        |    1 +
> >  arch/arm64/kernel/paravirt.c      |   25 ++++++++++
> >  arch/ia64/xen/time.c              |   48 +++----------------
> >  arch/x86/xen/time.c               |   76 +------------------------------
> >  drivers/xen/Makefile              |    2 +-
> >  drivers/xen/time.c                |   91 +++++++++++++++++++++++++++++++++++++
> >  include/xen/xen-ops.h             |    5 ++
> >  kernel/sched/cputime.c            |    3 ++
> >  15 files changed, 261 insertions(+), 118 deletions(-)
> >  create mode 100644 arch/arm/include/asm/paravirt.h
> >  create mode 100644 arch/arm/kernel/paravirt.c
> >  create mode 100644 arch/arm64/include/asm/paravirt.h
> >  create mode 100644 arch/arm64/kernel/paravirt.c
> >  create mode 100644 drivers/xen/time.c
> > 
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_9
> 
> I tried to merge it on top of 3.14-rc1 + stable/for-linus-3.14 (which
> has the revert of " xen/grant-table: Avoid m2p_override during mapping"
> 
> 
> And I get:
> konrad at phenom:~/linux$ git merge stefano/lost_ticks_9
> Auto-merging drivers/xen/Makefile
> CONFLICT (content): Merge conflict in drivers/xen/Makefile
> Auto-merging arch/x86/xen/time.c
> CONFLICT (modify/delete): arch/ia64/xen/time.c deleted in HEAD and
> modified in stefano/lost_ticks_9. Version stefano/lost_ticks_9 of
> arch/ia64/xen/time.c left in tree.
> Auto-merging arch/arm64/kernel/Makefile
> CONFLICT (content): Merge conflict in arch/arm64/kernel/Makefile
> Auto-merging arch/arm64/Kconfig
> Auto-merging arch/arm/xen/enlighten.c
> CONFLICT (content): Merge conflict in arch/arm/xen/enlighten.c
> Auto-merging arch/arm/Kconfig
> CONFLICT (content): Merge conflict in arch/arm/Kconfig
> Automatic merge failed; fix conflicts and then commit the result.

Sorry for the delay, the series rebased on 3.14-rc3 is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_10



> I presume that is mostly due to David's FIFO queue patches.
> 
> Could you kindly rebase it on top 3.14-rc1 and also tack on
> Catalin Marinas Ack on the patches?

I will.

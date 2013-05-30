From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 30 May 2013 14:33:42 +0100
Subject: [PATCH v5 0/4] xen/arm: CONFIG_PARAVIRT and stolen ticks
 accounting
Message-ID: <alpine.DEB.2.02.1305301426520.4799@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces stolen ticks accounting for Xen on ARM.
Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
typically because Linux is running in a virtual machine and the vcpu has
been descheduled.
To account for these ticks we introduce CONFIG_PARAVIRT and pv_time_ops
so that we can make use of:

kernel/sched/cputime.c:steal_account_process_tick


I am starting to be pretty confident about this patch series.

Please advice on what tree I should use to get this stuff upstream: most
of the changes are Xen specific, but it also contains few generic ARM
changes (the introduction of CONFIG_PARAVIRT and paravirt.c on ARM) and
a couple of lines in kernel/sched/cputime.c (a missing include).



Stefano Stabellini (4):
      xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
      kernel: missing include in cputime.c
      arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      xen/arm: account for stolen ticks

 arch/arm/Kconfig                |   20 +++++++++
 arch/arm/include/asm/paravirt.h |   19 ++++++++
 arch/arm/kernel/Makefile        |    1 +
 arch/arm/kernel/paravirt.c      |   25 +++++++++++
 arch/arm/xen/enlighten.c        |   21 +++++++++
 arch/ia64/xen/time.c            |   48 +++------------------
 arch/x86/xen/time.c             |   76 +--------------------------------
 drivers/xen/Makefile            |    2 +-
 drivers/xen/time.c              |   91 +++++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h           |    5 ++
 kernel/sched/cputime.c          |    4 +-
 11 files changed, 193 insertions(+), 119 deletions(-)
 create mode 100644 arch/arm/include/asm/paravirt.h
 create mode 100644 arch/arm/kernel/paravirt.c
 create mode 100644 drivers/xen/time.c


git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_5

Cheers,

Stefano

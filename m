From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 Jan 2014 18:48:42 +0000
Subject: [PATCH v8 0/6] xen/arm/arm64: CONFIG_PARAVIRT and stolen ticks
 accounting
Message-ID: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces stolen ticks accounting for Xen on ARM and
ARM64.
Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
typically because Linux is running in a virtual machine and the vcpu has
been descheduled.
To account for these ticks we introduce CONFIG_PARAVIRT and pv_time_ops
so that we can make use of:

kernel/sched/cputime.c:steal_account_process_tick


Changes in v8:
- rebased on 3.13-rc6.



Stefano Stabellini (6):
      xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
      kernel: missing include in cputime.c
      arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      core: remove ifdef CONFIG_PARAVIRT
      xen/arm: account for stolen ticks

 arch/arm/Kconfig           |   20 ++++++++++
 arch/arm/kernel/Makefile   |    1 +
 arch/arm/xen/enlighten.c   |   21 ++++++++++
 arch/arm64/Kconfig         |   20 ++++++++++
 arch/arm64/kernel/Makefile |    1 +
 arch/ia64/xen/time.c       |   48 +++--------------------
 arch/x86/xen/time.c        |   76 +-----------------------------------
 drivers/xen/Makefile       |    2 +-
 drivers/xen/time.c         |   91 ++++++++++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h      |    5 +++
 kernel/sched/core.c        |    2 -
 kernel/sched/cputime.c     |    1 +
 12 files changed, 168 insertions(+), 120 deletions(-)
 create mode 100644 drivers/xen/time.c

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_8


Cheers,

Stefano

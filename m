From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:58:37 +0000
Subject: [PATCH v12 0/4] xen/arm64: CONFIG_PARAVIRT and stolen ticks accounting
Message-ID: <alpine.DEB.2.02.1511201434520.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I dusted off this series from Jan 2014. Patch #2 and #3 still need an ack.


This patch series introduces stolen ticks accounting for Xen on ARM64.
Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
typically because Linux is running in a virtual machine and the vcpu has
been descheduled.  To account for these ticks we introduce
CONFIG_PARAVIRT and pv_time_ops so that we can make use of:

kernel/sched/cputime.c:steal_account_process_tick


Changes in v12:
- drop arm support
- #ifdef CONFIG_PARAVIRT the depends on it
- remove useless #include's

Changes in v11:
- add ifdef CONFIG_PARAVIRT to kernel/sched/cputime.c, because not all
  architectures have an asm/paravirt.h header file to include
- drop the removal of ifdef CONFIG_PARAVIRT from kernel/sched/core.c for
  the same reason


Stefano Stabellini (4):
      xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
      missing include asm/paravirt.h in cputime.c
      arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
      xen/arm: account for stolen ticks

 arch/arm/xen/enlighten.c          |   24 ++++++++++
 arch/arm64/Kconfig                |   20 ++++++++
 arch/arm64/include/asm/paravirt.h |   20 ++++++++
 arch/arm64/kernel/Makefile        |    1 +
 arch/arm64/kernel/paravirt.c      |   25 ++++++++++
 arch/x86/xen/time.c               |   76 +------------------------------
 drivers/xen/Makefile              |    2 +-
 drivers/xen/time.c                |   91 +++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h             |    5 ++
 kernel/sched/cputime.c            |    3 ++
 10 files changed, 191 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm64/include/asm/paravirt.h
 create mode 100644 arch/arm64/kernel/paravirt.c
 create mode 100644 drivers/xen/time.c


Cheers,

Stefano

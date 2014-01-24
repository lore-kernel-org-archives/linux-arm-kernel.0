From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Fri, 24 Jan 2014 11:40:50 -0500
Subject: [PATCH V2 0/6] ARM CoreSight: Enhance ETM tracing control
Message-ID: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Different ARM users have shown their interest in this patch, so I made
a second version that corrects the first mistakes.

Mainly, it extends current support of CoreSight ETM, that is currently
very limited. ETM provides hardware-assisted program tracing, a
cycle-precise and low-overhead solution that software tools such as
'perf record' cannot provide.

Usage of ETM tracing facility is presently limited to start and stop
tracing. This set of patches enables management of address combinations
and PIDs that trigger tracing, thus allowing to trace specific
functions and processes.

ETM management was done via sysfs entries (trace_info,
trace_running...), this code adds trace_addrrange and trace_pid to
let the user read/write custom values.

Changes in V2:
- Use device attributes rather than raw kobjects
- Make PID_IN_CONTEXTIDR incompatible with PID_NS in Kconfig
- Use int for pid type (not long)
- During trace fetching, call vmalloc() only if really needed

This series of patches applies to v3.13.

Adrien Verg? (6):
  ARM CoreSight: ETM: Use device attributes
  ARM CoreSight: ETM: Rename 'comparator' to 'address comparator'
  ARM CoreSight: ETM: Add address control support
  ARM: Make PID_IN_CONTEXTIDR incompatible with PID_NS
  ARM CoreSight: ETM: Add PID control support
  ARM CoreSight: ETM: Allocate a trace buffer only when necessary

 arch/arm/Kconfig.debug                    |   2 +-
 arch/arm/include/asm/hardware/coresight.h |   9 +-
 arch/arm/kernel/etm.c                     | 208 +++++++++++++++++++++++-------
 arch/arm64/Kconfig.debug                  |   1 +
 4 files changed, 169 insertions(+), 51 deletions(-)

-- 
1.8.5.2

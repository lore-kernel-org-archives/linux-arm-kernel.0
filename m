From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 14 Jun 2012 16:53:03 +0200
Subject: [PATCH v4 0/8] ARM: OMAP2+: PM: introduce the power domains
 functional states
Message-ID: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a re-spin after some comments after an internal review and some testing on
OMAP4 with device OFF support.

Implement the functional states for the power domains:
- unify the API to use the functional states,
- protect the power domain state change by a mutex in
  omap_set_pwrdm_state,
- introduce the functional states for power domains power states and
  logic power states, and the conversion functions between the
  functional and internal states,
- program the logic power state of power domains from the functional
  states, in omap_set_pwrdm_state
- convert the OMAP2/3/4 PM code to use the updated API,
- provide the power domains statistics by functional states,
- provide ftrace tracepoints with the functional state.

Based on mainline kernel 3.5.0-rc2.

Tested on OMAP3 Beagleboard, with suspend and cpuidle in RET and
OFF modes.


History:
 v4:
 - reworked the code after internal review and testing with OMAP3&4 device
   OFF,
 - fixed the tracepoints generation code,
 - introduce a function that returns power domains achievable functional
   states, in order to return a valid state for power domains that only
   support some of the power states. Although it has been tested OK the
   code is in RFC state.

 v3:
 - fix a bug in OMAP3 cpuidle which prevented the IO wake-ups in PER

 v2:
 - add the logic power states,
 - provide the power domains statistics by functional states

 v1:
 - initial implementation, in RFC state
 

Jean Pihet (8):
  ARM: OMAP2+: PM: protect the power domain state change by a mutex
  ARM: OMAP2+: PM: introduce power domains functional states
  ARM: OMAP2+: PM: use the functional power states API
  ARM: OMAP2+: PM: introduce power domains logic and memory functional
    states
  ARM: OMAP2+: PM: introduce power domains achievable functional states
  ARM: OMAP2+: PM: use the functional power states API for logic and
    memory
  ARM: OMAP2+: PM: use power domain functional state in stats counters
  ARM: OMAP2+: PM debug: trace the functional power domains states

 arch/arm/mach-omap2/cpuidle34xx.c          |   61 +++---
 arch/arm/mach-omap2/cpuidle44xx.c          |   28 +--
 arch/arm/mach-omap2/omap-hotplug.c         |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  |   39 ++--
 arch/arm/mach-omap2/pm-debug.c             |   15 +-
 arch/arm/mach-omap2/pm.c                   |   62 -----
 arch/arm/mach-omap2/pm.h                   |    1 -
 arch/arm/mach-omap2/pm24xx.c               |   15 +-
 arch/arm/mach-omap2/pm34xx.c               |   78 +++---
 arch/arm/mach-omap2/pm44xx.c               |   18 +-
 arch/arm/mach-omap2/powerdomain-common.c   |  100 ++++++++
 arch/arm/mach-omap2/powerdomain.c          |  367 ++++++++++++++++++++++++++--
 arch/arm/mach-omap2/powerdomain.h          |  101 ++++++--
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    7 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    3 +
 15 files changed, 653 insertions(+), 244 deletions(-)

-- 
1.7.7.6

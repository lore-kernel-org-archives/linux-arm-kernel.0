From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 15 Aug 2012 12:02:40 +0200
Subject: [PATCH v5 0/8] ARM: OMAP2+: PM: introduce the power domains
 functional states
Message-ID: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a re-spin after some comments and suggestions after review.

Implement the functional states for the power domains:
- unify the API to use the functional states. pwrdm_set_next_fpwrst
  now is the function to control the power domains power and logic
  states,
- reorganize the powerdomain API in internal and external parts,
  in powerdomain.h [1]
- protect the power domain state change by a lock in
  pwrdm_set_next_fpwrst,
- introduce the functional states for power domains power states and
  logic power states, and the conversion functions between the
  functional and internal states,
- program the logic power state of power domains from the functional
  states, in pwrdm_set_next_fpwrst
- convert the OMAP2/3/4 PM code to use the updated API,
- provide the power domains statistics by functional states,
- provide ftrace tracepoints with the functional state,
- provide error logs in critical code, which makes the development
  easier.

Note: [1] the physical split of internal and external APIs into
      different header files is not part of this series, it comes as
      a separate patch set.


Based on mainline kernel 3.6.0-rc1.

Tested on OMAP3 Beagleboard, with suspend and cpuidle in RET and
OFF modes.


History:
 v5:
 - complete rework after review and suggestions,
 - improved locking on next state read/write; spinlock instead of mutex
 - added more error logging in critical code,

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


Jean Pihet (7):
  ARM: OMAP2+: PM: introduce power domains functional states
  ARM: OMAP2+: PM: introduce power domains achievable functional states
  ARM: OMAP2+: PM: add a lock to protect the powerdomains next state
  ARM: OMAP2+: PM: use the functional power states API
  ARM: OMAP2+: PM: use power domain functional state in stats counters
  ARM: OMAP2+: PM debug: trace the functional power domains states
  ARM: OMAP2+: PM: reorganize the powerdomain API in public and private
    parts

Nishanth Menon (1):
  ARM: OMAP2+: powerdomain: add error logs

 arch/arm/mach-omap2/cpuidle34xx.c          |   58 ++--
 arch/arm/mach-omap2/cpuidle44xx.c          |   24 +-
 arch/arm/mach-omap2/omap-hotplug.c         |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  |   39 ++--
 arch/arm/mach-omap2/pm-debug.c             |   15 +-
 arch/arm/mach-omap2/pm24xx.c               |   14 +-
 arch/arm/mach-omap2/pm34xx.c               |   79 +++---
 arch/arm/mach-omap2/pm44xx.c               |   24 +-
 arch/arm/mach-omap2/powerdomain-common.c   |   99 ++++++
 arch/arm/mach-omap2/powerdomain.c          |  456 +++++++++++++++++++++++++---
 arch/arm/mach-omap2/powerdomain.h          |  152 ++++++---
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    6 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    3 +
 13 files changed, 753 insertions(+), 218 deletions(-)

-- 
1.7.7.6

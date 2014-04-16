From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 16 Apr 2014 16:44:50 +0100
Subject: [PATCH RFC v2 0/4] ARM generic idle states
Message-ID: <1397663094-28027-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is v2 of a previous posting:

http://www.spinics.net/lists/arm-kernel/msg316263.html

Changes in v2:

- Moved OF parsing code to drivers/cpuidle
- Improved states detection and sorting through linked list
- Split code in generic and ARM64 specific bits
- Moved idle enter function into ARM64 idle driver
- Refactored PSCI idle states register function
- Renamed suspend operations and moved detection to ARM64 idle driver
- Changed the way CPUIDLE_FLAG_TIMER_STOP is handled
- Simplified idle state nodes parsing since according to the latest
  bindings idle state nodes are a flat list, not hierarchical anymore
- Used min-residency-us to sort the states, to be further discussed

Idle states on most ARM platforms can be characterized by a set of
parameters that are platform agnostic and describe the HW idle states
features. So far, CPU idle drivers for ARM platforms required the definition
of parameters through static tables, duplicating control data for different
platforms. Moreover, the lack of standardization on firmware interfaces
hampered any standardization effort, resulting in CPU idle drivers for ARM
platforms containing duplicated code and platform specific power down routines.

The introduction of the PSCI firmware interface, and more in general, well
defined suspend back-ends, allows the definition of generic idle states and
the respective kernel infrastructure to support them.

Building on top of DT idle states bindings[1], that standardize idle states
parameters and corresponding suspend back-ends, this patchset provides code
that parses DT idle states nodes and builds at run-time the control data
infrastructure required by the ARM CPU idle drivers.

Idle states define an entry method (eg PSCI), that requires the respective
ARM64 kernel back-end to be invoked to initialize idle states parameters, so
that when the idle driver executes the back-end specific entry method a table
look-up can be carried out to retrieve the corresponding idle state parameter.

On legacy ARM platforms, the OF idle states are just used to initialize
states data.

The idle states bindings can be extended with new back-ends; the ARM64 CPUidle
driver must be updated accordingly so that the corresponding back
end initializer can be invoked at boot time for parameters initialization.

Patchset has been tested on AEM v8 models, on top of bootwrapper PSCI CPU
SUSPEND implementation which provides simulated core power gating.

[1] http://www.spinics.net/lists/arm-kernel/msg316299.html

Lorenzo Pieralisi (4):
  drivers: cpuidle: implement OF based idle states infrastructure
  arm64: add PSCI CPU_SUSPEND based cpu_suspend support
  drivers: cpuidle: CPU idle ARM64 driver
  arm64: boot: dts: update rtsm aemv8 dts with PSCI and idle states

 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |  49 +++++-
 arch/arm64/include/asm/psci.h          |   4 +
 arch/arm64/kernel/psci.c               | 102 ++++++++++++
 drivers/cpuidle/Kconfig                |  14 ++
 drivers/cpuidle/Kconfig.arm64          |  13 ++
 drivers/cpuidle/Makefile               |   5 +
 drivers/cpuidle/cpuidle-arm64.c        | 159 +++++++++++++++++++
 drivers/cpuidle/of_idle_states.c       | 274 +++++++++++++++++++++++++++++++++
 drivers/cpuidle/of_idle_states.h       |   8 +
 9 files changed, 620 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c
 create mode 100644 drivers/cpuidle/of_idle_states.c
 create mode 100644 drivers/cpuidle/of_idle_states.h

-- 
1.8.4

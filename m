From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Mar 2014 10:20:24 +0000
Subject: [PATCH RFC 0/4] arm64: generic idle states
Message-ID: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
infrastructure required by the generic ARM64 CPU idle driver, that just
becomes a container for idle states storage.

Idle states define an entry method (eg PSCI), that requires the respective
kernel back-end to be invoked to initialize idle states parameters, so that
when the idle driver executes the back-end specific entry method a table
look-up can be carried out to retrieve the corresponding idle state parameter.

The idle states bindings can be extended with new back-ends; the idle
states parser must be updated accordingly so that the corresponding back
end initializer can be invoked at boot time for parameters initialization.

Patchset has been tested on AEM v8 models, on top of the bootwrapper PSCI CPU
SUSPEND implementation which provides simulated core power gating.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233478.html

Lorenzo Pieralisi (4):
  arm64: kernel: implement DT based idle states infrastructure
  arm64: add PSCI CPU_SUSPEND based cpu_suspend support
  drivers: cpuidle: CPU idle ARM64 driver
  arm64: boot: dts: update rtsm aemv8 dts with PSCI and idle states

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |  50 ++++-
 arch/arm64/include/asm/idle_states.h   |  20 ++
 arch/arm64/include/asm/psci.h          |   6 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/idle_states.c        | 398 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/psci.c               |  84 +++++++
 drivers/cpuidle/Kconfig                |   5 +
 drivers/cpuidle/Kconfig.arm64          |  13 ++
 drivers/cpuidle/Makefile               |   4 +
 drivers/cpuidle/cpuidle-arm64.c        |  41 ++++
 11 files changed, 618 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/idle_states.h
 create mode 100644 arch/arm64/kernel/idle_states.c
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

-- 
1.8.4

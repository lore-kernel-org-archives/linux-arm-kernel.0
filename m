From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue,  6 Jan 2015 09:37:04 -0700
Subject: [PATCH 0/9] coresight: Add PM runtime awareness
Message-ID: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patchset is using the runtime PM API and the generic power
domain sub-system to prevent coresight power domains from being
switched off while trace scenarios are still being executed.

This is supplemented with the creation of two new generic power
domains for the big and LITTLE clusters on the vexpress-tc2 platform.
By adding coresigth tracers to the power domain they belong to and
using the new generic power domain logic in the spc driver, clusters
are kept powered for as long as coresight operations are ongoing.

Mathieu Poirier (9):
  coresight-etm3x: Adding runtime PM awareness
  coresight-etb: Adding runtime PM awareness
  coresight-funnel: Adding runtime PM awareness
  coresight-tmc: Adding runtime PM awareness
  coresight-tpiu: Adding runtime PM awareness
  coresight-etm3x: Fixing suspend/wake modes
  ARM: vexpress/TC2: Add generic power domain awareness to scp driver
  coresight: Adding DT generic power domain support
  coresight: Documenting reference to generic PD bindings

 .../devicetree/bindings/arm/coresight.txt          |   4 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  10 ++
 arch/arm/mach-vexpress/Kconfig                     |   1 +
 arch/arm/mach-vexpress/spc.c                       | 124 ++++++++++++++++++++-
 drivers/coresight/coresight-etb10.c                |  33 ++++--
 drivers/coresight/coresight-etm.h                  |   4 +-
 drivers/coresight/coresight-etm3x.c                |  69 ++++++++----
 drivers/coresight/coresight-funnel.c               |   9 +-
 drivers/coresight/coresight-tmc.c                  |   8 +-
 drivers/coresight/coresight-tpiu.c                 |   7 +-
 10 files changed, 229 insertions(+), 40 deletions(-)

-- 
1.9.1

From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  6 Sep 2018 10:08:21 +0100
Subject: [PATCH v2 00/14] coresight: Implement device claim protocol
Message-ID: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coresight architecture defines CLAIM tags for a device to negotiate
control of the components (external agent vs self-hosted). Each device
has a pair of registers (CLAIMSET & CLAIMCLR) for managing the CLAIM
tags. However, the protocol for the CLAIM tags is IMPLEMENTATION DEFINED.
PSCI has recommendations for the use of the CLAIM tags to negotiate
controls for external agent vs self-hosted use, as defined in
ARM DEN 0022D, Section "6.8.1 Debug and Trace save and restore".

This series implements the recommended protocol by PSCI.

There were two options for the implementation.
 1) Have the claim/disclaim operations performed from the coresight
    generic driver - This doesn't work unfortunately for ETM devices
    as the need cross-CPU calls to access the CLAIM registers. Also,
    makes it complex for error recovery and reference counting.

 2) Have the claim/disclaim operations performed from the device
    specific drivers. The disadvantage is that the calls are sprinkled
    in each driver, but this makes the operation much simpler.

This series implements the method (2). The first part of the series
prepares different drivers to handle errors from the lower layer
and clean up the state. The second part of the series updates the
existing drivers to claim/disclaim the devices as necessary.

Tested with a hacked coresight driver which modifies the external
claim tag via sysfs handle.

Applies on coresight/next in Mathieu's tree.

Changes since V1:
 - Handle errors is enabling path and disable only the components
   that were enabled in the iteration.
 - Fix build break on arm32 (etm3x)
 - Update commit description for "coresight: Add support for CLAIM tag protocol"

Suzuki K Poulose (14):
  coresight: Handle failures in enabling a trace path
  coresight: tmc-etr: Refactor for handling errors
  coresight: tmc-etr: Handle errors enabling CATU
  coresight: tmc-etb/etf: Prepare to handle errors enabling
  coresight: etm4x: Add support for handling errors
  coresight: etm3: Add support for handling errors
  coresight: etb10: Handle errors enabling the device
  coresight: dynamic-replicator: Handle multiple connections
  coresight: Add support for CLAIM tag protocol
  coresight: etmx: Claim devices before use
  coresight: funnel: Claim devices before use
  coresight: catu: Claim device before use
  coresight: dynamic-replicator: Claim device for use
  coreisght: tmc: Claim device before use

 drivers/hwtracing/coresight/coresight-catu.c       |   6 ++
 .../coresight/coresight-dynamic-replicator.c       |  79 ++++++++++----
 drivers/hwtracing/coresight/coresight-etb10.c      |  18 +++-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  56 +++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c      |  51 ++++++---
 drivers/hwtracing/coresight/coresight-funnel.c     |  26 ++++-
 drivers/hwtracing/coresight/coresight-priv.h       |   7 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  95 +++++++++++------
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  80 +++++++++-----
 drivers/hwtracing/coresight/coresight.c            | 118 +++++++++++++++++++--
 include/linux/coresight.h                          |  20 ++++
 11 files changed, 434 insertions(+), 122 deletions(-)

-- 
2.7.4

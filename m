From: mike.leach@linaro.org (Mike Leach)
Date: Wed, 28 Nov 2018 10:14:20 +0000
Subject: [RFC PATCH v2 0/3] Update AMBA driver for enhanced component ID spec
Message-ID: <20181128101423.15961-1-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest ARM CoreSight specification updates the component identification
requirements for all components attached to an AMBA bus. (ARM IHI 0029E)

This specification defines bits 11:8 in the ComponentID (CID) value as the
device class. Identification requirements now depend on this class.
Class 0xF: Traditional components identified by Peripheral ID (PID) only.
Class 0x9: CoreSight components may be identified by a Universal Component
Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
values.

Current and future ARM CoreSight IP will now use the same PID for
components on the same function - e.g. the ETM, CTI, PMU and Debug elements
associated with a core. The first core to use this UCI method is the A35,
which currently has binding entries in the ETMv4 driver.

This patchset prepares for the addition of the upcoming CTI driver, which
will need to correctly bind with A35 and future hardware, while overcoming
the limitation of binding by PID alone, which cannot now work.

The patchset updates the current AMBA Identification mechanism, which was
already differentiating between 0xF and 0x9 CIDs, to add
additional UCI compliant tests for the for the 0x9 device class.

Additional UCI structures are provided and added to the ETMv4 driver as
appropriate.

An additional test patch is provided to test the mechanism on the DB410C
96boards platform. This is not intended to be upstreamed.

Changes since v1:
1) simplification of amba_lookup function & other minor fixes
per suzuki suggestions.
2) remove spurious whitespace changes.
3) extended devarch and devarch mask values in etmv4 UCI to include
architect.


Mike Leach (3):
  drivers: amba: Updates to component identification for driver
    matching.
  coresight: etmv4: Update ID register table to add  UCI support
  amba: coresight: Driver test for new CoreSight UCI  matching

 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  9 +++
 drivers/amba/bus.c                            | 60 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 ++++++-
 include/linux/amba/bus.h                      | 32 ++++++++++
 4 files changed, 112 insertions(+), 10 deletions(-)

-- 
2.19.1

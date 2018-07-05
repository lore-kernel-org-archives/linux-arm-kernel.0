From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu,  5 Jul 2018 16:23:17 -0400
Subject: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor extensions
Message-ID: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a complete re-design of V1 of the QCOM Falkor extensions [1],
it introduces a probe table based on the HID of a device nested under the CPU
device to allow variant detection and arm_pmu customization.

The first patch adds an additional section at the end of each ACPI probe table.
This allows probe tables to be sentinel-delimited and better accommodate some
APIs that require such tables.

The second patch adds the PMUv3 ACPI probe table and plumbing to allow drivers
to plug into the ACPI PMUv3 probe sequence.

The third patch adds the PC capture extension applicable to Falkor and Saphira
CPUs. This shows how an extension that uses sampling events hooks. A similar
approach can be used to add RBB support and populate the sample branch stack
from it.

The fourth patch adds the matrix-based events extension applicable to Falkor
only.

If this found to be a reasonable extension approach other patches will be
added to the series to build on the base QCOM extensions.

[1] https://lkml.org/lkml/2017/3/1/540

Changes since V3:
- Add PC capture support as first extension. Add matrix-based events on top.

Changes since V2:
- Address V2 comments, which resulted in removing all uses of the PMU lock.

Agustin Vega-Frias (3):
  ACPI: add support for sentinel-delimited probe tables
  arm_pmu: acpi: add support for CPU PMU variant detection
  perf: qcom: Add Falkor CPU PMU IMPLEMENTATION DEFINED event support

 drivers/perf/Makefile             |   2 +-
 drivers/perf/arm_pmu_acpi.c       |  27 ++++
 drivers/perf/qcom_arm_pmu.c       | 310 ++++++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |   4 +-
 include/linux/acpi.h              |  11 ++
 include/linux/perf/arm_pmu.h      |   1 +
 6 files changed, 353 insertions(+), 2 deletions(-)
 create mode 100644 drivers/perf/qcom_arm_pmu.c

--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

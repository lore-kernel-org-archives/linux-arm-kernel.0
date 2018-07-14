From: collinsd@codeaurora.org (David Collins)
Date: Fri, 13 Jul 2018 18:50:57 -0700
Subject: [PATCH v9 0/2] regulator: add QCOM RPMh regulator driver
Message-ID: <cover.1531531808.git.collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a driver and device tree binding documentation for
PMIC regulator control via Resource Power Manager-hardened (RPMh) on some
Qualcomm Technologies, Inc. SoCs such as SDM845.  RPMh is a hardware block
which contains several accelerators which are used to manage various
hardware resources that are shared between the processors of the SoC.  The
final hardware state of a regulator is determined within RPMh by performing
max aggregation of the requests made by all of the processors.

The RPMh regulator driver depends upon the RPMh driver [1] and command DB
driver [2] which are both still undergoing review.  It also depends upon
three recent regulator patches: [3], [4], and [5] as well as an RPMh
helper patch [6].

Changes since v8 [7]:
 - Used C++ style comment for qcom-rpmh-regulator.c copyright
 - Removed RPMH_REGULATOR_MODE_COUNT
 - Changed ternary operator to if else statement in
   rpmh_regulator_vrm_set_mode_bypass()
 - Changed LDO mode mappings to use REGULATOR_MODE_NORMAL for HPM
   instead of REGULATOR_MODE_FAST
 - Replaced mapping arrays with switch case statements in of_map_mode
   callback functions

Changes since v7 [8]:
 - Removed the cmd_db_ready() call from the driver probe function as it
   is now handled by the RPMh driver itself [6]
 - Added Reviewed-by tag for driver patch 2/2

Changes since v6 [9]:
 - Removed 'count' parameter from rpmh_regulator_send_request() since
   it is always 1
 - Fixed _rpmh_regulator_vrm_set_voltage_sel() return value
 - Added a helper function to capture common code between
   rpmh_regulator_enable() and rpmh_regulator_disable()
 - Added an iterator for pmic_rpmh_data in rpmh_regulator_init_vreg()
 - Added Reviewed-by tag for both patches

Changes since v5 [10]:
 - Removed unused constants
 - Added Reviewed-by tag for DT patch 1/2

Changes since v4 [11]:
 - Removed support for DT properties qcom,regulator-drms-modes and
   qcom,drms-mode-max-microamps
 - Specified fixed DRMS high power mode minimum limits for LDO type
   regulators
 - Removed DRMS support for SMPS and BOB type regulators
 - Simplified voltage caching logic

Changes since v3 [12]:
 - Removed support for DT properties qcom,regulator-initial-microvolt
   and qcom,headroom-microvolt
 - Renamed DT property qcom,allowed-drms-modes to be
   qcom,regulator-drms-modes
 - Updated DT binding documentation to mention which common regulator
   bindings can be used for qcom-rpmh-regulator devices
 - Added voltage caching so that voltage requests are only sent to RPMh
   after the regulator has been enabled at least once
 - Changed 'voltage_selector' default value to be -ENOTRECOVERABLE to
   interact with [5]
 - Initialized 'enabled' to -EINVAL so that unused regulators are
   disabled by regulator_late_cleanup()
 - Removed rpmh_regulator_load_default_parameters() as it is no longer
   needed
 - Updated the mode usage description in qcom,rpmh-regulator.h

Changes since v2 [13]:
 - Replaced '_' with '-' in device tree supply property names
 - Renamed qcom_rpmh-regulator.c to be qcom-rpmh-regulator.c
 - Updated various DT property names to use "microvolt" and "microamp"
 - Moved allowed modes constraint specification out of the driver [4]
 - Replaced rpmh_client with device pointer to match new RPMh API [1]
 - Corrected drms mode threshold checking
 - Initialized voltage_selector to -EINVAL when not specified in DT
 - Added constants for PMIC regulator hardware modes
 - Corrected type sign of mode mapping tables
 - Made variable names for mode arrays plural
 - Simplified Kconfig depends on
 - Removed unnecessary constants and struct fields
 - Added some descriptive comments

Changes since v1 [14]:
 - Addressed review feedback from Doug, Mark, and Stephen
 - Replaced set_voltage()/get_voltage() callbacks with set_voltage_sel()/
   get_voltage_sel()
 - Added set_bypass()/get_bypass() callbacks for BOB pass-through mode
   control
 - Removed top-level PMIC data structures
 - Removed initialization variables from structs and passed them as
   function parameters
 - Removed various comments and error messages
 - Simplified mode handling
 - Refactored per-PMIC rpmh-regulator data specification
 - Simplified probe function
 - Moved header into DT patch
 - Removed redundant property listings from DT binding documentation

[1]: https://lkml.org/lkml/2018/6/20/519
[2]: https://lkml.org/lkml/2018/4/10/714
[3]: https://lkml.org/lkml/2018/4/18/556
[4]: https://lkml.org/lkml/2018/5/11/696
[5]: https://lkml.org/lkml/2018/5/15/1005
[6]: https://lkml.org/lkml/2018/6/18/1188
[7]: https://lkml.org/lkml/2018/6/22/935
[8]: https://lkml.org/lkml/2018/6/8/573
[9]: https://lkml.org/lkml/2018/6/4/879
[10]: https://lkml.org/lkml/2018/6/1/895
[11]: https://lkml.org/lkml/2018/5/22/1168
[12]: https://lkml.org/lkml/2018/5/11/701
[13]: https://lkml.org/lkml/2018/4/13/687
[14]: https://lkml.org/lkml/2018/3/16/1431

David Collins (2):
  regulator: dt-bindings: add QCOM RPMh regulator bindings
  regulator: add QCOM RPMh regulator driver

 .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            | 769 +++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +
 5 files changed, 975 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

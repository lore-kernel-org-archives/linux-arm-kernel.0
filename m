From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Oct 2013 12:06:57 -0700
Subject: [PATCH v2 0/9] Add support for MSM's mmio clocks
Message-ID: <1380740826-29457-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first 3 patches are generic clock framework patches. They add support for
regmap and for setting the rate and the parent at the same time based on
patches from James Hogan's remuxing set_rate series.

After that we add MSM clock hardware support and SoC specific drivers. The DT
node additions will be sent through the MSM maintainers once these patches are
accepted. The GCC 8974 driver is mostly finished but I didn't do the full
treatment on 8960 just yet.

Changes since v1:

 * Rewrote binding to use #clock-cells=1
 * Reworked library components (pll, rcg, branch) to use regmap
 * Dropped common clock framework patches that did DT parsing
 * New patches for regmap support in common clock framework

Some starter questions:

 1) The clock controller is also a reset and power domain controller.
    Should we put that code in the drivers under drivers/clk/msm?

 2) Should the directory be renamed to qcom to match the binding?

 3) What is the right place for clock dt binding #defines? clk/ or clock/?

Stephen Boyd (9):
  clk: Allow drivers to pass in a regmap
  clk: Add regmap core helpers for enable/disable/is_enabled
  clk: Add set_rate_and_parent() op
  clk: msm: Add support for phase locked loops (PLLs)
  clk: msm: Add support for root clock generators (RCGs)
  clk: msm: Add support for branches/gate clocks
  clk: msm: Add support for MSM8960's global clock controller (GCC)
  clk: msm: Add support for MSM8960's multimedia clock controller (MMCC)
  clk: msm: Add support for MSM8974's global clock controller (GCC)

 Documentation/clk.txt                              |    3 +
 .../devicetree/bindings/clock/qcom,gcc.txt         |   20 +
 .../devicetree/bindings/clock/qcom,mmcc.txt        |   19 +
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk.c                                  |  156 +-
 drivers/clk/msm/Kconfig                            |   29 +
 drivers/clk/msm/Makefile                           |   10 +
 drivers/clk/msm/clk-branch.c                       |  153 ++
 drivers/clk/msm/clk-branch.h                       |   50 +
 drivers/clk/msm/clk-pll.c                          |  147 ++
 drivers/clk/msm/clk-pll.h                          |   45 +
 drivers/clk/msm/clk-rcg.c                          |  491 ++++
 drivers/clk/msm/clk-rcg.h                          |  149 ++
 drivers/clk/msm/clk-rcg2.c                         |  272 +++
 drivers/clk/msm/gcc-8960.c                         |  381 +++
 drivers/clk/msm/gcc-8974.c                         | 2488 ++++++++++++++++++++
 drivers/clk/msm/mmcc-8960.c                        |  297 +++
 include/dt-bindings/clk/msm-gcc-8960.h             |   28 +
 include/dt-bindings/clk/msm-gcc-8974.h             |  154 ++
 include/dt-bindings/clk/msm-mmcc-8960.h            |   24 +
 include/linux/clk-provider.h                       |   35 +
 22 files changed, 4935 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.txt
 create mode 100644 drivers/clk/msm/Kconfig
 create mode 100644 drivers/clk/msm/Makefile
 create mode 100644 drivers/clk/msm/clk-branch.c
 create mode 100644 drivers/clk/msm/clk-branch.h
 create mode 100644 drivers/clk/msm/clk-pll.c
 create mode 100644 drivers/clk/msm/clk-pll.h
 create mode 100644 drivers/clk/msm/clk-rcg.c
 create mode 100644 drivers/clk/msm/clk-rcg.h
 create mode 100644 drivers/clk/msm/clk-rcg2.c
 create mode 100644 drivers/clk/msm/gcc-8960.c
 create mode 100644 drivers/clk/msm/gcc-8974.c
 create mode 100644 drivers/clk/msm/mmcc-8960.c
 create mode 100644 include/dt-bindings/clk/msm-gcc-8960.h
 create mode 100644 include/dt-bindings/clk/msm-gcc-8974.h
 create mode 100644 include/dt-bindings/clk/msm-mmcc-8960.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

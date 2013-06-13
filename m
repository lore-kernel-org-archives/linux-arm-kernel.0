From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 18:48:56 -0700
Subject: [RFC/PATCH 00/13] Add support for MSM's mmio clocks
Message-ID: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Posting as an RFC because I haven't gone through and generated all 
the data needed yet. This is just a few clocks for now to give a general
idea of where things are headed.

The first 4 patches are generic clock framework patches. They add support
for finding clocks in DT and parsing them generically. They also add support
for setting the rate and the parent at the same time based on patches from
James Hogan's remuxing set_rate series [1].

After that we add MSM clock hardware support and then fill in the DT and
data to actually register clocks. This is sufficient enough to get the UART
going on my msm8960 device.

I'm currently waffling between the DT bindings being more descriptive
versus just using the clocks as numbers method. From what I can tell
nobody is complaining either way so it seems I could put all of
the information I encode in C structs into DT. It would be great
if more experienced DT persons could weigh in here.

Please note this patchset relies on my previous patch series that moves
existing MSM clock code to the common clock framework [2].

Stephen Boyd (13):
  clk: fixed-rate: Export clk_fixed_rate_register()
  clk: Add of_init_clk_data() to parse common clock bindings
  clk: Add of_clk_match() for device drivers
  clk: Add set_rate_and_parent() op
  clk: msm: Add support for phase locked loops (PLLs)
  clk: msm: Add support for root clock generators (RCGs)
  clk: msm: Add support for branches/gate clocks
  clk: msm: Add MSM clock driver
  clk: msm: Add support for MSM8960's global clock controller (GCC)
  clk: msm: Add support for MSM8960's multimedia clock controller (MMCC)
  ARM: dts: msm: Add MSM8960 GCC DT nodes
  ARM: dts: msm: Add MSM8960 MMCC DT nodes
  ARM: dts: msm: Add clock entries for MSM8960 uart device

 Documentation/clk.txt                              |   3 +
 Documentation/devicetree/bindings/clock/msm.txt    |  99 +++
 .../devicetree/bindings/clock/qcom,gcc.txt         |  55 ++
 .../devicetree/bindings/clock/qcom,mmcc.txt        |  38 ++
 arch/arm/boot/dts/msm8960-cdp.dts                  | 111 +++
 drivers/clk/Kconfig                                |   2 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-fixed-rate.c                       |   1 +
 drivers/clk/clk.c                                  | 201 +++++-
 drivers/clk/msm/Kconfig                            |  22 +
 drivers/clk/msm/Makefile                           |  11 +
 drivers/clk/msm/clk-branch.c                       | 190 ++++++
 drivers/clk/msm/clk-branch.h                       |  48 ++
 drivers/clk/msm/clk-pll.c                          | 233 +++++++
 drivers/clk/msm/clk-pll.h                          |  43 ++
 drivers/clk/msm/clk-rcg.c                          | 754 +++++++++++++++++++++
 drivers/clk/msm/clk-rcg.h                          | 114 ++++
 drivers/clk/msm/clk-rcg2.c                         | 320 +++++++++
 drivers/clk/msm/core.c                             | 271 ++++++++
 drivers/clk/msm/gcc-8960.c                         | 174 +++++
 drivers/clk/msm/internal.h                         |  27 +
 drivers/clk/msm/mmcc-8960.c                        | 142 ++++
 include/linux/clk-provider.h                       |  28 +
 23 files changed, 2868 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/msm.txt
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
 create mode 100644 drivers/clk/msm/core.c
 create mode 100644 drivers/clk/msm/gcc-8960.c
 create mode 100644 drivers/clk/msm/internal.h
 create mode 100644 drivers/clk/msm/mmcc-8960.c

[1] <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
[2] 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

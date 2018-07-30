From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon, 30 Jul 2018 10:11:16 +0200
Subject: [PATCH 0/8] Add support for drm/rockchip to dynamically control the
 DDR frequency.
Message-ID: <20180730081124.30698-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

The rk3399 platform has a DFI controller that can monitor DDR load and a
DMC driver that talks with the TF-A (Trusted Firmware-A) to dynamically
set the DDR frequency with following flow.

             kernel                          Trusted Firmware-A
                                                  (bl31)
        monitor ddr load
                |
                |
        get_target_rate
                |
                |           pass rate to TF-A
        clk_set_rate(ddr) --------------------->run ddr dvs flow
                                                    |
                                                    |
                 <------------------------------end ddr dvs flow
                |
                |
              return

These patches add support for devfreq to dynamically control the DDR
frequency into the drm rockchip driver. By default it uses the
'simple_ondemand' governor which can adjust the frequency based on the
DDR load.

Waiting for your feedback.

Best regards,
 Enric

Changes in v1:
- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
- [RFC 1/10] s/Generic/General/ (Robin Murphy)
- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring
- [RFC 3/10] Add an explanation for platform SIP calls.
- [RFC 3/10] Change if statement for a switch.
- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
- [RFC 7/10] Removed from the series. I did not found a use case where this matters.
- [RFC 8/10] Move rk3399-dram.h to dt-includes.
- [RFC 8/10] Put sdram default values under the dmc node.
- [RFC 8/10] Removed rk3399-dram-default-timing.dts

Derek Basehore (2):
  devfreq: rk3399_dmc / clk: rockchip: Sync with vblank in the kernel
    for DDRfreq.
  devfreq: rk3399_dmc / clk: rockchip: Disable DDR clk timeout on
    suspend.

Enric Balletbo i Serra (3):
  devfreq: rockchip-dfi: Move GRF definitions to a common place.
  dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
  devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.

Lin Huang (2):
  arm64: dts: rk3399: Add dfi and dmc nodes.
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru.

Sean Paul (1):
  drm: rockchip: Add DDR devfreq support.

 .../bindings/devfreq/rk3399_dmc.txt           |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  21 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  29 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  51 ++++-
 drivers/clk/rockchip/clk-ddr.c                | 157 +++++++++++--
 drivers/clk/rockchip/clk.c                    |   2 +-
 drivers/clk/rockchip/clk.h                    |   3 +-
 drivers/devfreq/event/rockchip-dfi.c          |  23 +-
 drivers/devfreq/rk3399_dmc.c                  | 209 +++++++++++++++---
 drivers/devfreq/rk3399_dmc_priv.h             |  16 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  46 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   9 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  35 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  34 +++
 include/dt-bindings/power/rk3399-dram.h       |  73 ++++++
 include/soc/rockchip/rk3399_dmc.h             |  42 ++++
 include/soc/rockchip/rk3399_grf.h             |  21 ++
 include/soc/rockchip/rockchip_sip.h           |   1 +
 18 files changed, 704 insertions(+), 70 deletions(-)
 create mode 100644 drivers/devfreq/rk3399_dmc_priv.h
 create mode 100644 include/dt-bindings/power/rk3399-dram.h
 create mode 100644 include/soc/rockchip/rk3399_dmc.h
 create mode 100644 include/soc/rockchip/rk3399_grf.h

-- 
2.18.0

From: hl@rock-chips.com (Lin Huang)
Date: Wed, 17 Aug 2016 06:36:21 +0800
Subject: [PATCH v6 0/8] rk3399 support ddr frequency scaling
Message-ID: <1471386989-9541-1-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3399 platform have dfi controller can monitor ddr load,
and dcf controller to handle ddr register so we can get the
right ddr frequency and make ddr controller happy work(which
will implement in bl31). So we do ddr frequency scaling with
following flow:

             kernel                                bl31

        monitor ddr load
                |
                |
        get_target_rate
                |
                |           pass rate to bl31
        clk_set_rate(ddr) --------------------->run dcf flow
                |                                   |
                |                                   |
        wait dcf interrupt<-------------------trigger dcf interrupt
                |
                |
              return

Lin Huang (8):
  clk: rockchip: add new clock-type for the ddrclk
  clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
  clk: rockchip: rk3399: add ddrc clock support
  Documentation: bindings: add dt documentation for dfi controller
  PM / devfreq: event: support rockchip dfi controller
  Documentation: bindings: add dt documentation for rk3399 dmc
  PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
  drm/rockchip: Add dmc notifier in vop driver

 .../bindings/devfreq/event/rockchip-dfi.txt        |  20 +
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |  84 ++++
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-ddr.c                     | 150 +++++++
 drivers/clk/rockchip/clk-rk3399.c                  |  19 +
 drivers/clk/rockchip/clk.c                         |   9 +
 drivers/clk/rockchip/clk.h                         |  33 ++
 drivers/devfreq/Kconfig                            |  11 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/event/Kconfig                      |   7 +
 drivers/devfreq/event/Makefile                     |   1 +
 drivers/devfreq/event/rockchip-dfi.c               | 253 +++++++++++
 drivers/devfreq/rk3399_dmc.c                       | 497 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 121 ++++-
 include/dt-bindings/clock/rk3399-cru.h             |   1 +
 include/soc/rockchip/rockchip_sip.h                |  27 ++
 16 files changed, 1233 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 drivers/clk/rockchip/clk-ddr.c
 create mode 100644 drivers/devfreq/event/rockchip-dfi.c
 create mode 100644 drivers/devfreq/rk3399_dmc.c
 create mode 100644 include/soc/rockchip/rockchip_sip.h

-- 
2.6.6
*

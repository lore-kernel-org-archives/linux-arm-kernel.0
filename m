From: hl@rock-chips.com (Lin Huang)
Date: Mon,  5 Sep 2016 13:06:06 +0800
Subject: [PATCH v10 0/5] rk3399 support ddr frequency scaling
Message-ID: <1473051971-5500-1-git-send-email-hl@rock-chips.com>
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


Lin Huang (5):
  Documentation: bindings: add dt documentation for dfi controller
  PM / devfreq: event: support rockchip dfi controller
  Documentation: bindings: add dt documentation for rk3399 dmc
  PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
  drm/rockchip: Add dmc notifier in vop driver

Following patch:
clk: rockchip: add new clock-type for the ddrclk
clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
clk: rockchip: rk3399: add ddrc clock support
have applied to:
http://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/v4.9-clk/next


 .../bindings/devfreq/event/rockchip-dfi.txt        |  19 +
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 210 +++++++++
 drivers/devfreq/Kconfig                            |  11 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/event/Kconfig                      |   7 +
 drivers/devfreq/event/Makefile                     |   1 +
 drivers/devfreq/event/rockchip-dfi.c               | 256 +++++++++++
 drivers/devfreq/rk3399_dmc.c                       | 480 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 116 +++++
 9 files changed, 1101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
 create mode 100644 drivers/devfreq/event/rockchip-dfi.c
 create mode 100644 drivers/devfreq/rk3399_dmc.c

-- 
2.6.6

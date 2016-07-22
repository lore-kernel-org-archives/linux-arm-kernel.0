From: hl@rock-chips.com (Lin Huang)
Date: Fri, 22 Jul 2016 17:07:13 +0800
Subject: [PATCH v3 0/7] rk3399 support ddr frequency scaling 
Message-ID: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
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

Lin Huang (6):
  clk: rockchip: add new clock-type for the ddrclk
  clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
  clk: rockchip: rk3399: add ddrc clock support
  PM / devfreq: event: support rockchip dfi controller
  PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
  drm/rockchip: Add dmc notifier in vop driver

Shengfei xu (1):
  firmware: rockchip: sip: Add rockchip SIP runtime service

 drivers/clk/rockchip/Makefile               |   1 +
 drivers/clk/rockchip/clk-ddr.c              | 139 ++++++++
 drivers/clk/rockchip/clk-rk3399.c           |  19 ++
 drivers/clk/rockchip/clk.c                  |   9 +
 drivers/clk/rockchip/clk.h                  |  27 ++
 drivers/devfreq/Kconfig                     |   1 +
 drivers/devfreq/Makefile                    |   1 +
 drivers/devfreq/event/Kconfig               |   7 +
 drivers/devfreq/event/Makefile              |   1 +
 drivers/devfreq/event/rockchip-dfi.c        | 253 +++++++++++++++
 drivers/devfreq/rockchip/Kconfig            |  15 +
 drivers/devfreq/rockchip/Makefile           |   2 +
 drivers/devfreq/rockchip/rk3399_dmc.c       | 482 ++++++++++++++++++++++++++++
 drivers/devfreq/rockchip/rockchip_dmc.c     | 143 +++++++++
 drivers/firmware/Kconfig                    |   7 +
 drivers/firmware/Makefile                   |   1 +
 drivers/firmware/rockchip_sip.c             |  64 ++++
 drivers/firmware/rockchip_sip.h             |  59 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  75 ++++-
 include/dt-bindings/clock/rk3399-cru.h      |   1 +
 include/soc/rockchip/rockchip_dmc.h         |  45 +++
 21 files changed, 1346 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-ddr.c
 create mode 100644 drivers/devfreq/event/rockchip-dfi.c
 create mode 100644 drivers/devfreq/rockchip/Kconfig
 create mode 100644 drivers/devfreq/rockchip/Makefile
 create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
 create mode 100644 drivers/devfreq/rockchip/rockchip_dmc.c
 create mode 100644 drivers/firmware/rockchip_sip.c
 create mode 100644 drivers/firmware/rockchip_sip.h
 create mode 100644 include/soc/rockchip/rockchip_dmc.h

-- 
2.6.6

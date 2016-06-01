From: hl@rock-chips.com (Lin Huang)
Date: Wed,  1 Jun 2016 17:35:35 +0800
Subject: [RFC PATCH 0/4] rk3399 support ddr frequency scaling
Message-ID: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
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

Lin Huang (4):
  rockchip: rockchip: add new clock-type for the ddrclk
  clk: rockchip: rk3399: add ddrc clock support
  PM / devfreq: rockchip: add devfreq driver for rk3399 dmc
  drm/rockchip: Add dmc notifier in vop driver

 drivers/clk/rockchip/Makefile               |   1 +
 drivers/clk/rockchip/clk-ddr.c              | 147 ++++++++++
 drivers/clk/rockchip/clk-rk3399.c           |  16 +
 drivers/clk/rockchip/clk.c                  |   9 +
 drivers/clk/rockchip/clk.h                  |  27 ++
 drivers/devfreq/Kconfig                     |   2 +-
 drivers/devfreq/Makefile                    |   1 +
 drivers/devfreq/rockchip/Kconfig            |  14 +
 drivers/devfreq/rockchip/Makefile           |   2 +
 drivers/devfreq/rockchip/rk3399_dmc.c       | 438 ++++++++++++++++++++++++++++
 drivers/devfreq/rockchip/rockchip_dmc.c     | 132 +++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  51 +++-
 include/dt-bindings/clock/rk3399-cru.h      |   1 +
 include/soc/rockchip/rockchip_dmc.h         |  44 +++
 14 files changed, 882 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/rockchip/clk-ddr.c
 create mode 100644 drivers/devfreq/rockchip/Kconfig
 create mode 100644 drivers/devfreq/rockchip/Makefile
 create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
 create mode 100644 drivers/devfreq/rockchip/rockchip_dmc.c
 create mode 100644 include/soc/rockchip/rockchip_dmc.h

-- 
1.9.1

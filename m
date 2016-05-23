From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 23 May 2016 16:58:56 +0200
Subject: [PATCH 0/3] Rockchip: generalize GRF setup
Message-ID: <1464015539-19521-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The General register files contain a big bunch of settings for various
components. Things like the automatic sdmmc/jtag switch may even affect
us in a bad way, while that property (and possibly others) are not even
part of the dw_mmc controller itself.

And while the rk3288 could still carry adaptions to these defaults
in its mach files, this is no longer possible on the arm64 socs, while
things like the jtag-switch from above still can affect us there.

So introduce a separate driver that binds to the already set soc-
specific grf compatibles and does the necessary setup for things.

It could also take over handling the grf pclk so that we don't have
to have the clock-framework keep control of it, as disabling causes
havok on the system.


Heiko Stuebner (3):
  dt-bindings: add used but undocumented rockchip grf compatible values
  soc: rockchip: add driver handling grf setup
  ARM: rockchip: drop jtag/mmc switch handling

 .../devicetree/bindings/soc/rockchip/grf.txt       |   4 +
 arch/arm/mach-rockchip/rockchip.c                  |  12 --
 drivers/soc/rockchip/Kconfig                       |  10 ++
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/grf.c                         | 138 +++++++++++++++++++++
 5 files changed, 153 insertions(+), 12 deletions(-)
 create mode 100644 drivers/soc/rockchip/grf.c

-- 
2.6.4

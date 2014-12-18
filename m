From: amstan@chromium.org (Alexandru M Stan)
Date: Thu, 18 Dec 2014 15:01:00 -0800
Subject: [PATCH 0/3] mmc: dw_mmc: Generic clock phase tuning that works with
 rk3288 (possibly more!)
Message-ID: <1418943663-10012-1-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements most of what's required to have tuning work on rk3288. A
lot of this is inspired by the exynos tuning code, but generalized to work for
any number of phases. At one point I realized that the tuning is not rockchip
specific so I changed it to work for any dw_mmc device.

Rockchip specific stuff:
"rk3288: Add drive/sample clocks" needs "ARM: dts: rockchip: set dw_mmc max-freq
150Mhz" to apply cleanly. So this series is based on heiko's github repository:
https://github.com/mmind/linux-rockchip/tree/wip/v3.20-armsoc/dts

The missing DTO interrupt is still a problem in DWMMC, at least on rockchip. So
if you want to test this you might want to grab "[PATCH v3] mmc: dw_mmc: add
quirk for broken data transfer over scheme" and my change in the replies there.
Warning: it still causes problems on some cards.

And of course one would have to enable the high speed functionality, something
like this would suffice:
https://chromium-review.googlesource.com/#/c/227199/34/arch/arm/boot/dts/rk3288-veyron.dtsi


Alexandru M Stan (3):
  mmc: dw_mmc: dt-binding: Add tuning related things
  mmc: dw_mmc: Generic MMC tuning with the clock phase framework
  ARM: dts: rk3288: Add drive/sample clocks for dw_mmc devices

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  14 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  20 ++-
 drivers/mmc/host/dw_mmc.c                          | 189 +++++++++++++++++++++
 include/linux/mmc/dw_mmc.h                         |   3 +
 4 files changed, 214 insertions(+), 12 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

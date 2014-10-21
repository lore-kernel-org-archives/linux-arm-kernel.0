From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 21 Oct 2014 16:17:41 -0700
Subject: [PATCH v4 0/6] this is the 1st version of suspend. RK3288 can shut
 down the cpu, gpu and
Message-ID: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

other device controllers in suspend, and it will pull the GLOBAL_PWROFF pin
to high in the final stage of the process of suspend, pull the pin to low again
when resume.

Changes in v4:
- use SIMPLE_DE_PM_OPS for suspend/resume struct
- remove grf regmap

Changes in v3:
- move the pinmux of gpio6_c6 save and restore to pinctrl-rockchip

Changes in v2:
- __raw_readl/__raw_writel replaced by readl_relaxed/writel_relaxed
- add the regulator calls in prepare and finish.
- add the pinmux of gpio6_c6 save and restore
- put "rockchip,rk3288-pmu-sram" to first

Chris (1):
  pinctrl: rockchip: add suspend/resume functions

Chris Zhong (5):
  pinctrl: rockchip: save and restore gpio6_c6 pinmux in suspend/resume
  clk: rockchip: RK3288: add suspend and resume
  ARM: rockchip: add suspend and resume for RK3288
  ARM: rockchip: Add pmu-sram binding
  ARM: dts: add RK3288 suspend support

 .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |   15 +
 arch/arm/boot/dts/rk3288.dtsi                      |   11 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/pm.c                        |  307 ++++++++++++++++++++
 arch/arm/mach-rockchip/pm.h                        |  102 +++++++
 arch/arm/mach-rockchip/rockchip.c                  |   11 +-
 arch/arm/mach-rockchip/sleep.S                     |   87 ++++++
 drivers/clk/rockchip/clk-rk3288.c                  |   63 ++++
 drivers/pinctrl/pinctrl-rockchip.c                 |   47 +++
 9 files changed, 642 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
 create mode 100644 arch/arm/mach-rockchip/pm.c
 create mode 100644 arch/arm/mach-rockchip/pm.h
 create mode 100644 arch/arm/mach-rockchip/sleep.S

-- 
1.7.9.5

From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  7 Nov 2014 21:49:32 +0800
Subject: [PATCH v7 0/5] This is the 1st version of suspend for RK3288.
Message-ID: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3288 can shut down the cpu, gpu and other device controllers in suspend,
and it will pull the GLOBAL_PWROFF pin to high in the final stage of the
process of suspend, pull the pin to low again when resume.

Changes in v7:
- get rid all of unused code
- add regulator-state-mem sub node for suspend

Changes in v6:
- modify comments
- get rid of the save/restore of SRAM
- doing the copy of resume code once at init time
- remove ROCKCHIP_ARM_OFF_LOGIC_DEEP from rk3288_fill_in_bootram
- add of_platform_populate in rockchip_dt_init
- change pmu_intmem at ff720000 to sram at ff720000
- change pmu_intmem at ff720000 to sram at ff720000

Changes in v5:
- modify comments
- use rk3288_bootram_sz for memcpy size
- fixed error of sram save and restore
- change the size of sram in example
- change size to 4k

Changes in v4:
- remove grf regmap

Changes in v3:
- move the pinmux of gpio6_c6 save and restore to pinctrl-rockchip

Changes in v2:
- __raw_readl/__raw_writel replaced by readl_relaxed/writel_relaxed
- add the regulator calls in prepare and finish.
- add the pinmux of gpio6_c6 save and restore
- put "rockchip,rk3288-pmu-sram" to first

Chris Zhong (5):
  clk: rockchip: RK3288: add suspend and resume
  ARM: rockchip: add suspend and resume for RK3288
  ARM: rockchip: Add pmu-sram binding
  ARM: dts: add RK3288 suspend support
  ARM: dts: add suspend voltage setting for RK808

 .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |  16 ++
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |  46 +++-
 arch/arm/boot/dts/rk3288.dtsi                      |  11 +
 arch/arm/mach-rockchip/Makefile                    |   1 +
 arch/arm/mach-rockchip/pm.c                        | 264 +++++++++++++++++++++
 arch/arm/mach-rockchip/pm.h                        |  99 ++++++++
 arch/arm/mach-rockchip/rockchip.c                  |   2 +
 arch/arm/mach-rockchip/sleep.S                     |  73 ++++++
 drivers/clk/rockchip/clk-rk3288.c                  |  60 +++++
 9 files changed, 571 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
 create mode 100644 arch/arm/mach-rockchip/pm.c
 create mode 100644 arch/arm/mach-rockchip/pm.h
 create mode 100644 arch/arm/mach-rockchip/sleep.S

-- 
1.9.1

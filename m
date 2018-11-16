From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:23 +0530
Subject: [PATCH 00/10] ARM64: dts: Fix incomplete cooling-maps
Message-ID: <cover.1542362530.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Now that the below commit are merged in mainline, we can start fixing
the ARM64 platform specific DT files:
    
commit d7a4303b8d1f ("dt-bindings: thermal: Allow multiple devices to
share cooling map")

commit a92bab8919e3 ("of: thermal: Allow multiple devices to share
cooling map")

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Individual maintainers can take the patches through their tree.

--
viresh

Viresh Kumar (10):
  ARM64: dts: amlogic: Add all CPUs in cooling maps
  ARM64: dts: exynos: Add all CPUs in cooling maps
  ARM64: dts: fsl: Add all CPUs in cooling maps
  arm64: dts: hi3660: Add missing cooling device properties for CPUs
  ARM64: dts: hisilicon: Add all CPUs in cooling maps
  ARM64: dts: mediatek: Add all CPUs in cooling maps
  ARM64: dts: msm8916: Add all CPUs in cooling maps
  ARM64: dts: renesas: Add all CPUs in cooling maps
  ARM64: dts: rockchip: Add all CPUs in cooling maps
  ARM64: dts: uniphier: Add all CPUs in cooling maps

 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 22 +++++-------
 .../arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 ++++++++++++-------
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 17 +++++----
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 28 +++++----------
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     | 16 +++++++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  9 ++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |  9 +++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  6 ++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 10 ++++--
 arch/arm64/boot/dts/renesas/r8a7795.dtsi      | 15 ++++++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi      |  6 ++--
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  5 ++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 15 ++++++--
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  8 +++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 12 +++++--
 .../boot/dts/socionext/uniphier-ld20.dtsi     | 11 +++---
 18 files changed, 147 insertions(+), 90 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

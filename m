From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:31:09 +0530
Subject: [PATCH 0/6] ARM: dts: Fix incomplete cooling-maps
Message-ID: <cover.1542362000.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Now that the below commit are merged in mainline, we can start fixing
the platform specific DT files:

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

--
viresh

Viresh Kumar (6):
  ARM: dts: exynos: Add all CPUs in cooling maps
  ARM: dts: ls1021a: Add all CPUs in cooling maps
  ARM: dts: mt7623: Add all CPUs in cooling maps
  ARM: dts: rockchip: Add all CPUs in cooling maps
  ARM: dts: sunxi: Add all CPUs in cooling maps
  ARM: dts: uniphier: Add all CPUs in cooling maps

 arch/arm/boot/dts/exynos3250-artik5.dtsi      |   6 +-
 arch/arm/boot/dts/exynos3250-monk.dts         |   6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       |   6 +-
 arch/arm/boot/dts/exynos4210-trats.dts        |   4 +-
 arch/arm/boot/dts/exynos4210.dtsi             |   2 +-
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi       |   8 +-
 .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  17 ++-
 arch/arm/boot/dts/exynos4412.dtsi             |   6 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   7 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 106 +++++++++++-------
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 106 +++++++++++-------
 arch/arm/boot/dts/ls1021a.dtsi                |   2 +
 arch/arm/boot/dts/mt7623.dtsi                 |  15 ++-
 arch/arm/boot/dts/rk322x.dtsi                 |  10 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts    |  24 ++--
 arch/arm/boot/dts/rk3288.dtsi                 |  15 ++-
 arch/arm/boot/dts/sun6i-a31.dtsi              |  11 +-
 arch/arm/boot/dts/sun7i-a20.dtsi              |   5 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              |  16 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi          |   6 +-
 22 files changed, 250 insertions(+), 144 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

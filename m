From: samuel@sholland.org (Samuel Holland)
Date: Wed, 11 Jul 2018 21:25:13 -0500
Subject: [PATCH v2 0/2] Allwinner A64 timer workaround
Message-ID: <20180712022515.7255-1-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Several people (including me) have experienced extremely large system
clock jumps on their A64-based devices, apparently due to the
architectural timer going backward, which is interpreted by Linux as
the timer wrapping around after 2^56 cycles.

Investigation led to discovery of some obvious problems with this SoC's
architectural timer, and this patch series introduces at least a partial
workaround. It covers up small-scale instability in the timer, which
reduces the incidence of the large system clock jumps. More details are
in the commit message for patch 1. Patch 2 simply enables the workaround
in the device tree.

I chose not to send this to stable, since it is most likely not a
complete solution.

Thanks,
Samuel

changes since v1:
- Add an iteration limit like most other arch timer workarounds
- Added Andre's Tested-by

Samuel Holland (2):
  arm64: arch_timer: Workaround for Allwinner A64 timer instability
  arm64: dts: allwinner: a64: Enable A64 timer workaround

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
 drivers/clocksource/Kconfig                   | 11 +++++++
 drivers/clocksource/arm_arch_timer.c          | 43 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

-- 
2.16.1

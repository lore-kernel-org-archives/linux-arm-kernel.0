From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 26 Sep 2011 15:20:45 +0800
Subject: [PATCH v3 0/6] add initial imx6q support
Message-ID: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the initial support for imx6q, which is a
Cortex-A9 Quad Core based SoC.

We chose to add imx6q support into mach-imx other than mach-mx5 or
a new mach-mx6, because we intend to merge mach-mx5 into mach-imx, so
that we have only mach-imx for imx family.

It's based on v3.1-rc7 with the patches below applied.

 * [PATCH v2 0/5] Convert DEBUG_LL UART selection to a Kconfig choice
   http://thread.gmane.org/gmane.linux.ports.arm.kernel/129702

 * [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
   http://article.gmane.org/gmane.linux.kernel/1164401

 * [PATCH 1/7] ARM: l2x0: add empty l2x0_of_init
   http://article.gmane.org/gmane.linux.ports.arm.kernel/130878

 * [PATCH 0/3] GIC OF bindings
   http://thread.gmane.org/gmane.linux.drivers.devicetree/8338/

For suspend/resume support, it needs the following extra patches as the
prerequisite.

 * [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
   http://thread.gmane.org/gmane.linux.ports.arm.kernel/130957/

 * [PATCH v2 0/5] CPU PM notifiers
   http://thread.gmane.org/gmane.linux.ports.arm.kernel/131212/focus=131353

 * [PATCH v2 2/2] ARM: smp_scu: remove __init annotation from
   scu_enable()
   http://permalink.gmane.org/gmane.linux.ports.arm.kernel/131358

Changes since v2:
 * Refine the L2 register save/restore implementation per Lorenzo's
   suggestion
 * Rebase to Rob's latest GIC OF bindings series
 * Rebase to Sascha's MULTI_IRQ_HANDLER support series

Changes since v1:
 * Use the existing IMX_IO_P2V for static mapping
 * Fix the MXC_INTERNAL_IRQS breakage introduced by GIC definition
 * Retrieve clock frequency for fixed clocks from device tree
 * Drop early_initcall from imx_src_init() and call it from imx6q
   platform initialization
 * Use readl_relaxed/writel_relaxed rather than __raw_readl/__raw_writel
   as suggested by Arnd
 * Kill unnecessary imx_local_timer_pre_suspend/resume functions
 * Kill Kconfig symbol MACH_IMX6Q
 * Rebase to rmk's "Add L2 cache cleaning to generic CPU suspend" series
   so that we can retain L2 cache with necessary L2 register
   save/restore across suspend/resume cycle
 * Rebase to Rob's new "GIC OF bindings" series

Thanks.

Shawn Guo (6):
      arm/imx6q: add device tree source
      arm/imx6q: add core definitions and low-level debug uart
      arm/imx6q: add core drivers clock, gpc, mmdc and src
      arm/imx6q: add smp and cpu hotplug support
      arm/imx6q: add device tree machine support
      arm/imx6q: add suspend/resume support

 Documentation/devicetree/bindings/arm/fsl.txt |    6 +
 arch/arm/Kconfig                              |    2 +-
 arch/arm/Kconfig.debug                        |    7 +
 arch/arm/Makefile                             |    1 +
 arch/arm/boot/dts/imx6q-sabreauto.dts         |   82 +
 arch/arm/boot/dts/imx6q.dtsi                  |  555 +++++++
 arch/arm/mach-imx/Kconfig                     |   29 +-
 arch/arm/mach-imx/Makefile                    |   10 +
 arch/arm/mach-imx/Makefile.boot               |    4 +
 arch/arm/mach-imx/clock-imx6q.c               | 2012 +++++++++++++++++++++++++
 arch/arm/mach-imx/gpc.c                       |  113 ++
 arch/arm/mach-imx/head-v7.S                   |  103 ++
 arch/arm/mach-imx/hotplug.c                   |   44 +
 arch/arm/mach-imx/lluart.c                    |   32 +
 arch/arm/mach-imx/localtimer.c                |   35 +
 arch/arm/mach-imx/mach-imx6q.c                |   84 +
 arch/arm/mach-imx/mmdc.c                      |   71 +
 arch/arm/mach-imx/platsmp.c                   |   85 ++
 arch/arm/mach-imx/pm-imx6q.c                  |   90 ++
 arch/arm/mach-imx/src.c                       |   49 +
 arch/arm/mm/Kconfig                           |    2 +-
 arch/arm/plat-mxc/Kconfig                     |    5 +
 arch/arm/plat-mxc/include/mach/common.h       |   27 +
 arch/arm/plat-mxc/include/mach/debug-macro.S  |    2 +
 arch/arm/plat-mxc/include/mach/hardware.h     |    6 +
 arch/arm/plat-mxc/include/mach/irqs.h         |   10 +-
 arch/arm/plat-mxc/include/mach/memory.h       |    3 +
 arch/arm/plat-mxc/include/mach/mx6q.h         |   33 +
 28 files changed, 3497 insertions(+), 5 deletions(-)

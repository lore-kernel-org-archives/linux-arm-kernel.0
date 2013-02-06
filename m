From: robherring2@gmail.com (Rob Herring)
Date: Wed, 06 Feb 2013 16:21:14 -0600
Subject: [GIT PULL 4/4] mach-virt platform code for 3.9
In-Reply-To: <1359986131-13034-4-git-send-email-will.deacon@arm.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-4-git-send-email-will.deacon@arm.com>
Message-ID: <5112D75A.1000900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2013 07:55 AM, Will Deacon wrote:
> NOTE: I'm not suggesting you pull this one as it stands -- see below!
> 
> This is the last batch from me (Marc is dealing with vgic and virtual
> timers) and introduces support for mach-virt. This depends on:
> 
> 	- for-arm-soc/arch-timers (third pull request in this series)
> 	- for-rmk/virt/psci (already pulled)
> 	- irqchip/gic-vic-move (an arm-soc branch)
> 
> As a result, the diffstat is atrocious so it would be better if you
> could create a branch merging the above dependendies, which I could
> rebase onto (there's actually only two patches here).

It would be good to see this based on Arnd's patch to make some of the
mach function ptrs optional and "xen,xenvm" moved from VExpress to this.

This will also break with the sys_timer removal, so yet another dependency.

Rob

> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 04c2eee5b9dfcb13f3cd07a5537fb8c785f2751a:
> 
>   Merge branch 'x86-efi-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-01-31 17:10:36 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-arm-soc/virt/mach
> 
> for you to fetch changes up to 4de3abb348d7a5bd6ddbfc26c34e0ee549874249:
> 
>   ARM: mach-virt: add SMP support using PSCI (2013-02-02 15:05:33 +0000)
> 
> ----------------------------------------------------------------
> Marc Zyngier (2):
>       ARM: arch_timers: switch to physical timers if HYP mode is available
>       ARM: Dummy Virtual Machine platform support
> 
> Mark Rutland (17):
>       arm: arch_timer: balance device_node refcounting
>       arm: arch_timer: remove redundant available check
>       arm: arch_timer: use u64/u32 for register data
>       arm: arch_timer: standardise counter reading
>       arm: arch_timer: split cntfrq accessor
>       arm: arch_timer: factor out register accessors
>       arm: arch_timer: add isbs to register accessors
>       arm: arch_timer: divorce from local_timer api
>       arm: arch_timer: add arch_counter_set_user_access
>       arm: arch_timer: move core to drivers/clocksource
>       arm64: arm_generic: prevent reading stale time
>       arm64: move from arm_generic to arm_arch_timer
>       Documentation: Add ARMv8 to arch_timer devicetree
>       clockevents: Add generic timer broadcast receiver
>       clockevents: Add generic timer broadcast function
>       arm: Use generic timer broadcast receiver
>       arm: Add generic timer broadcast support
> 
> Rob Herring (16):
>       ARM: GIC: remove assembly ifdefs from gic.h
>       ARM: GIC: remove direct use of gic_raise_softirq
>       ARM: GIC: set handle_arch_irq in GIC initialization
>       ARM: remove mach .handle_irq for GIC users
>       irqchip: Move ARM GIC to drivers/irqchip
>       ARM: use common irqchip_init for GIC init
>       irqchip: Move ARM gic.h to include/linux/irqchip/arm-gic.h
>       ARM: VIC: shrink down vic.h
>       ARM: VIC: set handle_arch_irq in VIC initialization
>       ARM: remove mach .handle_irq for VIC users
>       ARM: remove unneeded vic.h includes
>       ARM: samsung: remove unused tick.h
>       irqchip: Move ARM VIC to drivers/irqchip
>       ARM: spear: use common irqchip_init function
>       ARM: picoxcell: use common irqchip_init function
>       irqchip: Move ARM vic.h to include/linux/irqchip/arm-vic.h
> 
> Srinidhi Kasagar (1):
>       ARM: mach-ux500: use SGI0 to wake up the other core
> 
> Thomas Petazzoni (3):
>       irqchip: add to the directories part of the IRQ subsystem in MAINTAINERS
>       irqchip: add basic infrastructure
>       arm: add set_handle_irq() to register the parent IRQ controller handler function
> 
> Will Deacon (10):
>       ARM: opcodes: add missing include of linux/linkage.h
>       ARM: opcodes: add opcodes definitions for ARM security extensions
>       ARM: psci: add devicetree binding for describing PSCI firmware
>       ARM: psci: add support for PSCI invocations from the kernel
>       Merge branch 'timers/for-arm' of git://git.kernel.org/.../tip/tip into for-rmk/broadcast
>       Merge branch 'clocks/broadcast-arm' of git://linux-arm.org/linux-mr into for-rmk/broadcast
>       Merge branch 'for-will/arch-timer-unification' of git://linux-arm.org/linux-mr into for-arm-soc/arch-timers
>       Merge branch 'for-rmk/virt/psci' into for-arm-soc/virt/mach
>       Merge branch 'irqchip/gic-vic-move' of git://git.kernel.org/.../arm/arm-soc into for-arm-soc/virt/mach
>       ARM: mach-virt: add SMP support using PSCI
> 
>  .../devicetree/bindings/arm/arch_timer.txt         |   7 +-
>  Documentation/devicetree/bindings/arm/psci.txt     |  55 +++
>  MAINTAINERS                                        |   1 +
>  arch/arm/Kconfig                                   |  16 +-
>  arch/arm/Makefile                                  |   1 +
>  arch/arm/common/Kconfig                            |  23 -
>  arch/arm/common/Makefile                           |   2 -
>  arch/arm/include/asm/arch_timer.h                  | 109 ++++-
>  arch/arm/include/asm/mach/irq.h                    |   1 +
>  .../arm/include/asm/opcodes-sec.h                  |  19 +-
>  arch/arm/include/asm/opcodes.h                     |   1 +
>  arch/arm/include/asm/psci.h                        |  36 ++
>  arch/arm/kernel/Makefile                           |   1 +
>  arch/arm/kernel/arch_timer.c                       | 504 +--------------------
>  arch/arm/kernel/irq.c                              |  10 +
>  arch/arm/kernel/psci.c                             | 211 +++++++++
>  arch/arm/kernel/smp.c                              |  16 +-
>  arch/arm/kernel/smp_twd.c                          |   1 -
>  arch/arm/mach-bcm/board_bcm.c                      |  17 +-
>  arch/arm/mach-cns3xxx/cns3420vb.c                  |   2 -
>  arch/arm/mach-cns3xxx/core.c                       |   2 +-
>  arch/arm/mach-ep93xx/adssphere.c                   |   2 -
>  arch/arm/mach-ep93xx/core.c                        |   3 +-
>  arch/arm/mach-ep93xx/edb93xx.c                     |   9 -
>  arch/arm/mach-ep93xx/gesbc9312.c                   |   2 -
>  arch/arm/mach-ep93xx/micro9.c                      |   5 -
>  arch/arm/mach-ep93xx/simone.c                      |   2 -
>  arch/arm/mach-ep93xx/snappercl15.c                 |   2 -
>  arch/arm/mach-ep93xx/ts72xx.c                      |   2 -
>  arch/arm/mach-ep93xx/vision_ep9307.c               |   2 -
>  arch/arm/mach-exynos/common.c                      |  10 +-
>  arch/arm/mach-exynos/include/mach/regs-irq.h       |   2 +-
>  arch/arm/mach-exynos/mach-armlex4210.c             |   2 -
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |   2 -
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |   2 -
>  arch/arm/mach-exynos/mach-nuri.c                   |   2 -
>  arch/arm/mach-exynos/mach-origen.c                 |   2 -
>  arch/arm/mach-exynos/mach-smdk4x12.c               |   3 -
>  arch/arm/mach-exynos/mach-smdkv310.c               |   3 -
>  arch/arm/mach-exynos/mach-universal_c210.c         |   2 -
>  arch/arm/mach-exynos/mct.c                         |   1 -
>  arch/arm/mach-exynos/platsmp.c                     |   6 +-
>  arch/arm/mach-highbank/highbank.c                  |  11 +-
>  arch/arm/mach-highbank/platsmp.c                   |   6 +-
>  arch/arm/mach-imx/common.h                         |   1 -
>  arch/arm/mach-imx/gpc.c                            |   2 +-
>  arch/arm/mach-imx/mach-imx6q.c                     |  10 +-
>  arch/arm/mach-imx/platsmp.c                        |   4 +-
>  arch/arm/mach-msm/board-dt-8660.c                  |  16 +-
>  arch/arm/mach-msm/board-dt-8960.c                  |  16 +-
>  arch/arm/mach-msm/platsmp.c                        |   6 +-
>  arch/arm/mach-msm/timer.c                          |   1 -
>  arch/arm/mach-netx/generic.c                       |   2 +-
>  arch/arm/mach-netx/nxdb500.c                       |   2 -
>  arch/arm/mach-netx/nxdkn.c                         |   2 -
>  arch/arm/mach-netx/nxeb500hmi.c                    |   2 -
>  arch/arm/mach-nomadik/board-nhk8815.c              |   2 -
>  arch/arm/mach-nomadik/cpu-8815.c                   |   2 +-
>  arch/arm/mach-omap2/Kconfig                        |   2 +-
>  arch/arm/mach-omap2/board-4430sdp.c                |   3 +-
>  arch/arm/mach-omap2/board-generic.c                |   3 -
>  arch/arm/mach-omap2/board-omap4panda.c             |   3 +-
>  arch/arm/mach-omap2/omap-smp.c                     |   6 +-
>  arch/arm/mach-omap2/omap-wakeupgen.c               |   3 +-
>  arch/arm/mach-omap2/omap4-common.c                 |  11 +-
>  arch/arm/mach-picoxcell/common.c                   |  15 +-
>  arch/arm/mach-realview/core.c                      |   1 -
>  arch/arm/mach-realview/platsmp.c                   |   3 -
>  arch/arm/mach-realview/realview_eb.c               |   3 +-
>  arch/arm/mach-realview/realview_pb1176.c           |   3 +-
>  arch/arm/mach-realview/realview_pb11mp.c           |   3 +-
>  arch/arm/mach-realview/realview_pba8.c             |   3 +-
>  arch/arm/mach-realview/realview_pbx.c              |   3 +-
>  arch/arm/mach-s3c64xx/common.c                     |   2 +-
>  arch/arm/mach-s3c64xx/include/mach/regs-irq.h      |   1 -
>  arch/arm/mach-s3c64xx/include/mach/tick.h          |   2 +
>  arch/arm/mach-s3c64xx/mach-anw6410.c               |   2 -
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |   2 -
>  arch/arm/mach-s3c64xx/mach-hmt.c                   |   2 -
>  arch/arm/mach-s3c64xx/mach-mini6410.c              |   2 -
>  arch/arm/mach-s3c64xx/mach-ncp.c                   |   2 -
>  arch/arm/mach-s3c64xx/mach-real6410.c              |   2 -
>  arch/arm/mach-s3c64xx/mach-smartq5.c               |   2 -
>  arch/arm/mach-s3c64xx/mach-smartq7.c               |   2 -
>  arch/arm/mach-s3c64xx/mach-smdk6400.c              |   2 -
>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |   2 -
>  arch/arm/mach-s5p64x0/include/mach/regs-irq.h      |   1 -
>  arch/arm/mach-s5p64x0/include/mach/tick.h          |  29 --
>  arch/arm/mach-s5p64x0/mach-smdk6440.c              |   2 -
>  arch/arm/mach-s5p64x0/mach-smdk6450.c              |   2 -
>  arch/arm/mach-s5pc100/include/mach/regs-irq.h      |   1 -
>  arch/arm/mach-s5pc100/include/mach/tick.h          |   2 +
>  arch/arm/mach-s5pc100/mach-smdkc100.c              |   2 -
>  arch/arm/mach-s5pv210/include/mach/regs-irq.h      |   1 -
>  arch/arm/mach-s5pv210/include/mach/tick.h          |  26 --
>  arch/arm/mach-s5pv210/mach-aquila.c                |   2 -
>  arch/arm/mach-s5pv210/mach-goni.c                  |   2 -
>  arch/arm/mach-s5pv210/mach-smdkc110.c              |   2 -
>  arch/arm/mach-s5pv210/mach-smdkv210.c              |   2 -
>  arch/arm/mach-s5pv210/mach-torbreck.c              |   2 -
>  arch/arm/mach-shmobile/board-ag5evm.c              |   3 +-
>  arch/arm/mach-shmobile/board-kota2.c               |   3 +-
>  arch/arm/mach-shmobile/board-kzm9d.c               |   2 -
>  arch/arm/mach-shmobile/board-kzm9g.c               |   3 +-
>  arch/arm/mach-shmobile/board-marzen.c              |   2 -
>  arch/arm/mach-shmobile/intc-r8a7779.c              |   2 +-
>  arch/arm/mach-shmobile/intc-sh73a0.c               |   2 +-
>  arch/arm/mach-shmobile/platsmp.c                   |   3 -
>  arch/arm/mach-shmobile/setup-emev2.c               |  17 +-
>  arch/arm/mach-shmobile/smp-emev2.c                 |   4 +-
>  arch/arm/mach-shmobile/smp-r8a7779.c               |   2 +-
>  arch/arm/mach-shmobile/smp-sh73a0.c                |   2 +-
>  arch/arm/mach-socfpga/platsmp.c                    |   4 +-
>  arch/arm/mach-socfpga/socfpga.c                    |  14 +-
>  arch/arm/mach-spear13xx/include/mach/generic.h     |   1 -
>  arch/arm/mach-spear13xx/platsmp.c                  |   4 +-
>  arch/arm/mach-spear13xx/spear1310.c                |   5 +-
>  arch/arm/mach-spear13xx/spear1340.c                |   5 +-
>  arch/arm/mach-spear13xx/spear13xx.c                |  13 +-
>  arch/arm/mach-spear3xx/include/mach/generic.h      |   1 -
>  arch/arm/mach-spear3xx/spear300.c                  |   5 +-
>  arch/arm/mach-spear3xx/spear310.c                  |   5 +-
>  arch/arm/mach-spear3xx/spear320.c                  |   5 +-
>  arch/arm/mach-spear3xx/spear3xx.c                  |  16 -
>  arch/arm/mach-spear6xx/spear6xx.c                  |  16 +-
>  arch/arm/mach-sunxi/sunxi.c                        |   2 -
>  arch/arm/mach-tegra/board-dt-tegra20.c             |   3 -
>  arch/arm/mach-tegra/board-dt-tegra30.c             |   2 -
>  arch/arm/mach-tegra/common.c                       |  10 +-
>  arch/arm/mach-tegra/irq.c                          |   3 +-
>  arch/arm/mach-tegra/platsmp.c                      |   4 +-
>  arch/arm/mach-u300/core.c                          |   3 +-
>  arch/arm/mach-ux500/board-mop500.c                 |   5 -
>  arch/arm/mach-ux500/cpu-db8500.c                   |   2 -
>  arch/arm/mach-ux500/cpu.c                          |  10 +-
>  arch/arm/mach-ux500/platsmp.c                      |   6 +-
>  arch/arm/mach-versatile/core.c                     |   2 +-
>  arch/arm/mach-versatile/versatile_ab.c             |   2 -
>  arch/arm/mach-versatile/versatile_dt.c             |   2 -
>  arch/arm/mach-versatile/versatile_pb.c             |   2 -
>  arch/arm/mach-vexpress/ct-ca9x4.c                  |   4 +-
>  arch/arm/mach-vexpress/platsmp.c                   |   3 -
>  arch/arm/mach-vexpress/v2m.c                       |  16 +-
>  arch/arm/mach-virt/Kconfig                         |  10 +
>  arch/arm/mach-virt/Makefile                        |   6 +
>  arch/arm/mach-virt/platsmp.c                       |  58 +++
>  arch/arm/mach-virt/virt.c                          |  58 +++
>  arch/arm/mach-zynq/common.c                        |  17 +-
>  arch/arm/plat-samsung/s5p-irq-eint.c               |   3 +-
>  arch/arm/plat-samsung/s5p-irq.c                    |   3 +-
>  arch/arm/plat-versatile/platsmp.c                  |   4 +-
>  arch/arm64/Kconfig                                 |   1 +
>  arch/arm64/include/asm/arch_timer.h                | 133 ++++++
>  arch/arm64/include/asm/arm_generic.h               | 100 ----
>  arch/arm64/kernel/time.c                           |  29 +-
>  drivers/clocksource/Kconfig                        |   6 +-
>  drivers/clocksource/Makefile                       |   2 +-
>  drivers/clocksource/arm_arch_timer.c               | 391 ++++++++++++++++
>  drivers/clocksource/arm_generic.c                  | 232 ----------
>  drivers/irqchip/Kconfig                            |  27 ++
>  drivers/irqchip/Makefile                           |   6 +-
>  arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |  59 ++-
>  arch/arm/common/vic.c => drivers/irqchip/irq-vic.c |  95 ++--
>  drivers/irqchip/irqchip.c                          |  30 ++
>  drivers/irqchip/irqchip.h                          |  29 ++
>  drivers/irqchip/spear-shirq.c                      |   5 +
>  drivers/mfd/db8500-prcmu.c                         |   2 +-
>  include/asm-generic/vmlinux.lds.h                  |  12 +-
>  include/clocksource/arm_arch_timer.h               |  63 +++
>  include/linux/clockchips.h                         |   9 +
>  include/linux/irqchip.h                            |  16 +
>  .../gic.h => include/linux/irqchip/arm-gic.h       |  15 +-
>  .../vic.h => include/linux/irqchip/arm-vic.h       |  25 +-
>  kernel/time/Kconfig                                |   4 +
>  kernel/time/tick-broadcast.c                       |  30 ++
>  175 files changed, 1594 insertions(+), 1458 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/psci.txt
>  rename include/clocksource/arm_generic.h => arch/arm/include/asm/opcodes-sec.h (60%)
>  create mode 100644 arch/arm/include/asm/psci.h
>  create mode 100644 arch/arm/kernel/psci.c
>  delete mode 100644 arch/arm/mach-s5p64x0/include/mach/tick.h
>  delete mode 100644 arch/arm/mach-s5pv210/include/mach/tick.h
>  create mode 100644 arch/arm/mach-virt/Kconfig
>  create mode 100644 arch/arm/mach-virt/Makefile
>  create mode 100644 arch/arm/mach-virt/platsmp.c
>  create mode 100644 arch/arm/mach-virt/virt.c
>  create mode 100644 arch/arm64/include/asm/arch_timer.h
>  delete mode 100644 arch/arm64/include/asm/arm_generic.h
>  create mode 100644 drivers/clocksource/arm_arch_timer.c
>  delete mode 100644 drivers/clocksource/arm_generic.c
>  rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (97%)
>  rename arch/arm/common/vic.c => drivers/irqchip/irq-vic.c (92%)
>  create mode 100644 drivers/irqchip/irqchip.c
>  create mode 100644 drivers/irqchip/irqchip.h
>  create mode 100644 include/clocksource/arm_arch_timer.h
>  create mode 100644 include/linux/irqchip.h
>  rename arch/arm/include/asm/hardware/gic.h => include/linux/irqchip/arm-gic.h (77%)
>  rename arch/arm/include/asm/hardware/vic.h => include/linux/irqchip/arm-vic.h (63%)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

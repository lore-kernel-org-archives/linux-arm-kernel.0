From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 5 Mar 2015 17:40:18 +0100
Subject: [RFC PATCH 00/18] ARM: msm multiplatform support
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <CAPDyKFpuQ50qgUxh7fXrt-2AoqgnQQ5q0heCgzKchKvDQazNag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 20:32, Arnd Bergmann <arnd@arndb.de> wrote:
> This is my final piece of the puzzle for ARMv6/v7 multiplatform
> support. In combination with the other patches that are now
> at git://kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> multiplatform-4.0-rc2 and the at91 and shmobile parts from other
> developers, you can now build one kernel that includes all
> ARMv6 and ARMv7 targets we support in Linux.
>
> Since mach-msm has seen very few updates over the last years,
> it was more work to get to this point than the others, and
> some patches are more of a band-aid than a proper solution.
> Still, I think that each patch in the series is an improvement
> over the status-quo and I really want to see the last one
> merged into 4.1 and it depends on all the other ones.
>
> Stephen Boyd mentioned on IRC that he has been workin on
> a similar series, and I'm more than happy to replace some
> of this work with patches that he has done, as long as we
> can still have the full multiplatform support for 4.1.
>
> Since a lot of the patches are nontrivial and I have not
> been able to test any of this, I'm posting it as an RFC,
> but I'm also very interested in people testing it.
>
>         Arnd
>
> Arnd Bergmann (18):
>   serial: remove obsolete msm_serial_hs driver
>   mmc: msm: move data mover into mmc driver
>   mmc: msm: pass dmov resources via device
>   mmc: msm: move clk-reset logic to platform
>   ARM: msm: fix qsd8x50 rev.a support
>   ARM: msm: fix mach/msm_iomap.h inclusions
>   ARM: msm: fix sirc code for multiplatform
>   ARM: msm: fix gpiomux config for multiplatform
>   ARM: msm: fix vic irqchip for multiplatform
>   gpio: move msm-v1 driver to mach-msm
>   clocksource: qcom: make mach-msm and mach-qcom coexist
>   ARM: msm: make smd behave like a normal driver
>   ARM: msm: rename conflicting symbols
>   ARM: msm: pass gpio irq range as resource
>   ARM: msm: clean up irq handling
>   ARM: msm: make msm_smd.h global
>   ARM: msm: make all header files local
>   ARM: msm: enable multiplatform support
>
>  arch/arm/Kconfig                                   |   12 -
>  arch/arm/configs/msm_defconfig                     |    7 +
>  arch/arm/mach-msm/Kconfig                          |   91 +-
>  arch/arm/mach-msm/Makefile                         |   11 +-
>  arch/arm/mach-msm/board-halibut.c                  |   31 +-
>  arch/arm/mach-msm/board-msm7x30.c                  |   98 +-
>  arch/arm/mach-msm/board-qsd8x50.c                  |  138 +-
>  arch/arm/mach-msm/board-sapphire.c                 |   17 +-
>  arch/arm/mach-msm/board-trout-gpio.c               |    7 +-
>  arch/arm/mach-msm/board-trout-mmc.c                |   33 +-
>  arch/arm/mach-msm/board-trout-panel.c              |    8 +-
>  arch/arm/mach-msm/board-trout.c                    |   26 +-
>  arch/arm/mach-msm/board-trout.h                    |    2 +-
>  arch/arm/mach-msm/{include/mach => }/clk.h         |    0
>  arch/arm/mach-msm/clock-pcom.c                     |    5 +-
>  arch/arm/mach-msm/clock.c                          |    2 +-
>  arch/arm/mach-msm/clock.h                          |    2 +-
>  arch/arm/mach-msm/common.h                         |   16 +-
>  arch/arm/mach-msm/devices-msm7x00.c                |  169 +-
>  arch/arm/mach-msm/devices-msm7x30.c                |   78 +-
>  arch/arm/mach-msm/devices-qsd8x50.c                |  152 +-
>  arch/arm/mach-msm/devices.h                        |   67 +-
>  arch/arm/mach-msm/dma.c                            |  298 ----
>  {drivers/gpio => arch/arm/mach-msm}/gpio-msm-v1.c  |   33 +-
>  arch/arm/mach-msm/gpiomux-8x50.c                   |    2 +-
>  arch/arm/mach-msm/gpiomux-v1.h                     |    9 +-
>  arch/arm/mach-msm/gpiomux.c                        |   18 +-
>  arch/arm/mach-msm/gpiomux.h                        |   10 +-
>  arch/arm/mach-msm/include/mach/dma.h               |  151 --
>  arch/arm/mach-msm/include/mach/entry-macro.S       |   36 -
>  arch/arm/mach-msm/include/mach/hardware.h          |   18 -
>  arch/arm/mach-msm/include/mach/irqs.h              |   37 -
>  arch/arm/mach-msm/include/mach/sirc.h              |   98 -
>  arch/arm/mach-msm/io.c                             |  161 --
>  arch/arm/mach-msm/irq-vic.c                        |  146 +-
>  arch/arm/mach-msm/irq.c                            |   29 +-
>  arch/arm/mach-msm/{include/mach => }/irqs-7x00.h   |    3 +
>  arch/arm/mach-msm/{include/mach => }/irqs-7x30.h   |    2 +
>  arch/arm/mach-msm/{include/mach => }/irqs-8x50.h   |   42 +
>  arch/arm/mach-msm/last_radio_log.c                 |    1 -
>  arch/arm/mach-msm/{include/mach => }/msm_gpiomux.h |    0
>  .../mach-msm/{include/mach => }/msm_iomap-7x00.h   |    5 +-
>  .../mach-msm/{include/mach => }/msm_iomap-7x30.h   |    2 -
>  .../mach-msm/{include/mach => }/msm_iomap-8x50.h   |   12 +-
>  arch/arm/mach-msm/{include/mach => }/msm_iomap.h   |   24 +-
>  arch/arm/mach-msm/proc_comm.c                      |   12 +-
>  arch/arm/mach-msm/proc_comm.h                      |    2 +
>  arch/arm/mach-msm/sirc.c                           |   44 +-
>  arch/arm/mach-msm/sirc.h                           |   34 +
>  arch/arm/mach-msm/smd.c                            |  135 +-
>  arch/arm/mach-msm/smd_debug.c                      |  143 +-
>  arch/arm/mach-msm/smd_private.h                    |   67 +-
>  arch/arm/mach-msm/vreg.c                           |    2 +-
>  arch/arm/mach-msm/{include/mach => }/vreg.h        |    0
>  drivers/char/msm_smd_pkt.c                         |    2 +-
>  drivers/clocksource/qcom-timer.c                   |    3 +-
>  drivers/gpio/Kconfig                               |    8 -
>  drivers/gpio/Makefile                              |    1 -
>  drivers/mmc/host/msm_sdcc.c                        |  384 +++-

The goal from my side is to entirely remove this mmc driver and
instead convert to use the mmci host driver.

If I understand correctly, the current big blocker to reach that goal
is the DMA driver, since it's not converted to the DMA engine API? Do
you know if that's a correct statement?

Anyway, I suppose this patchset can be considered as step in the right
direction, even if I don't like to take patches for the msm_sdcc.c.

Kind regards
Uffe

>  drivers/tty/serial/Kconfig                         |   12 -
>  drivers/tty/serial/msm_serial_hs.c                 | 1874 --------------------
>  drivers/tty/serial/msm_smd_tty.c                   |    2 +-
>  .../include/mach => include/linux}/msm_smd.h       |    0
>  include/linux/platform_data/mmc-msm_sdcc.h         |    3 +
>  include/linux/platform_data/msm_serial_hs.h        |   49 -
>  65 files changed, 1419 insertions(+), 3467 deletions(-)
>  rename arch/arm/mach-msm/{include/mach => }/clk.h (100%)
>  delete mode 100644 arch/arm/mach-msm/dma.c
>  rename {drivers/gpio => arch/arm/mach-msm}/gpio-msm-v1.c (97%)
>  delete mode 100644 arch/arm/mach-msm/include/mach/dma.h
>  delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro.S
>  delete mode 100644 arch/arm/mach-msm/include/mach/hardware.h
>  delete mode 100644 arch/arm/mach-msm/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-msm/include/mach/sirc.h
>  delete mode 100644 arch/arm/mach-msm/io.c
>  rename arch/arm/mach-msm/{include/mach => }/irqs-7x00.h (94%)
>  rename arch/arm/mach-msm/{include/mach => }/irqs-7x30.h (98%)
>  rename arch/arm/mach-msm/{include/mach => }/irqs-8x50.h (59%)
>  rename arch/arm/mach-msm/{include/mach => }/msm_gpiomux.h (100%)
>  rename arch/arm/mach-msm/{include/mach => }/msm_iomap-7x00.h (95%)
>  rename arch/arm/mach-msm/{include/mach => }/msm_iomap-7x30.h (97%)
>  rename arch/arm/mach-msm/{include/mach => }/msm_iomap-8x50.h (93%)
>  rename arch/arm/mach-msm/{include/mach => }/msm_iomap.h (74%)
>  create mode 100644 arch/arm/mach-msm/sirc.h
>  rename arch/arm/mach-msm/{include/mach => }/vreg.h (100%)
>  delete mode 100644 drivers/tty/serial/msm_serial_hs.c
>  rename {arch/arm/mach-msm/include/mach => include/linux}/msm_smd.h (100%)
>  delete mode 100644 include/linux/platform_data/msm_serial_hs.h
>
> --
> 2.1.0.rc2
>

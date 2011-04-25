From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:08:47 +0200
Subject: [PATCH 0/14] at91: factorize soc init and switch to early platform
Message-ID: <20110425180847.GA12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	The following patch series start to factorize the soc init
	and switch gpio and timers to early platform

	diff stat on arm

	80 files changed, 1690 insertions(+), 2053 deletions(-)

The following changes since commit b96406f91da18e62afe7f78ef3ef4f5804df6d2a:

  clkdev: add support to lookup for early platform device (2011-04-26 01:10:47 +0800)

are available in the git repository at:
  et ..BRANCH.NOT.VERIFIED..

Jean-Christophe PLAGNIOL-VILLARD (13):
      at91rm9200: introduce at91rm9200_set_type to specficy cpu package
      at91: introduce commom AT91_BASE_SYS
      at91: factorize at91 interrupts init to soc
      at91: use structure to store the current soc
      at91: switch to CLKDEV_LOOKUP
      at91: switch gpio to early platfrom device
      at91: move gpio to drivers/gpio
      at91: switch pit timer to early platform devices
      at91: switch st timer to early platform devices
      at91: move pit timer to drivers/clocksource
      at91: move st timer to drivers/clocksource
      at91: move register clocks to soc generic init
      at91: move clock subsystem init to soc generic init

Nico Erfurth (1):
      at91: merge board usb-a9260 and usb-a9263 together

 MAINTAINERS                                        |    2 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-at91/Kconfig                         |    8 +
 arch/arm/mach-at91/Makefile                        |   26 +-
 arch/arm/mach-at91/at572d940hf.c                   |  124 +++++---
 arch/arm/mach-at91/at572d940hf_devices.c           |   22 +-
 arch/arm/mach-at91/at91cap9.c                      |  125 +++++---
 arch/arm/mach-at91/at91cap9_devices.c              |   28 +-
 arch/arm/mach-at91/at91rm9200.c                    |  121 +++++---
 arch/arm/mach-at91/at91rm9200_devices.c            |   28 +-
 arch/arm/mach-at91/at91rm9200_time.c               |  209 ------------
 arch/arm/mach-at91/at91sam9260.c                   |  116 +++++---
 arch/arm/mach-at91/at91sam9260_devices.c           |   31 +--
 arch/arm/mach-at91/at91sam9261.c                   |  119 +++++---
 arch/arm/mach-at91/at91sam9261_devices.c           |   26 +-
 arch/arm/mach-at91/at91sam9263.c                   |  125 +++++---
 arch/arm/mach-at91/at91sam9263_devices.c           |   24 +-
 arch/arm/mach-at91/at91sam926x_time.c              |  188 -----------
 arch/arm/mach-at91/at91sam9g45.c                   |  154 ++++++----
 arch/arm/mach-at91/at91sam9g45_devices.c           |   31 +--
 arch/arm/mach-at91/at91sam9rl.c                    |  121 +++++---
 arch/arm/mach-at91/at91sam9rl_devices.c            |   27 +-
 arch/arm/mach-at91/at91x40.c                       |    5 -
 arch/arm/mach-at91/board-1arm.c                    |   10 +-
 arch/arm/mach-at91/board-afeb-9260v1.c             |    6 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c          |    6 +-
 arch/arm/mach-at91/board-cam60.c                   |    6 +-
 arch/arm/mach-at91/board-cap9adk.c                 |    6 +-
 arch/arm/mach-at91/board-carmeva.c                 |    6 +-
 arch/arm/mach-at91/board-cpu9krea.c                |    6 +-
 arch/arm/mach-at91/board-cpuat91.c                 |   10 +-
 arch/arm/mach-at91/board-csb337.c                  |    6 +-
 arch/arm/mach-at91/board-csb637.c                  |    6 +-
 arch/arm/mach-at91/board-eb9200.c                  |    6 +-
 arch/arm/mach-at91/board-ecbat91.c                 |   10 +-
 arch/arm/mach-at91/board-eco920.c                  |   11 +-
 arch/arm/mach-at91/board-flexibity.c               |    6 +-
 arch/arm/mach-at91/board-foxg20.c                  |    6 +-
 arch/arm/mach-at91/board-gsia18s.c                 |    4 +-
 arch/arm/mach-at91/board-kafa.c                    |   10 +-
 arch/arm/mach-at91/board-kb9202.c                  |   11 +-
 arch/arm/mach-at91/board-neocore926.c              |    6 +-
 arch/arm/mach-at91/board-pcontrol-g20.c            |    4 +-
 arch/arm/mach-at91/board-picotux200.c              |    6 +-
 arch/arm/mach-at91/board-qil-a9260.c               |    6 +-
 arch/arm/mach-at91/board-rm9200dk.c                |    6 +-
 arch/arm/mach-at91/board-rm9200ek.c                |    6 +-
 arch/arm/mach-at91/board-sam9-l9260.c              |    6 +-
 arch/arm/mach-at91/board-sam9260ek.c               |    6 +-
 arch/arm/mach-at91/board-sam9261ek.c               |    6 +-
 arch/arm/mach-at91/board-sam9263ek.c               |    6 +-
 arch/arm/mach-at91/board-sam9g20ek.c               |    8 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c            |    6 +-
 arch/arm/mach-at91/board-sam9rlek.c                |    6 +-
 arch/arm/mach-at91/board-snapper9260.c             |    6 +-
 arch/arm/mach-at91/board-stamp9g20.c               |    8 +-
 arch/arm/mach-at91/board-usb-a9260.c               |  236 --------------
 .../{board-usb-a9263.c => board-usb-a926x.c}       |   62 +++-
 arch/arm/mach-at91/board-yl-9200.c                 |   10 +-
 arch/arm/mach-at91/clock.c                         |   54 +---
 arch/arm/mach-at91/clock.h                         |   25 ++-
 arch/arm/mach-at91/cpu.h                           |  181 +++++++++++
 arch/arm/mach-at91/devices.c                       |   15 +
 arch/arm/mach-at91/devices.h                       |   55 ++++
 arch/arm/mach-at91/generic.h                       |   41 +--
 arch/arm/mach-at91/include/mach/at572d940hf.h      |    1 -
 arch/arm/mach-at91/include/mach/at91_pit.h         |    8 +-
 arch/arm/mach-at91/include/mach/at91_st.h          |   20 +-
 arch/arm/mach-at91/include/mach/at91cap9.h         |    1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h       |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h      |    1 -
 arch/arm/mach-at91/include/mach/at91sam9261.h      |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h      |    1 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h      |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h       |    1 -
 arch/arm/mach-at91/include/mach/clkdev.h           |    7 +
 arch/arm/mach-at91/include/mach/cpu.h              |  180 ++++-------
 arch/arm/mach-at91/include/mach/hardware.h         |   14 +
 arch/arm/mach-at91/soc.c                           |  281 +++++++++++++++++
 arch/arm/mach-at91/soc.h                           |   31 ++
 drivers/clocksource/Makefile                       |    2 +
 drivers/clocksource/at91_pit.c                     |  333 ++++++++++++++++++++
 drivers/gpio/Makefile                              |    1 +
 .../mach-at91/gpio.c => drivers/gpio/at91_gpio.c   |   78 +++--
 84 files changed, 2078 insertions(+), 1449 deletions(-)
 delete mode 100644 arch/arm/mach-at91/at91rm9200_time.c
 delete mode 100644 arch/arm/mach-at91/at91sam926x_time.c
 delete mode 100644 arch/arm/mach-at91/board-usb-a9260.c
 rename arch/arm/mach-at91/{board-usb-a9263.c => board-usb-a926x.c} (83%)
 create mode 100644 arch/arm/mach-at91/cpu.h
 create mode 100644 arch/arm/mach-at91/devices.c
 create mode 100644 arch/arm/mach-at91/devices.h
 create mode 100644 arch/arm/mach-at91/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 arch/arm/mach-at91/soc.h
 create mode 100644 drivers/clocksource/at91_pit.c
 rename arch/arm/mach-at91/gpio.c => drivers/gpio/at91_gpio.c (90%)

Best Regards,
J.

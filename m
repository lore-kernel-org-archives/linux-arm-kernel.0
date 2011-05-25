From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 25 May 2011 17:13:25 +0200
Subject: at91: pull request
Message-ID: <20110525151325.GL863@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

	It's the first pull request of consolidation on at91
	86 files changed, 776 insertions(+), 2998 deletions(-)

	for the tty we get the ack of alan

	I'm preparing a second one for laster this week with more
	consolidation but I need to test it on big range of boards first

Could you pull
The following changes since commit 4a7df24ddc7097cd789a7527187826552ea0765e:

  Merge branch 'for-linus/2640/i2c' of git://git.fluff.org/bjdooks/linux (2011-05-24 16:39:23 -0700)

are available in the git repository at:

  git at github.com:at91linux/linux-2.6-at91.git for-rmk

Jean-Christophe PLAGNIOL-VILLARD (11):
      at91: remove MTD_NAND_ATMEL_BUSWIDTH_16 option
      at91sam9263: merge all boards defconfig into only one
      at91sam9261: rename at91sam9261ek to at91sam9261 defconfig
      atmel_serial: keep the platform_device unchanged
      at91/board-eco920: remove at91_beeper ressource as no driver at91_beeper exist
      at91: fix map_io init usage
      at91: switch to CLKDEV_LOOKUP
      at91: factorize common irq ID
      at91: drop boot_params and PLAT_PHYS_OFFSET
      at91rm9200: introduce at91rm9200_set_type to specficy cpu package
      at91: drop at572d940hf support

 arch/arm/Kconfig                                   |    2 +
 arch/arm/configs/at572d940hfek_defconfig           |  358 --------
 ...91sam9261ek_defconfig => at91sam9261_defconfig} |   85 ++-
 ...91sam9263ek_defconfig => at91sam9263_defconfig} |   84 ++-
 arch/arm/configs/neocore926_defconfig              |  104 ---
 arch/arm/configs/usb-a9263_defconfig               |  106 ---
 arch/arm/mach-at91/Kconfig                         |   40 -
 arch/arm/mach-at91/Makefile                        |    4 -
 arch/arm/mach-at91/at572d940hf.c                   |  377 --------
 arch/arm/mach-at91/at572d940hf_devices.c           |  970 --------------------
 arch/arm/mach-at91/at91cap9.c                      |   41 +-
 arch/arm/mach-at91/at91cap9_devices.c              |   24 +-
 arch/arm/mach-at91/at91rm9200.c                    |   53 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |   24 +-
 arch/arm/mach-at91/at91sam9260.c                   |   48 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |   26 +-
 arch/arm/mach-at91/at91sam9261.c                   |   41 +-
 arch/arm/mach-at91/at91sam9261_devices.c           |   21 +-
 arch/arm/mach-at91/at91sam9263.c                   |   39 +-
 arch/arm/mach-at91/at91sam9263_devices.c           |   20 +-
 arch/arm/mach-at91/at91sam9g45.c                   |   64 +-
 arch/arm/mach-at91/at91sam9g45_devices.c           |   27 +-
 arch/arm/mach-at91/at91sam9rl.c                    |   40 +-
 arch/arm/mach-at91/at91sam9rl_devices.c            |   23 +-
 arch/arm/mach-at91/at91x40.c                       |    5 -
 arch/arm/mach-at91/board-1arm.c                    |   12 +-
 arch/arm/mach-at91/board-afeb-9260v1.c             |    6 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c          |  326 -------
 arch/arm/mach-at91/board-cam60.c                   |    6 +-
 arch/arm/mach-at91/board-cap9adk.c                 |   13 +-
 arch/arm/mach-at91/board-carmeva.c                 |    8 +-
 arch/arm/mach-at91/board-cpu9krea.c                |    6 +-
 arch/arm/mach-at91/board-cpuat91.c                 |   12 +-
 arch/arm/mach-at91/board-csb337.c                  |    8 +-
 arch/arm/mach-at91/board-csb637.c                  |    8 +-
 arch/arm/mach-at91/board-eb01.c                    |    4 +-
 arch/arm/mach-at91/board-eb9200.c                  |    8 +-
 arch/arm/mach-at91/board-ecbat91.c                 |   12 +-
 arch/arm/mach-at91/board-eco920.c                  |   32 +-
 arch/arm/mach-at91/board-flexibity.c               |    6 +-
 arch/arm/mach-at91/board-foxg20.c                  |    6 +-
 arch/arm/mach-at91/board-gsia18s.c                 |    8 +-
 arch/arm/mach-at91/board-kafa.c                    |   12 +-
 arch/arm/mach-at91/board-kb9202.c                  |   13 +-
 arch/arm/mach-at91/board-neocore926.c              |    6 +-
 arch/arm/mach-at91/board-pcontrol-g20.c            |    8 +-
 arch/arm/mach-at91/board-picotux200.c              |    8 +-
 arch/arm/mach-at91/board-qil-a9260.c               |    6 +-
 arch/arm/mach-at91/board-rm9200dk.c                |    8 +-
 arch/arm/mach-at91/board-rm9200ek.c                |    8 +-
 arch/arm/mach-at91/board-sam9-l9260.c              |    6 +-
 arch/arm/mach-at91/board-sam9260ek.c               |   13 +-
 arch/arm/mach-at91/board-sam9261ek.c               |   13 +-
 arch/arm/mach-at91/board-sam9263ek.c               |   13 +-
 arch/arm/mach-at91/board-sam9g20ek.c               |   17 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c            |   13 +-
 arch/arm/mach-at91/board-sam9rlek.c                |    6 +-
 arch/arm/mach-at91/board-snapper9260.c             |    6 +-
 arch/arm/mach-at91/board-stamp9g20.c               |   18 +-
 arch/arm/mach-at91/board-usb-a9260.c               |    6 +-
 arch/arm/mach-at91/board-usb-a9263.c               |    6 +-
 arch/arm/mach-at91/board-yl-9200.c                 |   12 +-
 arch/arm/mach-at91/clock.c                         |   69 +-
 arch/arm/mach-at91/clock.h                         |   20 +-
 arch/arm/mach-at91/generic.h                       |   30 +-
 arch/arm/mach-at91/include/mach/at572d940hf.h      |  123 ---
 .../mach-at91/include/mach/at572d940hf_matrix.h    |  123 ---
 arch/arm/mach-at91/include/mach/at91cap9.h         |    4 -
 arch/arm/mach-at91/include/mach/at91rm9200.h       |    2 -
 arch/arm/mach-at91/include/mach/at91sam9260.h      |    2 -
 arch/arm/mach-at91/include/mach/at91sam9261.h      |    2 -
 arch/arm/mach-at91/include/mach/at91sam9263.h      |    2 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h      |    4 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h       |    2 -
 arch/arm/mach-at91/include/mach/at91x40.h          |    2 -
 arch/arm/mach-at91/include/mach/board.h            |    6 +-
 arch/arm/mach-at91/include/mach/clkdev.h           |    7 +
 arch/arm/mach-at91/include/mach/cpu.h              |   15 +-
 arch/arm/mach-at91/include/mach/hardware.h         |   15 +-
 arch/arm/mach-at91/include/mach/memory.h           |    2 -
 arch/arm/mach-at91/include/mach/stamp9g20.h        |    2 +-
 arch/arm/mach-at91/include/mach/system_rev.h       |   25 +
 arch/arm/mach-at91/include/mach/timex.h            |    5 -
 arch/avr32/mach-at32ap/at32ap700x.c                |    4 +-
 arch/avr32/mach-at32ap/include/mach/board.h        |    1 +
 drivers/tty/serial/atmel_serial.c                  |    2 +-
 86 files changed, 776 insertions(+), 2998 deletions(-)
 delete mode 100644 arch/arm/configs/at572d940hfek_defconfig
 rename arch/arm/configs/{at91sam9261ek_defconfig => at91sam9261_defconfig} (53%)
 rename arch/arm/configs/{at91sam9263ek_defconfig => at91sam9263_defconfig} (57%)
 delete mode 100644 arch/arm/configs/neocore926_defconfig
 delete mode 100644 arch/arm/configs/usb-a9263_defconfig
 delete mode 100644 arch/arm/mach-at91/at572d940hf.c
 delete mode 100644 arch/arm/mach-at91/at572d940hf_devices.c
 delete mode 100644 arch/arm/mach-at91/board-at572d940hf_ek.c
 delete mode 100644 arch/arm/mach-at91/include/mach/at572d940hf.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at572d940hf_matrix.h
 create mode 100644 arch/arm/mach-at91/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-at91/include/mach/system_rev.h

Best Regards,
J.

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 23 Nov 2011 18:19:35 +0100
Subject: [AT91 PULL] gpio cleanup pull request for 3.3
Message-ID: <20111123171935.GC15531@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

	this pull containt the first patch series that rework the gpio to make it more standard
	and to allow the multi soc and simplify the adding of the DT
	
	this pull depends on previous one for the ioremaps
	
The following changes since commit 55c71f1a3e29cc7cd761a358deac96d3e952128f:

  ARM: at91: make rm9200 rtc drivers soc independent (2011-11-23 23:00:11 +0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.3-gpio

Jean-Christophe PLAGNIOL-VILLARD (12):
      ARM: at91: switch gpio clock to clkdev
      ARM: at91: gpio make struct at91_gpio_bank an initdata
      ARM: at91/boards: use -EINVAL for invalid gpio
      ARM: at91/soc: use gpio_is_valid to check the gpio
      ARM: at91/pata: use gpio_is_valid to check the gpio
      ARM: at91/ide: use gpio_is_valid to check the gpio
      ARM: at91/mmc: use gpio_is_valid to check the gpio
      ARM: at91/nand: use gpio_is_valid to check the gpio
      ARM: at91/ohci: use gpio_is_valid to check the gpio
      ARM: at91/udc: use gpio_is_valid to check the gpio
      ARM: at91/gpio: drop PIN_BASE
      ARM: at91/gpio: fix display of number of irq setuped

 arch/arm/mach-at91/at91cap9.c            |   10 +-
 arch/arm/mach-at91/at91cap9_devices.c    |   20 +-
 arch/arm/mach-at91/at91rm9200.c          |   10 +-
 arch/arm/mach-at91/at91rm9200_devices.c  |   22 +-
 arch/arm/mach-at91/at91sam9260.c         |    8 +-
 arch/arm/mach-at91/at91sam9260_devices.c |   26 ++--
 arch/arm/mach-at91/at91sam9261.c         |    8 +-
 arch/arm/mach-at91/at91sam9261_devices.c |   14 +-
 arch/arm/mach-at91/at91sam9263.c         |   12 +-
 arch/arm/mach-at91/at91sam9263_devices.c |   26 ++--
 arch/arm/mach-at91/at91sam9g45.c         |   12 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |   20 +-
 arch/arm/mach-at91/at91sam9rl.c          |   10 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |   16 +-
 arch/arm/mach-at91/board-1arm.c          |    2 +
 arch/arm/mach-at91/board-afeb-9260v1.c   |    8 +-
 arch/arm/mach-at91/board-cam60.c         |    4 +-
 arch/arm/mach-at91/board-cap9adk.c       |   15 +-
 arch/arm/mach-at91/board-carmeva.c       |    7 +-
 arch/arm/mach-at91/board-cpu9krea.c      |    8 +-
 arch/arm/mach-at91/board-cpuat91.c       |    5 +
 arch/arm/mach-at91/board-csb337.c        |    5 +-
 arch/arm/mach-at91/board-csb637.c        |    2 +
 arch/arm/mach-at91/board-dt.c            |    1 +
 arch/arm/mach-at91/board-eb9200.c        |    9 +-
 arch/arm/mach-at91/board-ecbat91.c       |    5 +
 arch/arm/mach-at91/board-eco920.c        |    5 +
 arch/arm/mach-at91/board-flexibity.c     |    5 +-
 arch/arm/mach-at91/board-foxg20.c        |    7 +-
 arch/arm/mach-at91/board-gsia18s.c       |    5 +-
 arch/arm/mach-at91/board-kafa.c          |    2 +
 arch/arm/mach-at91/board-kb9202.c        |    6 +-
 arch/arm/mach-at91/board-neocore926.c    |    5 +-
 arch/arm/mach-at91/board-pcontrol-g20.c  |    2 +
 arch/arm/mach-at91/board-picotux200.c    |    3 +
 arch/arm/mach-at91/board-qil-a9260.c     |   12 +-
 arch/arm/mach-at91/board-rm9200dk.c      |   11 +-
 arch/arm/mach-at91/board-rm9200ek.c      |    3 +
 arch/arm/mach-at91/board-rsi-ews.c       |    2 +
 arch/arm/mach-at91/board-sam9-l9260.c    |    8 +-
 arch/arm/mach-at91/board-sam9260ek.c     |   12 +-
 arch/arm/mach-at91/board-sam9261ek.c     |    9 +-
 arch/arm/mach-at91/board-sam9263ek.c     |    8 +-
 arch/arm/mach-at91/board-sam9g20ek.c     |    9 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c  |    4 +
 arch/arm/mach-at91/board-sam9rlek.c      |    7 +-
 arch/arm/mach-at91/board-snapper9260.c   |    6 +
 arch/arm/mach-at91/board-stamp9g20.c     |   12 +-
 arch/arm/mach-at91/board-usb-a926x.c     |    6 +-
 arch/arm/mach-at91/board-yl-9200.c       |    7 +-
 arch/arm/mach-at91/generic.h             |    1 -
 arch/arm/mach-at91/gpio.c                |   79 ++++----
 arch/arm/mach-at91/include/mach/board.h  |   30 ++--
 arch/arm/mach-at91/include/mach/gpio.h   |  328 +++++++++++++++---------------
 drivers/ata/pata_at91.c                  |    6 +-
 drivers/ide/at91_ide.c                   |    2 +-
 drivers/mmc/host/at91_mci.c              |   30 ++--
 drivers/mtd/nand/atmel_nand.c            |    8 +-
 drivers/usb/gadget/at91_udc.c            |   14 +-
 drivers/usb/host/ohci-at91.c             |   12 +-
 60 files changed, 542 insertions(+), 409 deletions(-)
 
Best Regards,
J.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/d6d18568/attachment.sig>

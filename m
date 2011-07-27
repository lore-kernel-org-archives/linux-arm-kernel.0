From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 27 Jul 2011 14:11:56 +0200
Subject: [PULL] at91 init factorize
Message-ID: <20110727121156.GK10037@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


	This patch series factorize the init of the at91 soc and start the
	work to make the at91 capable to choose the soc at runtime instead of
	compile time.

	The next work will be to factorize the device resource registration
	and then switch to the device tree

	please pull

The following changes since commit e371d46ae45488bcb112a99a7de462e9e3aa6764:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6 (2011-07-26 18:30:20 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-2.6-at91.git j/soc-detect

Jean-Christophe PLAGNIOL-VILLARD (8):
      at91: introduce commom AT91_BASE_SYS
      at91: factorize at91 interrupts init to soc
      at91: remove AT91_DBGU offset from dbgu register macro
      at91: use structure to store the current soc
      at91: move clock subsystem init to soc generic init
      at91: move register clocks to soc generic init
      at91: factorize sram init
      at91: add arch specific ioremap support

 arch/arm/mach-at91/Makefile                   |    2 +-
 arch/arm/mach-at91/at91cap9.c                 |   45 +---
 arch/arm/mach-at91/at91rm9200.c               |   47 +---
 arch/arm/mach-at91/at91sam9260.c              |  100 ++-------
 arch/arm/mach-at91/at91sam9261.c              |   62 +-----
 arch/arm/mach-at91/at91sam9263.c              |   51 +----
 arch/arm/mach-at91/at91sam9g45.c              |   45 +---
 arch/arm/mach-at91/at91sam9rl.c               |   59 +----
 arch/arm/mach-at91/board-1arm.c               |   11 +-
 arch/arm/mach-at91/board-afeb-9260v1.c        |   12 +-
 arch/arm/mach-at91/board-cam60.c              |   12 +-
 arch/arm/mach-at91/board-cap9adk.c            |   12 +-
 arch/arm/mach-at91/board-carmeva.c            |   11 +-
 arch/arm/mach-at91/board-cpu9krea.c           |   11 +-
 arch/arm/mach-at91/board-cpuat91.c            |   11 +-
 arch/arm/mach-at91/board-csb337.c             |   11 +-
 arch/arm/mach-at91/board-csb637.c             |   11 +-
 arch/arm/mach-at91/board-eb9200.c             |   11 +-
 arch/arm/mach-at91/board-ecbat91.c            |   11 +-
 arch/arm/mach-at91/board-eco920.c             |   11 +-
 arch/arm/mach-at91/board-flexibity.c          |   11 +-
 arch/arm/mach-at91/board-foxg20.c             |   12 +-
 arch/arm/mach-at91/board-gsia18s.c            |    9 +-
 arch/arm/mach-at91/board-kafa.c               |   11 +-
 arch/arm/mach-at91/board-kb9202.c             |   11 +-
 arch/arm/mach-at91/board-neocore926.c         |   12 +-
 arch/arm/mach-at91/board-pcontrol-g20.c       |   11 +-
 arch/arm/mach-at91/board-picotux200.c         |   11 +-
 arch/arm/mach-at91/board-qil-a9260.c          |   12 +-
 arch/arm/mach-at91/board-rm9200dk.c           |   11 +-
 arch/arm/mach-at91/board-rm9200ek.c           |   11 +-
 arch/arm/mach-at91/board-sam9-l9260.c         |   12 +-
 arch/arm/mach-at91/board-sam9260ek.c          |   12 +-
 arch/arm/mach-at91/board-sam9261ek.c          |   12 +-
 arch/arm/mach-at91/board-sam9263ek.c          |   12 +-
 arch/arm/mach-at91/board-sam9g20ek.c          |   16 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c       |   12 +-
 arch/arm/mach-at91/board-sam9rlek.c           |   12 +-
 arch/arm/mach-at91/board-snapper9260.c        |   11 +-
 arch/arm/mach-at91/board-stamp9g20.c          |   16 +-
 arch/arm/mach-at91/board-usb-a9260.c          |   12 +-
 arch/arm/mach-at91/board-usb-a9263.c          |   12 +-
 arch/arm/mach-at91/board-yl-9200.c            |   12 +-
 arch/arm/mach-at91/generic.h                  |   34 +--
 arch/arm/mach-at91/include/mach/at91_dbgu.h   |   27 ++-
 arch/arm/mach-at91/include/mach/at91cap9.h    |    1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9261.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    1 -
 arch/arm/mach-at91/include/mach/cpu.h         |  159 ++++++++------
 arch/arm/mach-at91/include/mach/debug-macro.S |   14 +-
 arch/arm/mach-at91/include/mach/hardware.h    |   14 ++
 arch/arm/mach-at91/include/mach/io.h          |   16 ++-
 arch/arm/mach-at91/setup.c                    |  297 +++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h                      |   59 +++++
 58 files changed, 701 insertions(+), 745 deletions(-)
 create mode 100644 arch/arm/mach-at91/setup.c
 create mode 100644 arch/arm/mach-at91/soc.h

Best Regards,
J.

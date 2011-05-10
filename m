From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:27:30 +0200
Subject: AT91: soc init factorisation and fix
Message-ID: <20110510162730.GA18929@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	The following patch series fatorize the soc init and fix the ioremap
	by detecting the cpu type

	we do not increse the number of ligne of code

The following changes since commit bad3db778f4ea5b41690400ce5bfff262a1d9775:

  at91: drop boot_params and PLAT_PHYS_OFFSET (2011-05-09 02:48:06 +0800)

are available in the git repository at:
  git at github.com:at91linux/linux-2.6-at91.git j-devel

Jean-Christophe PLAGNIOL-VILLARD (9):
      at91rm9200: introduce at91rm9200_set_type to specficy cpu package
      at91: introduce commom AT91_BASE_SYS
      at91: factorize at91 interrupts init to soc
      at91: remove AT91_DBGU offset from dbgu register macro
      at91: use structure to store the current soc
      at91: move clock subsystem init to soc generic init
      at91: move register clocks to soc generic init
      at91: factorize sram init
      at91: add arch specific ioremap support

 arch/arm/mach-at91/Makefile                   |    2 +-
 arch/arm/mach-at91/at572d940hf.c              |   46 +---
 arch/arm/mach-at91/at91cap9.c                 |   45 +---
 arch/arm/mach-at91/at91rm9200.c               |   44 +---
 arch/arm/mach-at91/at91sam9260.c              |  100 ++-------
 arch/arm/mach-at91/at91sam9261.c              |   62 +-----
 arch/arm/mach-at91/at91sam9263.c              |   51 +----
 arch/arm/mach-at91/at91sam9g45.c              |   45 +---
 arch/arm/mach-at91/at91sam9rl.c               |   59 +----
 arch/arm/mach-at91/board-1arm.c               |   15 +-
 arch/arm/mach-at91/board-afeb-9260v1.c        |   12 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c     |   12 +-
 arch/arm/mach-at91/board-cam60.c              |   12 +-
 arch/arm/mach-at91/board-cap9adk.c            |   12 +-
 arch/arm/mach-at91/board-carmeva.c            |   11 +-
 arch/arm/mach-at91/board-cpu9krea.c           |   11 +-
 arch/arm/mach-at91/board-cpuat91.c            |   15 +-
 arch/arm/mach-at91/board-csb337.c             |   11 +-
 arch/arm/mach-at91/board-csb637.c             |   11 +-
 arch/arm/mach-at91/board-eb9200.c             |   11 +-
 arch/arm/mach-at91/board-ecbat91.c            |   15 +-
 arch/arm/mach-at91/board-eco920.c             |   16 +-
 arch/arm/mach-at91/board-flexibity.c          |   11 +-
 arch/arm/mach-at91/board-foxg20.c             |   12 +-
 arch/arm/mach-at91/board-gsia18s.c            |    7 +-
 arch/arm/mach-at91/board-kafa.c               |   15 +-
 arch/arm/mach-at91/board-kb9202.c             |   16 +-
 arch/arm/mach-at91/board-neocore926.c         |   12 +-
 arch/arm/mach-at91/board-pcontrol-g20.c       |    9 +-
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
 arch/arm/mach-at91/board-stamp9g20.c          |   12 +-
 arch/arm/mach-at91/board-usb-a9260.c          |   12 +-
 arch/arm/mach-at91/board-usb-a9263.c          |   12 +-
 arch/arm/mach-at91/board-yl-9200.c            |   16 +-
 arch/arm/mach-at91/generic.h                  |   36 +--
 arch/arm/mach-at91/include/mach/at572d940hf.h |    1 -
 arch/arm/mach-at91/include/mach/at91_dbgu.h   |   27 ++-
 arch/arm/mach-at91/include/mach/at91cap9.h    |    1 -
 arch/arm/mach-at91/include/mach/at91rm9200.h  |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9261.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    1 -
 arch/arm/mach-at91/include/mach/cpu.h         |  162 ++++++++------
 arch/arm/mach-at91/include/mach/debug-macro.S |   14 +-
 arch/arm/mach-at91/include/mach/hardware.h    |   14 ++
 arch/arm/mach-at91/include/mach/io.h          |   16 ++-
 arch/arm/mach-at91/setup.c                    |  301 +++++++++++++++++++++++++
 arch/arm/mach-at91/soc.h                      |   61 +++++
 61 files changed, 752 insertions(+), 783 deletions(-)
 create mode 100644 arch/arm/mach-at91/setup.c
 create mode 100644 arch/arm/mach-at91/soc.h


Best Regards,
J.

From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  3 May 2011 12:03:14 +1200
Subject: [PATCH V4 00/23] Create common framework for AT91 device
	initialisation
Message-ID: <1304381017-17912-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each AT91 variant (AT91RM9200, AT91SAM9260, etc) currently has its own
devices file, which includes the MMIO address, interrupt
configuration, GPIO setup, etc for each device. This results in a large
amount of duplicated code.

This patch set introduces a framework for adding shared devices for the
AT91 platform and replaces the multiple device setup implementations for
each device with single implementations in the new framework. This has
a net reduction of over 5000 lines of code.

Each of the arch/arm/mach-at91/*_devices.c files becomes a collection of
structures (with some initialisation callbacks where necessary) with a
table of devices which are present on the particular AT91 variant. All
structures/functions are marked as __init/__initdata so there is little
additional memory overhead. This also means that the #ifdefs around each
device can be removed from the *_devices.c files (but remain in the new
common devices.c file) without overhead.

This is also a step towards allowing more than one AT91 variant to be
built into a single kernel by removing duplicate function names across
the *_devices.c files.

I have build tested the patch series for all of the  AT91 variants 
and devices, and have boot tested it on the AT91SAM9G20 (Snapper 9G20
board) and tested basic device functionality.

Changes from v1:
 - Moved __initdata to the end of lines
 - Fixed at572d940hf EMAC MMIO base
 - Fixed some whitespace issues

Changes from v2:
 - Renamed UART identifiers from AT91_ID_USx to AT91_UART_USx. The
   AT91_UARTx names are already in use. See patch 12 for more details.
 - Removed some left over debugging.

Changes from v3:
 - Made resource/data allocation dynamic to remove all of the near
   empty static declarations.
 - Use arrays when multiple devices exist to reduce code complexity
 - Fixed indendation on some structures and initialisers 
 - Fixed some additional bugs
 - Now removes over 5000 lines of code :-)

Ryan Mallon (23):
  at91: Add common devices framework
  at91: Make Ethernet device common
  at91: Make USB OHCI/EHCI devices common
  at91: Make UDC device common
  at91: Make MMC device common
  at91: Make NAND device common
  at91: Make TWI device common
  at91: Make SPI device common
  at91: Make TCB device common
  at91: Make RTT device common
  at91: Make watchdog device common
  at91: Make UART devices common
  at91: Make PWM device common
  at91: Make SSC device common
  at91: Make AC97 device common
  at91: Make LCD controller device common
  at91: Make touchscreen device common
  at91: Make HDMAC device common
  at91: Make RTC device common
  at91: Make high speed USB gadget device common
  at91: Make compact flash device common
  at91: Move at91sam9263 CAN device to common devices
  at91: Remove mAgic and ISI device code

 arch/arm/mach-at91/Makefile               |    2 +-
 arch/arm/mach-at91/at572d940hf.c          |    4 +
 arch/arm/mach-at91/at572d940hf_devices.c  | 1022 +++--------------
 arch/arm/mach-at91/at91cap9.c             |    4 +
 arch/arm/mach-at91/at91cap9_devices.c     | 1411 +++++------------------
 arch/arm/mach-at91/at91rm9200.c           |    4 +
 arch/arm/mach-at91/at91rm9200_devices.c   | 1321 +++++-----------------
 arch/arm/mach-at91/at91sam9260.c          |    4 +
 arch/arm/mach-at91/at91sam9260_devices.c  | 1471 +++++--------------------
 arch/arm/mach-at91/at91sam9261.c          |    4 +
 arch/arm/mach-at91/at91sam9261_devices.c  | 1172 ++++---------------
 arch/arm/mach-at91/at91sam9263.c          |    4 +
 arch/arm/mach-at91/at91sam9263_devices.c  | 1589 +++++---------------------
 arch/arm/mach-at91/at91sam9g45.c          |    4 +
 arch/arm/mach-at91/at91sam9g45_devices.c  | 1779 ++++++-----------------------
 arch/arm/mach-at91/at91sam9rl.c           |    4 +
 arch/arm/mach-at91/at91sam9rl_devices.c   | 1332 ++++------------------
 arch/arm/mach-at91/board-1arm.c           |    6 +-
 arch/arm/mach-at91/board-afeb-9260v1.c    |   10 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c |   12 +-
 arch/arm/mach-at91/board-cam60.c          |    2 +-
 arch/arm/mach-at91/board-cap9adk.c        |    4 +-
 arch/arm/mach-at91/board-carmeva.c        |    6 +-
 arch/arm/mach-at91/board-cpu9krea.c       |   16 +-
 arch/arm/mach-at91/board-cpuat91.c        |   12 +-
 arch/arm/mach-at91/board-csb337.c         |    4 +-
 arch/arm/mach-at91/board-csb637.c         |    4 +-
 arch/arm/mach-at91/board-eb9200.c         |    8 +-
 arch/arm/mach-at91/board-ecbat91.c        |    6 +-
 arch/arm/mach-at91/board-eco920.c         |    2 +-
 arch/arm/mach-at91/board-flexibity.c      |    2 +-
 arch/arm/mach-at91/board-foxg20.c         |   16 +-
 arch/arm/mach-at91/board-gsia18s.c        |   14 +-
 arch/arm/mach-at91/board-kafa.c           |    6 +-
 arch/arm/mach-at91/board-kb9202.c         |   10 +-
 arch/arm/mach-at91/board-neocore926.c     |    6 +-
 arch/arm/mach-at91/board-pcontrol-g20.c   |   10 +-
 arch/arm/mach-at91/board-picotux200.c     |    6 +-
 arch/arm/mach-at91/board-qil-a9260.c      |   10 +-
 arch/arm/mach-at91/board-rm9200dk.c       |    6 +-
 arch/arm/mach-at91/board-rm9200ek.c       |    6 +-
 arch/arm/mach-at91/board-sam9-l9260.c     |    8 +-
 arch/arm/mach-at91/board-sam9260ek.c      |   10 +-
 arch/arm/mach-at91/board-sam9261ek.c      |    6 +-
 arch/arm/mach-at91/board-sam9263ek.c      |    6 +-
 arch/arm/mach-at91/board-sam9g20ek.c      |   10 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c       |    4 +-
 arch/arm/mach-at91/board-snapper9260.c    |   14 +-
 arch/arm/mach-at91/board-stamp9g20.c      |   20 +-
 arch/arm/mach-at91/board-usb-a9260.c      |    4 +-
 arch/arm/mach-at91/board-usb-a9263.c      |    4 +-
 arch/arm/mach-at91/board-yl-9200.c        |   10 +-
 arch/arm/mach-at91/devices.c              | 1432 +++++++++++++++++++++++
 arch/arm/mach-at91/devices.h              |  237 ++++
 arch/arm/mach-at91/include/mach/board.h   |   21 +-
 56 files changed, 3913 insertions(+), 9190 deletions(-)
 create mode 100644 arch/arm/mach-at91/devices.c
 create mode 100644 arch/arm/mach-at91/devices.h

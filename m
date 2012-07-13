From: y@pengutronix.de (y at pengutronix.de)
Date: Fri, 13 Jul 2012 14:32:02 +0200
Subject: [PATCH 00/11] make struct of_device_id.data const
Message-ID: <1342182734-321-1-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Hello,

this series' goal is to make struct of_device_id.data const.
Conceptually a driver must not modify the data contained there so making
it const is the right thing.

This change might introduce warnings because drivers don't use const to
access the data pointed to by of_device_id.data. In most cases the fix
is to add some consts.

This series (apart from adding this const in patch 10) fixes all drivers
covered by all arm defconfigs (based on v3.5-rc6).

There is one exception though:
drivers/regulator/twl-regulator.c (build in omap2plus_defconfig) now
issues:

	drivers/regulator/twl-regulator.c: In function 'twlreg_probe':
	drivers/regulator/twl-regulator.c:1181: warning: assignment discards qualifiers from pointer target type
	drivers/regulator/twl-regulator.c:1190: warning: assignment discards qualifiers from pointer target type

that is because this driver really modifies his .of_match_table in the
precence of a traditionally probed device.
I didn't check deeply, but probably the easiest fix is to remove
traditional platform support. Don't know if omap is ready for that
though.

And also patch 11 adds some more consts that are possible now after
patch 10.

This series is available in my git tree at:

	git://git.pengutronix.de/git/ukl/linux.git ofdeviceiddata

Best regards
Uwe

Uwe Kleine-K?nig (11):
  spi/imx: make spi_imx_data.devtype_data member point to const data
  serial/imx: make imx_port.devdata member point to const data
  ARM: cache-l2x0: add a const qualifier
  misc/atmel_tc: make atmel_tc.tcb_config member point to const data
  gpio/gpio-omap.c: add a const qualifier
  i2c/i2c-omap: add a const qualifier
  dmaengine: at_hdmac: add a few const qualifiers
  spi/spi-omap2-mcspi: add a const qualifier
  mmc/omap_hsmmc: add a const qualifier
  of: add const to struct of_device_id.data
  gpio/gpio-omap: make platformdata used as of_device_id.data const

 arch/arm/mm/cache-l2x0.c        |    2 +-
 drivers/dma/at_hdmac.c          |    4 ++--
 drivers/gpio/gpio-omap.c        |    8 ++++----
 drivers/i2c/busses/i2c-omap.c   |    3 ++-
 drivers/mmc/host/omap_hsmmc.c   |    2 +-
 drivers/spi/spi-imx.c           |    2 +-
 drivers/spi/spi-omap2-mcspi.c   |    2 +-
 drivers/tty/serial/imx.c        |    2 +-
 include/linux/atmel_tc.h        |    2 +-
 include/linux/mod_devicetable.h |    2 +-
 10 files changed, 15 insertions(+), 14 deletions(-)

-- 
1.7.10.4

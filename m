From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sat, 24 Dec 2011 00:12:20 +0100
Subject: [PATCH 0/4] Amstrad Delta: access MODEM_RESET GPIO pin over a
 regulator
Message-ID: <1324681944-19067-1-git-send-email-jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amstrad Delta on-board latch2 bit named MODEM_NRESET, now available
as a GPIO pin AMS_DELTA_GPIO_PIN_NMODEM_RESET, is used to power up/down
(bring into/out of a reset state) two distinct on-board devices
simultaneously: the modem, and the voice codec. As a consequence, that
bit is, or can be, manipulated concurrently by two drivers, or their
platform provided hooks.

Instead of updating those drivers to use the gpiolib API as a new method
of controlling the MODEM_NRESET pin state, like it was done to other
drivers accessing latch2 pins, and still being vulnerable to potential
concurrency conflicts, or trying to solve that sharing issue with a
custom piece of code, set up a fixed regulator device on top of that
GPIO pin and update both drivers to manipulate that regulator, not the
GPIO pin directly.

Janusz Krzysztofik (4):
  ARM: OMAP1: ams-delta: set up regulator over modem reset GPIO pin
  ASoC: cx20442: add bias control over a platform provided regulator
  ARM: OMAP1: ams-delta: update the modem to use regulator API
  ASoC: OMAP: ams-delta: drop .set_bias_level callback

 arch/arm/mach-omap1/Kconfig                       |    2 +
 arch/arm/mach-omap1/board-ams-delta.c             |  116 +++++++++++++++++++--
 arch/arm/plat-omap/include/plat/board-ams-delta.h |    1 -
 sound/soc/codecs/cx20442.c                        |   58 ++++++++++-
 sound/soc/omap/ams-delta.c                        |   34 ------
 5 files changed, 165 insertions(+), 46 deletions(-)

-- 
1.7.3.4

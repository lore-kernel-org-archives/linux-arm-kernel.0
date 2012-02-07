From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue,  7 Feb 2012 20:11:16 +0100
Subject: [RESUBMIT][PATCH v2 0/4] Amstrad Delta: access MODEM_RESET GPIO pin
 over a regulator
Message-ID: <1328641879-18884-1-git-send-email-jkrzyszt@tis.icnet.pl>
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

I'm resubmitting v2 of this series, originally posted on 30 Dec 2011,
with Mark's Ack already collected, now rebased on top of current
linux-omap/omap1 tip, commit 967809bd7faf71ddc29c8081e0f21db8b201a0f4.

Since patch 2/4, "ASoC: cx20442: add bias control over a platform
provided regulator", has already been applied by Liam (thanks!) and is
already present in mainline, I've omitted it from this submission.

v2 changes against initial version:
* in both the codec and the modem callbacks, don't track the regulator
  enable/disable state, compare new target bias level (the codec case)
  or power state (the modem case) with the old value instead; thanks to
  Mark Brown who suggested this solution,
* a few other minor changes, mostly stylistic.

Janusz Krzysztofik (3):
  ARM: OMAP1: ams-delta: set up regulator over modem reset GPIO pin
  ARM: OMAP1: ams-delta: update the modem to use regulator API
  ASoC: OMAP: ams-delta: drop .set_bias_level callback

 arch/arm/mach-omap1/Kconfig                       |    2 +
 arch/arm/mach-omap1/board-ams-delta.c             |   94 +++++++++++++++++++--
 arch/arm/plat-omap/include/plat/board-ams-delta.h |    1 -
 sound/soc/omap/ams-delta.c                        |   32 -------
 4 files changed, 87 insertions(+), 42 deletions(-)

-- 
1.7.3.4

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 25 Oct 2016 11:37:57 +0200
Subject: [PATCH v3 0/2] ARM: at91: properly handle LPDDR poweroff
Message-ID: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set improves LPDDR support on SoCs using the Atmel MPDDR controller.

LPDDR memories can only handle up to 400 uncontrolled power offs in their
life. The proper power off sequence has to be applied before shutting down the
SoC.

I'm not too happy with the code duplication but this is a design choice
that has been made before because both shutdown controllers are really
different apart from the shutdown itself.

I guess it is still better than slowly killing the LPDDR.

Changes in v3:
 - removed COMPILE_TEST for sama5d2_shdwc as it is now ARM specific

Changes in v2:
 - Fix typos
 - Add a comment for the dummy read access of AT91_SHDW_CR
 - Properly set up pm_power_off in at91_poweroff_probe()


Alexandre Belloni (2):
  ARM: at91: define LPDDR types
  power/reset: at91-poweroff: timely shutdown LPDDR memories

 drivers/power/reset/Kconfig              |  2 +-
 drivers/power/reset/at91-poweroff.c      | 54 +++++++++++++++++++++++++++++++-
 drivers/power/reset/at91-sama5d2_shdwc.c | 49 ++++++++++++++++++++++++++++-
 include/soc/at91/at91sam9_ddrsdr.h       |  3 ++
 4 files changed, 105 insertions(+), 3 deletions(-)

-- 
2.9.3

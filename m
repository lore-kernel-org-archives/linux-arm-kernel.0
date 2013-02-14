From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 14 Feb 2013 09:14:22 +0100
Subject: [PATCH v9 0/8] watchdog: dt: add support for the timeout-sec dt
 property
Message-ID: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
to the at91sam9_wdt driver and on all framework enabled watchdog driver
with dt support.
The at91sam9_wdt is tested on evk-pr3,
the other drivers are compile tested only.

Hi Wim,
because the first two patches are fixes for the
patch 433bf8dc344c0eacb3ff5bbc1aea42f75b170a72 already included in 
watchdog-next feel free to squash them.

Best regards
Fabio Porcedda

changes:
v9:
  - rebase over watchdog-next, so remove first and second patch and
    add two commit to fix the commit already present in watchdog-next
  - add a commit for fixing coding style
v8:
  - watchdog_is_valid_timeout(): export in watchdog.h
  - watchdog_is_valid_timeout(): use in watchdog_set_timeout()
  - watchdog_is_valid_timeout(): split patch
  - watchdog_init_timeout(): return -EINVAL for out of range values.
  - watchdog_init_timeout(): use struct device instead of struct device_node
v7:
  - rebase over v3.8-rc2
  - remove the patch already merged
v6:
  - remove patch for function of_get_timeout_sec as aked by Rob Herring
  - add Acked-by: Jason Cooper <jason@lakedaemon.net>
  - add Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
v5:
  - fix codestyle for compilance ti checkpatch.pl about
    "ERROR: do not initialise statics to 0 or NULL"
    for s3c2410_wdt.c:56 and at91sam9_wdt.c:63
v4:
  - add of_get_timeout_sec
  - add s3c2410_wdt driver
  - split driver patch
  - fixed watchdog_init_timeout handling of min_timeout and max_timeout
v3:
  - rename watchdog_probe_dt_timeout ->  watchdog_init_timeout
  - move the watchdog_init_timeout function from inline to watchdog_core.c
  - add timeout parameter handling code to watchdog_init_timeout
  - add timeout-sec property to the pnx4008-wdt driver
  - add two small commit for fixup and cleanup
v2:
  - change "timeout" to "timeout-sec" as asked by Jean-Christophe
  - at91sam9_wdt: use the new helper function
  - at91sam9_wdt: add bounds checking
  - watchdog.h: add bounds checking

Fabio Porcedda (8):
  watchdog: core: add static to watchdog_check_min_max_timeout()
  watchdog: core: fix watchdog_check_min_max_timeout() return value
  watchdog: orion_wdt: add timeout-sec property binding
  watchdog: pnx4008: add timeout-sec property binding
  watchdog: s3c2410_wdt: add timeout-sec property binding
  watchdog: at91sam9_wdt: add timeout-sec property binding
  watchdog: orion_wdt: move the min_timeout initialization
  watchdog: code: fix the alignement of some function declarations

 .../devicetree/bindings/watchdog/atmel-wdt.txt          |  4 ++++
 Documentation/devicetree/bindings/watchdog/marvel.txt   |  5 +++++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt        |  4 ++++
 .../devicetree/bindings/watchdog/samsung-wdt.txt        |  3 +++
 drivers/watchdog/Kconfig                                |  1 +
 drivers/watchdog/at91sam9_wdt.c                         | 16 +++++++++++++---
 drivers/watchdog/orion_wdt.c                            | 10 ++++------
 drivers/watchdog/pnx4008_wdt.c                          |  7 +++----
 drivers/watchdog/s3c2410_wdt.c                          |  6 ++++--
 drivers/watchdog/watchdog_core.c                        | 16 +++++++++++-----
 drivers/watchdog/watchdog_dev.c                         | 17 ++++++-----------
 11 files changed, 58 insertions(+), 31 deletions(-)

-- 
1.8.1.1

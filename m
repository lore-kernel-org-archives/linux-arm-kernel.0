From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Thu, 1 Mar 2012 04:14:20 +0530
Subject: [PATCH v2 0/9] gpio/omap: Some more driver cleanup and fixes
Message-ID: <1330555469-21260-1-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
as we already have them as part of bank->context now. Also, remove un-used
variable from gpio_irq_handler.

The fix include correction of _set_gpio_irqenable() implementation and fix
type mismatch of gpio trigger parameter.

It is baselined on top of Kevin's following series:
gpio/omap: cleanup and runtime PM conversion for v3.4
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup

Series is available here for reference:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_further_cleanup_fixes

Power Test: Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
Functional Test: OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLAZE

v2:
- Added a new patch to update wakeup_en register in _set_gpio_wakeup()
  in addition to updating bank->context.wake_en.

- Added a new patch to remove redundant decoding of gpio offset in
  gpio_get(), _get_gpio_datain() and _get_gpio_dataout().

- Added a new patch to remove suspend/resume callbacks because the
  operations performed with the callbacks are redundant.

Tarun Kanti DebBarma (9):
  gpio/omap: remove saved_fallingdetect, saved_risingdetect fields
  gpio/omap: fix wakeup_en register update in _set_gpio_wakeup()
  gpio/omap: remove suspend_wakeup field from struct gpio_bank
  gpio/omap: remove saved_wakeup field from struct gpio_bank
  gpio/omap: get rid of retrigger variable in gpio_irq_handler
  gpio/omap: fix trigger type to unsigned
  gpio/omap: fix _set_gpio_irqenable implementation
  gpio/omap: remove redundant decoding of gpio offset
  gpio/omap: remove suspend/resume callbacks

 drivers/gpio/gpio-omap.c |  113 +++++++++++-----------------------------------
 1 files changed, 27 insertions(+), 86 deletions(-)

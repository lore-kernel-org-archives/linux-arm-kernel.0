From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Apr 2016 21:17:20 +0200
Subject: [PATCH v5 00/24] pwm: add support for atomic update
Message-ID: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for atomic PWM update, or IOW, the capability
to update all the parameters of a PWM device (enabled/disabled, period,
duty and polarity) in one go.

It also adds support for initial PWM state retrieval (or hardware
readout), which should allow smooth handover between the bootloader and
Linux. For example, critical PWM users (like critical regulators
controlled by a PWM) can query the current PWM state, and adapt the PWM
config without having to disable/enable the PWM, or abruptly change the
period/dutycyle/polarity config.

In this version, I dropped all patches converting PWM users and PWM
drivers to the atomic API in order to limit the number of patches and
ease review. I plan to send the remaining patches once these ones have
been accepted.

If you want to test the series, or see the big picture, you can have a
look at this branch [1].

Best Regards,

Boris

[1]https://github.com/bbrezillon/linux-rk/tree/atomic-pwm

Changes since v5:
- fix bugs in pwm_apply_state() implementation
- drop already applied patches
- s/pstate/state/
- add pwm_apply_args() helper
- limit the series to core changes and required changes in PWM users code

Changes since v4:
- introduce pwm_args to expose per-board/platform config
- deprecate non-atomic APIs
- implement non-atomic functions as wrappers around atomic ones
- patch all PWM users to use the atomic API
- rename the ->reset_state() hook into ->get_state()
- drop most acks
- rework PWM config in the pwm-regulator driver
- patch sun4i and sti PWM drivers to support HW readout

Changes since v3:
- rebased on pwm/for-next after pulling 4.4-rc1
- replace direct access to pwm fields by pwm_get/set_xxx() helpers, thus
  fixing some build errors
- split changes to allow each maintainer to review/ack or take the
  modification through its subsystem

Changes since v2:
- rebased on top of 4.3-rc2
- reintroduced pwm-regulator patches

Changes since v1:
- dropped applied patches
- squashed Heiko's fixes into the rockchip driver changes
- made a few cosmetic changes
- added kerneldoc comments
- added Heiko's patch to display more information in debugfs
- dropped pwm-regulator patches (should be submitted separately)

Boris Brezillon (23):
  pwm: introduce the pwm_args concept
  pwm: use pwm_get/set_xxx() helpers where appropriate
  clk: pwm: use pwm_get_args() where appropriate
  hwmon: pwm-fan: use pwm_get_args() where appropriate
  input: misc: max77693: use pwm_get_args() where appropriate
  leds: pwm: use pwm_get_args() where appropriate
  regulator: pwm: use pwm_get_args() where appropriate
  fbdev: ssd1307fb: use pwm_get_args() where appropriate
  backlight: pwm_bl: use pwm_get_args() where appropriate
  backlight: lp8788: explicitly apply PWM config extracted from pwm_args
  backlight: lp855x: explicitly apply PWM config extracted from pwm_args
  backlight: lm3630a: explicitly apply PWM config extracted from
    pwm_args
  input: misc: max8997: explicitly apply PWM config extracted from
    pwm_args
  input: misc: pwm-beeper: explicitly apply PWM config extracted from
    pwm_args
  drm: i915: explicitly apply PWM config extracted from pwm_args
  ARM: explicitly apply PWM config extracted from pwm_args
  pwm: keep PWM state in sync with hardware state
  pwm: introduce the pwm_state concept
  pwm: move the enabled/disabled info into pwm_state
  pwm: add the PWM initial state retrieval infra
  pwm: add the core infrastructure to allow atomic update
  pwm: update documentation
  pwm: switch to the atomic API

Heiko St?bner (1):
  pwm: add information about polarity, duty cycle and period to debugfs

 Documentation/pwm.txt                |  30 +++-
 arch/arm/mach-s3c24xx/mach-rx1950.c  |   6 +
 drivers/clk/clk-pwm.c                |  17 +-
 drivers/gpu/drm/i915/intel_panel.c   |   6 +
 drivers/hwmon/pwm-fan.c              |  26 ++-
 drivers/input/misc/max77693-haptic.c |  17 +-
 drivers/input/misc/max8997_haptic.c  |   6 +
 drivers/input/misc/pwm-beeper.c      |   6 +
 drivers/leds/leds-pwm.c              |  11 +-
 drivers/pwm/core.c                   | 214 ++++++++++++++--------
 drivers/pwm/pwm-clps711x.c           |   2 +-
 drivers/pwm/pwm-crc.c                |   2 +-
 drivers/pwm/pwm-lpc18xx-sct.c        |   2 +-
 drivers/pwm/pwm-omap-dmtimer.c       |   2 +-
 drivers/pwm/pwm-pxa.c                |   2 +-
 drivers/pwm/pwm-sun4i.c              |   3 +-
 drivers/pwm/sysfs.c                  |  61 ++++---
 drivers/regulator/pwm-regulator.c    |  20 ++-
 drivers/video/backlight/lm3630a_bl.c |   6 +
 drivers/video/backlight/lp855x_bl.c  |   6 +
 drivers/video/backlight/lp8788_bl.c  |   6 +
 drivers/video/backlight/pwm_bl.c     |  10 +-
 drivers/video/fbdev/ssd1307fb.c      |  11 +-
 include/linux/pwm.h                  | 335 +++++++++++++++++++++++++++--------
 24 files changed, 606 insertions(+), 201 deletions(-)

-- 
2.5.0

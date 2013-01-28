From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 28 Jan 2013 15:00:56 +0100
Subject: [PATCH v3 0/3] leds-pwm: Defer PWM calls if PWM can sleep
Message-ID: <1359381659-24454-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When using the leds-pwm module with external PWM chips connected through
I2C, the kernel will panic when settings a trigger. In this case, PWM
calls can sleep, and should be deferred.

Patch 1 and 2 add the necessary API to the PWM subsystem, and update
matching drivers. Patch 3 updates leds-pwm to use a worker if the PWM
chip can sleep, or performs direct calls otherwise.

This patchset is based on the for-next branch of the led subsystem [1],
as patch 3 depends on the recent work of Peter for DT bindings in leds-pwm.
The pwm patches should probably follow the same path.

Tested on Overo (OMAP3 + TWL4030) with device tree.

Best regards,

Florian

[1] git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/linux-leds.git

Changes from v2:
* pwm_cansleep -> pwm_can_sleep
* use bool for can_sleep member
* minor fixes

Changes from v1:
* pwm_can_sleep -> pwm_cansleep
* avoid duplicated code between the worker and the direct call
* cache the value of pwm_cansleep inside leds-pwm to avoid API calls

Florian Vaussard (3):
  pwm: Add pwm_can_sleep() as exported API to users
  pwm: Add can_sleep property to drivers
  leds: leds-pwm: Defer led_pwm_set() if PWM can sleep

 drivers/leds/leds-pwm.c   |   50 +++++++++++++++++++++++++++++++++++++-------
 drivers/pwm/core.c        |   12 ++++++++++
 drivers/pwm/pwm-twl-led.c |    1 +
 drivers/pwm/pwm-twl.c     |    1 +
 include/linux/pwm.h       |   10 +++++++++
 5 files changed, 66 insertions(+), 8 deletions(-)

-- 
1.7.5.4

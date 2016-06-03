From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  3 Jun 2016 10:22:58 +0200
Subject: [PATCH 00/14] regulator: pwm: various improvements
Message-ID: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series series aims at adding two important features to the
pwm-regulator driver.

The first one is the support for 'smooth handover' between the
bootloader and the kernel. This is mainly solving problems we have when
the PWM is controlling a critical regulator (like the one powering the
DDR chip). Currently, when the PWM regulator acquire the PWM device it
assumes it was off and it's safe to change the configuration before
enabling it, which can generate glitches on the PWM signal which in turn
generated glitches on the output voltage.
To solve that we've introduced support for hardware readout to the
PWM framework, so that the PWM regulator driver can adjust the PWM
a probe time and avoid glitches.
Atomic update is also helping in this regard.

Patch 1 is adding convenient helpers (at the PWM level) that will be
used by the PWM regulator driver.
Patch 2 is just removing the pwm_enable() call from the ->set_voltage()
implementation (pwm_enable() is already called in the reg->enable()
hook).
Patches 3 to 8 are preparing everything on the PWM driver side to make
hardware readout available to all platforms using the PWM regulator
driver (rockchip and sti).
Patches 9 to 12 are making use of the atomic update and hardware readout
features to implement this smooth handover.

The second feature we add to the driver is the capability of using
a sub duty_cycle range in continuous mode. By default the regulator
is assuming that min_uV is achieved with a 0% dutycyle and max_uV
with a 100% dutycycle, but this is not necessarily true.
Moreover, in some cases (when the PWM device does not support
polarity inversion), we might have min_uV at 100% and max_uV at 0%.
Hence the addition of new properties to the existing DT bindings.
The feature is added in patch 13 and 14.

Best Regards,

Boris

Boris Brezillon (14):
  pwm: Add new helpers to create/manipulate PWM states
  regulator: pwm: Drop unneeded pwm_enable() call
  pwm: rockchip: Fix period and duty_cycle approximation
  pwm: rockchip: Add support for hardware readout
  pwm: rockchip: Avoid glitches on already running PWMs
  pwm: rockchip: Add support for atomic update
  pwm: sti: Add support for hardware readout
  pwm: sti: Avoid glitches on already running PWMs
  regulator: pwm: Adjust PWM config at probe time
  regulator: pwm: Switch to the atomic PWM API
  regulator: pwm: properly initialize the ->state field
  regulator: pwm: Retrieve correct voltage
  regulator: pwm: Support extra continuous mode cases
  regulator: pwm: Document pwm-dutycycle-unit and pwm-dutycycle-range

 .../bindings/regulator/pwm-regulator.txt           |  12 ++
 drivers/pwm/pwm-rockchip.c                         | 182 +++++++++++++++------
 drivers/pwm/pwm-sti.c                              |  55 ++++++-
 drivers/regulator/pwm-regulator.c                  | 159 ++++++++++++------
 include/linux/pwm.h                                |  81 +++++++++
 5 files changed, 391 insertions(+), 98 deletions(-)

-- 
2.7.4

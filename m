From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 22 Oct 2013 18:32:38 +0200
Subject: [PATCH 0/2] misc: atmel_pwm: fix probe dependencies
Message-ID: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two drivers (atmel-pwm-bl and leds-atmel-pwm) currently depend on the
atmel_pwm driver to have bound to any pwm-device before their devices
are probed.

The first patch adds deferred-probing support to the atmel_pwm driver to
handle such dependencies. Note that the atmel-pwm-bl driver in
linux-next supports deferred probing since commit 9d3fde86b ("backlight:
atmel-pwm-bl: fix deferred probe from __init").

Although deferred probing is sufficient to deal with the dependency
problem, relying on deferred probing for the backlight driver is not
desirable as it may cause unnecessary delays before enabling the
backlight at boot. The second patch fixes this by making sure
pwm-devices are probed before any backlight devices.

Johan

Johan Hovold (2):
  misc: atmel_pwm: add deferred-probing support
  misc: atmel_pwm: set initcall level to subsys

 drivers/misc/atmel_pwm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
1.8.4

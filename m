From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sat,  2 Feb 2013 23:44:04 +0900
Subject: [PATCH 0/2] gpiolib: remove gpiochip_reserve()
Message-ID: <1359816246-3979-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tosa (Sharp SL-C6000x) target is the last remaining user of
gpiochip_reserve(). I would like to get rid of this function as part of my
project to totally remove the big static gpio_desc[] array of gpiolib. Patches
that achieve this are written and working, but the presence of
gpiochip_reserve() makes it necessary to maintain a list of "reserved" ranges
in the GPIO space, which complexifies code that would be much simpler
otherwise.

Even for Tosa the use of gpiochip_reserve() does not seem necessary - all GPIO
controllers have their own base GPIO set AFAICT, so there should be no need to
use it. And without any user in the kernel, there should be no reason to keep
this function.

If Dmitri could give his Acked-by or Tested-by and one of the GPIO maintainers
merge this series, I could go ahead with the deeper changes to gpiolib.

Thanks,

Alexandre Courbot (2):
  arm: pxa: tosa: do not use gpiochip_reserve()
  gpiolib: remove gpiochip_reserve()

 arch/arm/mach-pxa/tosa.c   |  6 -----
 drivers/gpio/gpiolib.c     | 58 +++++++---------------------------------------
 include/asm-generic/gpio.h |  1 -
 3 files changed, 8 insertions(+), 57 deletions(-)

-- 
1.8.1.1

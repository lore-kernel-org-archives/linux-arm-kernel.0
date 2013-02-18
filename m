From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Feb 2013 11:14:10 +0000
Subject: arm64 defconfig breakage (gpio) in next-20130218
Message-ID: <20130218111410.GA10572@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When I attempt to build a defconfig arm64 kernel from next-20130218, it fails
with the following complaints from gcc:

In file included from include/linux/gpio.h:48:0,
                 from drivers/gpio/devres.c:18:
include/asm-generic/gpio.h: In function ?gpio_get_value_cansleep?:
include/asm-generic/gpio.h:270:2: error: implicit declaration of function ?__gpio_get_value? [-Werror=implicit-function-declaration]
include/asm-generic/gpio.h: In function ?gpio_set_value_cansleep?:
include/asm-generic/gpio.h:276:2: error: implicit declaration of function ?__gpio_set_value? [-Werror=implicit-function-declaration]
In file included from drivers/gpio/devres.c:18:0:
include/linux/gpio.h: At top level:
include/linux/gpio.h:60:19: error: redefinition of ?gpio_cansleep?
In file included from include/linux/gpio.h:48:0,
                 from drivers/gpio/devres.c:18:
include/asm-generic/gpio.h:262:19: note: previous definition of ?gpio_cansleep? was here
In file included from drivers/gpio/devres.c:18:0:
include/linux/gpio.h: In function ?gpio_cansleep?:
include/linux/gpio.h:62:2: error: implicit declaration of function ?__gpio_cansleep? [-Werror=implicit-function-declaration]
include/linux/gpio.h: In function ?gpio_to_irq?:
include/linux/gpio.h:67:2: error: implicit declaration of function ?__gpio_to_irq? [-Werror=implicit-function-declaration]
drivers/gpio/devres.c: In function ?devm_gpio_release?:
drivers/gpio/devres.c:26:2: error: implicit declaration of function ?gpio_free? [-Werror=implicit-function-declaration]
drivers/gpio/devres.c: In function ?devm_gpio_request?:
drivers/gpio/devres.c:60:2: error: implicit declaration of function ?gpio_request? [-Werror=implicit-function-declaration]
drivers/gpio/devres.c: In function ?devm_gpio_request_one?:
drivers/gpio/devres.c:90:2: error: implicit declaration of function ?gpio_request_one? [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[2]: *** [drivers/gpio/devres.o] Error 1
make[1]: *** [drivers/gpio] Error 2

I've bisected this down to 0fa2fd9a0d: "Merge branch 'linusw/devel' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git into
gpio/next". Both parent commits build fine.

I've played around a bit, and selecting ARCH_REQUIRE_GPIOLIB in the arm64
Kconfig fixes the issue, but I'm unfamilar with gpio{,lib} and I'm not sure
that's the best/correct way of solving this.

Thoughts?

Thanks,
Mark.

From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 13 Jul 2018 11:47:17 +0200
Subject: [PATCH] pinctrl: at91: fix deferred probing support
In-Reply-To: <20180712192222.32481-1-robh@kernel.org>
References: <20180712192222.32481-1-robh@kernel.org>
Message-ID: <20180713094717.GQ16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/07/2018 13:22:22-0600, Rob Herring wrote:
> AT91 pinctrl deferred probing support is broken if the GPIO devices
> haven't probed first and set gpio_banks to non-zero. The later condition
> that only some GPIO devices haven't probed can't actually happen as
> either all the GPIO devices have probed first or none of them have. Plus
> the pinctrl driver has already returned -EINVAL, so it's not on the
> deferred list to retry probing.
> 
> Fix this by consolidating the checking that all GPIO devices are probed.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This is a result of trying to remove of_platform_default_populate from 
> at91 code and relying on the DT core handling populating devices. That 
> changed the probe order and broke booting.
> 

This solves part of the issue but when tested with the
of_platform_default_populate removal, many drivers will fail with
gpiod_set_value: invalid GPIO (errorpointer)

or 

gpiod_get_value: invalid GPIO (errorpointer)

This happens both before and after the pinctrl driver probed.

I didn't investigate much yet.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

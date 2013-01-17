From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 14:30:01 +0100
Subject: [PATCH 1/2] gpio: fix warning of 'struct gpio_chip' declaration
In-Reply-To: <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
 <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdaKhLcS9p9JOhViCkUcMVH1ByBR3v5A4+wOJnQUcuQrVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 9:37 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The struct gpio_chip is only defined inside #ifdef CONFIG_GPIOLIB,
> but it's referenced by gpiochip_add_pin_range() and
> gpiochip_remove_pin_ranges() which are outside #ifdef CONFIG_GPIOLIB.
> Thus, we see the following warning when building blackfin image, where
> GPIOLIB is not required.
>
>   CC      arch/blackfin/kernel/bfin_gpio.o
>   CC      init/version.o
> In file included from arch/blackfin/include/asm/gpio.h:321,
>                  from arch/blackfin/kernel/bfin_gpio.c:15:
> include/asm-generic/gpio.h:298: warning: ?struct gpio_chip? declared inside parameter list
> include/asm-generic/gpio.h:298: warning: its scope is only this definition or declaration, which is probably not what you want
> include/asm-generic/gpio.h:304: warning: ?struct gpio_chip? declared inside parameter list
>
> Move pinctrl trunk into #ifdef CONFIG_GPIOLIB to fix the warning,
> since it appears that pinctrl gpio range support depends on GPIOLIB.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Shawn can you please try to repost this with something that does not
turn into quoted-printable? Look:

MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
(...)
@@ -212,6 +212,43 @@ extern void gpio_unexport(unsigned gpio);
=20
 #endif	/* CONFIG_GPIO_SYSFS */
=20
+#ifdef CONFIG_PINCTRL

I can't apply that.

Second: if this is not an immediate regression I'd prefer to put it
for-next now, as touching this file always brings down something.

OK?

Yours,
Linus Walleij

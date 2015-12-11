From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 10:08:00 +0100
Subject: [PATCH 2/3] Add support for monitoring gpio switches
In-Reply-To: <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <CACRpkdb=it+U+3-0mvZ9Pf1cnYT_r1KkFiS=C4YDkqrjoRm+kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 4, 2015 at 6:31 PM, Martyn Welch
<martyn.welch@collabora.co.uk> wrote:

> Select Chromebooks have gpio attached to switches used to cause the
> firmware to enter alternative modes of operation and/or control other
> device characteristics (such as write protection on flash devices). This
> patch adds a driver that exposes a read-only interface to allow these
> signals to be read from user space.
>
> This functionality has been generalised to provide support for any device
> with device tree support which needs to identify a gpio as being used for a
> specific task.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>

If you want to do this thing, also propose a device tree binding document
for "gpio-switch".

But first (from Documentation/gpio/drivers-on-gpio.txt):

- gpio-keys: drivers/input/keyboard/gpio_keys.c is used when your GPIO line
  can generate interrupts in response to a key press. Also supports debounce.

- gpio-keys-polled: drivers/input/keyboard/gpio_keys_polled.c is used when your
  GPIO line cannot generate interrupts, so it needs to be periodically polled
  by a timer.

- extcon-gpio: drivers/extcon/extcon-gpio.c is used when you need to read an
  external connector status, such as a headset line for an audio driver or an
  HDMI connector. It will provide a better userspace sysfs interface than GPIO.

So you mean none of these apply for this case?

Second: what you want to do is export a number of GPIOs with certain names
to userspace. This is something very generic and should be implemented
as such, not as something Chromebook-specific.

Patches like that has however already been suggested, and I have NACKed
them because the GPIO sysfs ABI is insane, and that is why I am refactoring
the world to create a proper chardev ABI for GPIO instead. See:
http://marc.info/?l=linux-gpio&m=144550276512673&w=2

So for the moment, NACK on this, please participate in creating the
*right* ABI for GPIO instead of trying to shoehorn stuff into the dying
sysfs ABI.

Yours,
Linus Walleij

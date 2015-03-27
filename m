From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 10:15:13 +0100
Subject: configuration for nc pins without pull
In-Reply-To: <20150322100059.GH5664@pengutronix.de>
References: <20150322100059.GH5664@pengutronix.de>
Message-ID: <CACRpkda2UHv5oe1z-48SDiYUH1BzVsJS-V4CRKcmjTfn=o=O7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 11:00 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> for a machine I want to configure a pin that is actually not connected
> to minimize floating. (I think this is sensible, isn't it?)

Yup, and Russell gave an excellent summary of why.

> For the pinctrl I can use a hog group of the pinctrl device. At least
> one of the pins doesn't have a pullup/pulldown configuration though, so
> I want to mux it to its gpio function and set the gpio to output and the
> desired value.
>
> Is there something nicer than defining an always-on regulator with gpios
> = <&gpio4 3 0> to accomplish that without additional code?

As explained in
Documentation/pinctrl.txt, section "GPIO mode pitfalls" like 788
this is not really "GPIO", it is a way of controlling the electric state
of the pin using software, it's just the hardware designers idea of the
use case that it is "GPIO", it is not what a software engineer would call
GPIO.

If the controller support GENERIC_PINCONF I suggest implementing
PIN_CONFIG_OUTPUT from include/linux/pinctrl/pinconf-generic.h
which is more or less for exactly this purpose.

It will bring the pin into "GPIO mode" by poking the right registers but
what is really happening is a non-GPIO usecase on the pin control
side of things.

This should be done using a hog on the device tree and
output-low; or output-high; using the generic pinctrl bindings.

Yours,
Linus Walleij

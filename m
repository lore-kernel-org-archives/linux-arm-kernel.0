From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 28 Oct 2012 21:12:52 +0100
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
Message-ID: <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 7:28 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

>> drivers/spi/spi-pl022.c
>
> Default/sleep transitions could be moved into bus code.

No that's not a good idea as long as we have both the platform bus
and the AMBA bus doing essentially the same thing. We will then be
having two copies of the same code in two different busses running
out of sync. There may be other busses too.

But I could prepare static helpers in <linux/pinctrl/consumer.h>
that any bus could use. Or any driver. Probably any driver,
because of this:

As noted the bus cannot really execute the pinctrl calls to
e.g. put a drivers pins into "sleep". Since if e.g. the bus is walking
the suspend() ladder, shall it put the pins into sleep *before*
or *after* calling the suspend() hook in the driver?

The answer is that it does not know. Because drivers have
different needs. Depending on how the hardware and
system is done.

I already tried to make this point:

pinctrl_set_state(state_sleep);
clk_disable();
power_off_voltage_domain();

May for some drivers have to be:

clk_disable();
power_off_voltage_domain();
pinctrl_set_state(state_sleep);

(etc)

I'm not making this up, it is a very real phenomenon on the
Ux500 and I don't think we are unique.

Moving this handling to bus code or anywhere else
invariably implies that resource acquisition/release order
does not matter, and my point is that it does.

>> drivers/i2c/busses/i2c-nomadik.c
>
> Don't see pinctrl in linux-next.

This code is here:
http://marc.info/?l=linux-i2c&m=134986995731695&w=2

Yours,
Linus Walleij

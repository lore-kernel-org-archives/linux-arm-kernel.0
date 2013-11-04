From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Nov 2013 13:01:59 +0100
Subject: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <20131024151736.GE9044@ulmo.nvidia.com>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
 <20131024151736.GE9044@ulmo.nvidia.com>
Message-ID: <CACRpkdbuB6g+Qo0FCXaueKpAvT6vUKuNmoceWCGfG0KLa8+3Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 5:17 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Thu, Oct 24, 2013 at 02:42:13PM +0200, Denis Carikli wrote:

>> +Optional properties:
>> +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
>> +  (see GPIO binding[2] for more details).
>> +- interrupt-parent: the phandle for the gpio controller
>> +  (see interrupt binding[1]).
>> +- interrupts: (gpio) interrupt to which the chip is connected
>> +  (see interrupt binding[1]).
>> +- pinctrl-0: Should specify pin control groups used for the gpio
>> +  (see pinctrl bindings[0]).
>> +- pinctrl-names: Should contain only one value - "default"
>> +  (see pinctrl bindings[0]).
>
> Also I haven't seen a response as to why this can't be handled by the
> GPIO driver. Adding Linus Walleij, perhaps he knows a more definitive
> answer.
>
> Linus, the issue here is that the pinctrl properties for this chip are
> supposed to pinmux the pendown GPIO for this chip. I was under the
> impression that this should be handled by the GPIO controller itself, so
> that when gpio_request() was called on a pin it would be the GPIO
> controller driver's responsibility to pinmux it appropriately.

If this is the only thing it does (just mux in the GPIO and not setting
any pulls or other pin config properties) then it can fall through from
the GPIO controller's request function to pinctrl_request_gpio()
and then pinctrl_free_gpio(), pinctrl_gpio_direction_input()
and pinctrl_gpio_direction_output() respectively so that pin control
provides a muxing back end to the GPIO driver.

Actually these functions are up to the driver to implement, but
the core will call ->gpio_request_enable() on the pinctrl driver,
and if all GPIOs are set up the same way (i.e. the same bits
are always poked into the hardware) then this can be done
in that routine.

If more fine-grained control is needed, this approach providing
a full pin control handle and state settings connected to the
struct device * can and should be used instead.

Yours,
Linus Walleij

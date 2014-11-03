From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Nov 2014 13:09:57 -0800
Subject: [RFC PATCH 1/2] pinctrl: Add output-disable
In-Reply-To: <CACRpkdagHFAaPmQptsm7pz_JqYUCbU-0FoH45vrXo8pG6mTAxA@mail.gmail.com>
References: <1414529835-16207-1-git-send-email-dianders@chromium.org>
 <CACRpkdagHFAaPmQptsm7pz_JqYUCbU-0FoH45vrXo8pG6mTAxA@mail.gmail.com>
Message-ID: <CAD=FV=VLvoNw5pu5P_iny5a-3-f1XMqGwgQLBp4QmoAM6WPWAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Fri, Oct 31, 2014 at 1:49 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 28, 2014 at 9:57 PM, Doug Anderson <dianders@chromium.org> wrote:
>> The pinctrl bindings / API allow you to specify that:
>> - a pin should be an output
>> - a pin should have its input path enabled / disabled
>>
>> ...but they don't allow you to tell a pin to stop outputting.  Lets
>> add a new setting for that just in case the bootloader (or the default
>> state) left a pin as an output and we don't want it that way anymore.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
> (...)
>> + * @PIN_CONFIG_OUTPUT_DISABLE: this will configure the pin _not_ to output.
>> + *     Parameter should be 1.
>
> This doesn't make sense. The pin is either low, high, some analog mode
> or tristate/high impedance.
>
> It does *not* stop existing.
>
> Figure out the exact electronic meaning of what happens when you do
> "output disable" in your hardware, I think it is very likely that
> PIN_CONFIG_BIAS_HIGH_IMPEDANCE is what you are really
> after here.

OK, that seems plausible.  ...so it is OK to set both
"bias-high-impedance" _and_ "bias-pull-up" on a pin?  That seemed
weird to me but if that's right I can do that and try to implement
"bias-high-impedance" on Rockchip...


Maybe better to explain the problem.  I have a pin that I wish to
drive high weakly (using a pullup rather than actually pushing
output-high to the pin).  The firmware has left the pin configured as
an output with no pull.

I can configure the pin like this:
  rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_up>;

  pcfg_pull_up: pcfg-pull-up {
    bias-pull-up;
  };

When I do this the current Rockchip pinctrl driver will _not_
configure me as an input.  It will happily flip the "pullup" bit in
hardware and leave the pin configured as an output.

I could certainly reach into the GPIO controller part of things
whenever I see "bias-pull-up" and configure the pin as an input.  I
guess that wouldn't actually hurt to do even if the pin wasn't
configured as a GPIO...  In other words, if someone has:
  rockchip,pins = <6 22 RK_FUNC_1 &pcfg_pull_up>;

...it doesn't hurt to set the GPIO controller for this pin to be an
input because it's not used when RK_FUNC_1 is used.


A third option that would work in my case (and actually be sorta
clean) would be to implement a faux open-drain output.  The hardware
itself doesn't have a concept of open drain (unlike some SoCs) but I
could implement it by swapping between "input pulled up" and "output
driven low".


-Doug

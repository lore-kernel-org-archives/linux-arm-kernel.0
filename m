From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 13:35:50 +0200
Subject: Accessing GPIOs from userspace using recent kernels
In-Reply-To: <ea43ccacfe4caf1f51f9e5a5c8bbdd5e@net2air.co>
References: <3385f19f3e1427613732f6d5c9f8513d@net2air.co>
 <CABxcv=mFV3nJf1eqNhTbh1KWwe8Z6Z62JtFn5KZbHnGprk1_bg@mail.gmail.com>
 <7bd3dbc0c3217f43eefc8d228995690f@net2air.co>
 <CABxcv=nTV23Un91fSUmkixsF5uywoisCOi1qhPqVvZb+RvikDA@mail.gmail.com>
 <ea43ccacfe4caf1f51f9e5a5c8bbdd5e@net2air.co>
Message-ID: <CACRpkdYTa+_zAsbwU+XYSWnsN4i4Xkfm28S1=vcC5=oz0TH3Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

I think you have already understood from the rest of the conversation that pin
control configuration shall be done in the device tree and not from userspace,
which is a good start.

As shown by Javier many things people sometimes do in userspace should
rather be done in kernelspace, such as controlling LEDs and reading
pushbuttons etc.

On Fri, May 16, 2014 at 12:15 PM, Peter TB Brett <peter@peter-b.co.uk> wrote:
> On 2014-05-15 19:54, Javier Martinez Canillas wrote:

>> 0x5e (PIN_INPUT_PULLUP | MUX_MODE0)     /* hdmi_sda.hdmi_sda */
>> 0x12e (PIN_OUTPUT | MUX_MODE5)  /* dispc2_data15 */
>
> Yes, that's my mistake.  I took the pin control register addresses from the
> OMAP4 documentation and forgot that you have to subtract 0x40 to get the
> correct address for use in the device tree.
>
> The correct snippet has 0x1e and 0xee.

I find the pinctrl-single hexdigit syntax infinitely complex and confusing,
but it was chosen by its designers. Most drivers use strings to configure
muxing and biasing etc.

>> Is what you shared your real change or just an example that does not
>> apply to the Pandaboard? Could you please share your complete DTS?
>
>
> The attached .dts file sort of works-ish.  It's an ugly hack, but I don't
> have the time to do any more investigation into this now, unfortunately.
>
> I guess my main question is: if I use /sys/class/gpio/export to export a
> GPIO for userspace control,

Which you should avoid, if possible.

> it would make sense for the kernel to try and
> ensure that the GPIO is actually connected to something!

How should we do that? The physics of that request evades me.

The pin control subsystem will however
refuse to use the pin if it is used for something else.

> The current call chain seems to be: gpiod_export() --> gpiod_request() -->
> omap_gpio_request().  Looking at other GPIO drivers, it seems like
> omap_gpio_request() should eventually call pinctrl_request_gpio().  Would be
> useful if someone who knows about OMAP4/gpio/pinctrl could take a look at
> this.

That is Tony Lindgren and the linux-omap mailing list.

Yours,
Linus Walleij

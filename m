From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 14:08:57 +0100
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <20170315050850.GC1694@minitux>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
 <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
 <20170314233040.GH10239@codeaurora.org>
 <c40b0ee7-6d8c-8c5d-d4c5-9ecf8076e44f@codeaurora.org>
 <20170314234140.GI10239@codeaurora.org>
 <f1152d48-004e-71bc-16a1-3a25990ba9e4@codeaurora.org>
 <20170315050850.GC1694@minitux>
Message-ID: <CACRpkdYE4svSgFywpgfM1zE72BaA_FsUCR1VeAGMLYykJCQoWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 6:08 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 14 Mar 17:12 PDT 2017, Timur Tabi wrote:

>> Did you mean the gpio_chip.request callback?  Currently that points to
>> gpiochip_generic_request in pinctrl-msm.c.
>
> It might be useful to fail gpio_get, as that gives a much nicer error
> path in the client. But I'm slightly concerned about the few cases where
> one of the pinmux states is gpio and that this would force the
> gpio_get() only to be called after switching to that particular mode.
>
> @Linus, have there been any discussion around this in other drivers?

Not more than the obvious, this driver has:

        .request          = gpiochip_generic_request,
        .free             = gpiochip_generic_free,

Which will call:

pinctrl_request_gpio()
pinctrl_free_gpio()

(Note: we now also have gpiochip_generic_config() and
pinctrl_gpio_set_config(), you should maybe want to look into
this because it makes it possible for the pin control back-end
to support debouncing and open drain/source from the gpiolib
side.)

Anyways in some drivers (not pinctrl-msm.c) this ends up calling
this helper callback in pinmux_ops:

 * @gpio_request_enable: requests and enables GPIO on a certain pin.
 *      Implement this only if you can mux every pin individually as GPIO. The
 *      affected GPIO range is passed along with an offset(pin number) into that
 *      specific GPIO range - function selectors and pin groups are orthogonal
 *      to this, the core will however make sure the pins do not collide.

If you do not have this kind of BIOS/ACPI playing around with the
pins behind your back, then this is really helpful to avoid having
to (in the DTS) mux all these pins to the GPIO function explicitly
like this for example:

/* Interrupt line for the KXSD9 accelerometer */
dragon_kxsd9_gpios: kxsd9 {
    irq {
        pins = "gpio57"; /* IRQ line */
        bias-pull-up;
    };
};

Well, in this case, since we also need to set up a pull-up the DT node
is needed anyways, but you get the idea.

So we have a bunch of fit-all callbacks but the subsystem was
constructed for a scenario where the kernel has full control over the
pins.

In the beg?nning ACPI people were saying they simply should not
devise any pin control driver at all, because ACPI would handle all
muxing behind the scenes. It turns out they were mostly too
ambitious about that, one usecase is power optimizations that are
not readily understood when writing the BIOS, other reasons are
when you are building embedded systems and randomly adding some
extra peripherals, in theory every vendor should ideally write a new
ACPI table and reflash the BIOS but it appears that in practice they
do not, so I think most of that hardware has some hybrid model.

I would ask the Intel people about their position of ACPI and pin
control interwork, they have most experience in this. If you
git-blame drivers/gpio/gpiolib-acpi.c you can see that it is mostly
written by Mika and Rafael.

If you look in intel_pinmux_set_mux() you find that they do avoid
muxing some pins:

        /*
         * All pins in the groups needs to be accessible and writable
         * before we can enable the mux for this group.
         */
        for (i = 0; i < grp->npins; i++) {
                if (!intel_pad_usable(pctrl, grp->pins[i])) {
                        raw_spin_unlock_irqrestore(&pctrl->lock, flags);
                        return -EBUSY;
                }
        }

Yours,
Linus Walleij

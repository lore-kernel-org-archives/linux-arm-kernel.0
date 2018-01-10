From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Jan 2018 08:37:33 -0800
Subject: [PATCH 2/3] dt-bindings: pinctrl: Add a ngpios-ranges property
In-Reply-To: <CACRpkdaN6vmV4L4U76DvD5BN+j1RYCQakTysA+GGPdT8Chc-iw@mail.gmail.com>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-3-sboyd@codeaurora.org>
 <CACRpkdaN6vmV4L4U76DvD5BN+j1RYCQakTysA+GGPdT8Chc-iw@mail.gmail.com>
Message-ID: <20180110163733.GH21040@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10, Linus Walleij wrote:
> On Wed, Jan 10, 2018 at 2:58 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > +- ngpios-ranges:
> > +       Usage: optional
> > +       Value type: <prop-encoded-array>
> > +       Definition: Tuples of GPIO ranges (base, size) indicating
> > +                   GPIOs available for use.
> > +
> >  Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
> >  a general description of GPIO and interrupt bindings.
> 
> I like the tuples syntax. That's fine. It's like gpio-ranges we have
> already to map between pin controllers and GPIO.
> 
> I don't think we can reuse gpio-ranges because that is
> exclusively for pin control ATM, it would be fine if the ranges
> were for a specific device, like pin control does, like:
> 
> gpio-ranges = <&secure_world_thing 0 20 10>;
> 
> But you definately would need a node to tie it to, so that the
> driver for that node can specify that it's gonna take the
> GPIOs.
> 
> But I think the semantics should be the inverse. That you
> point out "holes" with the lines we *can't* use.

Ok. I can invert the logic and push it into the core part of the
code. I'll leave the ACPI part in the msm driver.

> 
> We already support a generic property "ngpios" that says how
> many of the GPIOs (counted from zero) that can be used,
> so if those should be able to use this as a generic property it
> is better with the inverse semantics and say that the
> "reserved-gpio-ranges", "secureworld-gpio-ranges"
> (or whatever we decide to call it) takes precedence over
> ngpios so we don't end up in ambigous places.
> 
> Then, will it be possible to put the parsing, handling and
> disablement of these ranges into drivers/gpio/gpiolib-of.c
> where we handle the ranges today, or do we need to
> do it in the individual drivers?
> 

I'll cook that up right now to do the inverse thing in the
gpiolib core code with a 'reserved-gpio-ranges' property. I
haven't looked in much detail, but I would hope that it would
work pretty easily. Should it be decoupled from the
GPIOLIB_IRQCHIP config? If the idea is generic, then it may not
be related to irq lines, but for the qcom driver it was all fine
because all three concepts: irq, gpios, and pins have a one to
one relationship. The only place it breaks down is if we have
more pins than gpios, in which case I punted and just considered
non-gpio pins as always valid.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

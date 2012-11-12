From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 12 Nov 2012 11:17:08 -0800
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <50A146E7.2040608@wwwdotorg.org>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <50A020C5.4070506@wwwdotorg.org> <20121112082546.GU22029@lunn.ch>
 <50A1212C.2080601@wwwdotorg.org> <20121112181947.GS24583@lunn.ch>
 <20121112184340.GA15643@lizard> <50A146E7.2040608@wwwdotorg.org>
Message-ID: <20121112191708.GA21040@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 11:58:47AM -0700, Stephen Warren wrote:
[...]
> >>>>> Unfortunately, not all GPIO bindings support active high/low flags in
> >>>>> the GPIO specifier. As such, the flags there are basically useless.
> >>>>> Other bindings (e.g. IIRC the fixed-regulator binding) have added a
> >>>>> separate active-high property to indicate the GPIO polarity. This
> >>>>> binding should probably follow suite.
> > 
> > Should the gpio driver fix its bindings then?.. Polarity is a quite
> > generic concept of a GPIO, and flags are there for a reason. I'd rather
> > prefer having
> 
> There is no "GPIO driver" to fix; each GPIO driver has its own bindings,
> and unfortunately, some of the GPIO binding authors chose not to include
> any flags cell in the GPIO specifier (e.g. Samsung ARM SoCs IIRC, but
> there are probably more).

They didn't read this? :)

int of_gpio_simple_xlate(struct gpio_chip *gc,
                         const struct of_phandle_args *gpiospec, u32 *flags)
{
        /*
         * We're discouraging gpio_cells < 2, since that way you'll have to
         * write your own xlate function (that will have to retrive the GPIO
         * number and the flags from a single gpio cell -- this is possible,
         * but not recommended).
         */
        if (gc->of_gpio_n_cells < 2) {
                WARN_ON(1);
                return -EINVAL;
        }

They should have gotten the WARN_ON().

If not, if they do have the second cell, then they still can encode the
flags. Just change the bindings in a backwards-compatible way.

And even if they have just one cell, just as the comment above says, they
still can add the polarity flag -- add it into the gpio number specifier.
0x0001 -- GPIO 1, 0x1001 -- GPIO 1, polarity inverted. In the gpio driver
they have to mask the flags (by implementing their own xlate), of course.

A few "broken" (but fixable) drivers/bindings is not the reason change the
whole concept, or declare a long-standing API as 'not suitable for generic
code'. At least it was meant exactly to be suitable for a generic code. :)

Thanks,
Anton.

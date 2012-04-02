From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 2 Apr 2012 16:34:27 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <CAN1soZy3JLK0NNt-VmgaJ8ofq5Qj7Y2WnpDKwPxyQXxZ_Mbw2w@mail.gmail.com>
Message-ID: <1333380867.84262.YahooMailClassic@web29015.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Haojian,

--- On Mon, 2/4/12, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> >> > But since DRIVE_HIGH or
> DRIVE_LOW currently don't
> >> prevent that,
> >>
> >> Don't prevent what?
> >
> > Don't prevent a GPIO input being changed to an output
> when entering
> > suspend().
> >
> PGSRx register allow for selecting the output state (the
> driven value)
> of each GPIO pin when the processor enters and while it is
> in sleep
> mode.
> 
> Each bit of PGSRx register is named as SS (Sleep State of
> GPIO<n>).
> 
> SS '0' -- If GPIO is programmed as an output, the pin is
> driven and held
> low during the transition to and while in sleep mode.
> 
> SS '1' -- If GPIO is programmed as an output, the pin is
> driven and held
> high during the transition to and while in sleep mode.
> 
> So pin must be configured to GPIO output first before
> entering sleep mode.
> 
> Now the issue comes. If you use the pin as input, why do you
> need to change
> it into output mode in run time?

I cannot think of a reason why you would change an input to an output.

But the possibility that the direction could be changed from input
to output has been cited as a reason why KEEP_OUTPUT cannot force
the gpio direction to output.

It is relatively easy to verify that KEEP_OUTPUT does not change the
direction from input to output, because currently only 2 platforms
use KEEP_OUTPUT, namely corgi and hx4700.

It is less easy to verify that DRIVE_HIGH and DRIVE_LOW do not change
the direction from input to output, because many more platforms use
them; a cursory check suggests that up to 16 platforms use them.

> 
> > By the way, there is still the issue of DRIVE_HIGH and
> DRIVE_LOW
> > forcing the GPIO direction to output in
> pxa2xx_mfp_suspend()
> > *before* the PGSR values take effect. Surely a bug?
> >
> It's evil to change pin from input mode to output mode if
> it's in active mode.

Agreed.

So pxa2xx_mfp_suspend() contains a potential bug, unless someone can
verify that DRIVE_HIGH and DRIVE_LOW never change the direction from
input to output.

> 
> Actually we only need to configure control pins to
> peripherals on pxa27x. It's
> a little different from pxa3xx. For pxa3xx, we can even
> configure input pin
> in low power mode. PXA3xx has standby mode that internal
> device keeps
> its state. PXA27x doesn't have this feature. If we want to
> save power while
> PXA27x is suspend, the peripheral should be shutdown too.
> 
> Since we need to shutdown peripheral, control pin should
> always connect to
>  reset or chip select signal of peripheral, we can disable
> the peripheral. So
> we needn't to configure low power mode of those input pins.

Regards,
Paul

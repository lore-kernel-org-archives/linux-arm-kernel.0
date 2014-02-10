From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Feb 2014 10:38:38 +0100
Subject: [PATCH] pinctrl:at91:add drive strength configuration
In-Reply-To: <1390285991-1634-1-git-send-email-mark.roszko@gmail.com>
References: <20140121060637.GP9558@ns203013.ovh.net>
 <1390285991-1634-1-git-send-email-mark.roszko@gmail.com>
Message-ID: <CACRpkdaRP_JBt3Qqb6M6PFOHcUVOdVFNTsE9fWv-U073B=3UcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I agree with J-C that the patch shall be split in one for the DT changes and one
for the driver changes (that I will apply to the pinctrl tree).

On Tue, Jan 21, 2014 at 7:33 AM, Marek Roszko <mark.roszko@gmail.com> wrote:

> The SAMA5 and most SAM9xGs(baring a few exceptions like the SAM945G) have drive
> control registers that allow configuring the output current of the gpio pins between
> three predefined levels of low,medium and high drive.

Can we get to know a bit more about default/low/medium and high?

I.e. this:

> +#define DRIVE_STRENGTH_DEFAULT (0x0 << 5)
> +#define DRIVE_STRENGTH_LOW             (0x1 << 5)
> +#define DRIVE_STRENGTH_MED             (0x2 << 5)
> +#define DRIVE_STRENGTH_HI              (0x3 << 5)
(...)
> +static unsigned at91_mux_sam9x5_get_drivestrength(void __iomem *pio, unsigned pin)
> +{
> +       unsigned tmp = read_drive_strength(pio + at91sam9x5_get_drive_register(pin), pin);
> +
> +       /*
> +        * inverse the setting for dt defines
> +        * 0 = hi, 1 = med, 2 = low, 3 = rsvd

But in the defines ... 3-3=0 means "default" not
"reserved"?

> +        */
> +       tmp = DRIVE_STRENGTH_HI - tmp;
(...)
> +#define AT91_PINCTRL_DRIVE_STRENGTH_DEFAULT    (0x0 << 5)
> +#define AT91_PINCTRL_DRIVE_STRENGTH_LOW                (0x1 << 5)
> +#define AT91_PINCTRL_DRIVE_STRENGTH_MED                (0x2 << 5)
> +#define AT91_PINCTRL_DRIVE_STRENGTH_HI         (0x3 << 5)

So I guess "default" is some HW-defined driver strength decided when
synthesizing the block? (Document the answer in the bindings or
something.)

What I'm after is if this is drive strength in the sense of
"number of driver stages" i.e. a number of extra mA per
strength increase, usuall in 2mA or 4mA increases, so e.g.
LOW=2mA, mid=4mA, high=6mA or if it's actually a
slew rate thing designed for restricing the noise in silicon
and/or electronics by providing a less steep slope containing
less overtones. (This is usually done by another construction.)
Which one is it?

You also already have this:
#define AT91_PINCTRL_MULTI_DRIVE        (1 << 1)

How does these different things relate? Do you have to set
MULTI_DRIVE for the settings to work? Or is it leftover cruft?
Or what is it?

Also take this opportunity to update:
Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
To document all these funny defines and what they are used for.

The bindings changes should be part of the pinctrl driver patch.

Yours,
Linus Walleij

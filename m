From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Mon, 18 Apr 2011 09:17:16 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTinnscZeaHkuMme1h-mxGrpJhmZ_Xg@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinnscZeaHkuMme1h-mxGrpJhmZ_Xg@mail.gmail.com>
Message-ID: <20110418071716.GA334@kurt.e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The interface proposed here is a lot better than most ad hoc implementation.
But similar to what Kyungmin Park noticed, I doubt the usefulness
of a limited enumeration for all different types.

On one hand, upper layers benefit from a limited list (like proposed).
On the other hand, most SoC's have more options, which are not comparable.

How will this interface cope with such differences?
a) ignore SoC specifics
b) export it through an _unlimited_ enumeration
c) export it via some GPIO_DRIVE_PROPRIETARY+X where X is very
   SoC dependant.

Any suggestions?

Kurt

On Mon, Apr 18, 2011 at 09:09:28AM +0900, Kyungmin Park wrote:
> Hi Linus,
> 
> It's really required feature for ARM architectures.
> In case of samsung SoCs. it needs more things you described.
> In case of setting the drive, we can set the drive strength, 1x, 2x, 3x, and 4x.
> So can it add the more like this? or separate enumeration?
> 
> > +enum gpio_drive {
> > + ? ? ? GPIO_DRIVE_PUSH_PULL,
> > + ? ? ? GPIO_DRIVE_OPEN_DRAIN,
> > + ? ? ? GPIO_DRIVE_OPEN_SOURCE,
>             GPIO_DRIVE_STRENGTH_1X,
>             GPIO_DRIVE_STRENGTH_2X,
>             GPIO_DRIVE_STRENGTH_3X,
>             GPIO_DRIVE_STRENGTH_4X,
> > +};
> 
> or
> 
> enum gpio_drive_strength {
>             GPIO_DRIVE_STRENGTH_1X,
>             GPIO_DRIVE_STRENGTH_2X,
>             GPIO_DRIVE_STRENGTH_3X,
>             GPIO_DRIVE_STRENGTH_4X,
> };
> 
> Thank you,
> Kyungmin Park
> 
> On Mon, Apr 18, 2011 at 6:37 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > This adds two functions for struct gpio_chip chips to provide pin
> > bias and drive mode settings for individual pins. Implementers does
> > this a bit differently and usually there are a few possible modes you
> > can select, I'm providing a few common modes for biasing and driving
> > pins.
> >
> > Since we have no previous hacked-up arch-specific drivers for this
> > we can avoid any __override_functions and we just allow this to be
> > properly implemented using gpiolib. Further the function is made
> > non-mandatory, if it is not defined for the chip it will be silently
> > ignored.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[...]

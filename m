From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 3 Dec 2014 16:08:15 +0100
Subject: [PATCH 1/2] pinctrl: at91: allow disabled gpio controllers
In-Reply-To: <CACRpkdbXuXyfwAyFTHVDGa4OS88KsHXZeDDAeXf6ZJ_JQmduoQ@mail.gmail.com>
References: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdbXuXyfwAyFTHVDGa4OS88KsHXZeDDAeXf6ZJ_JQmduoQ@mail.gmail.com>
Message-ID: <20141203150814.GD2714@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 02:56:22PM +0100, Linus Walleij wrote:
> On Fri, Nov 28, 2014 at 5:49 PM, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> 
> > This patch allows to have gpio controller with status set to disabled.
> >
> > gpio_banks represents all the gpio banks available on the device whereas
> > nbanks represents the gpio banks used. Having a disabled gpio controller
> > involves that nbanks value is lower than gpio_banks and that some
> > pointers in the gpio_chips array are NULL. This patch deals with these
> > specific cases.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> (...)
> >         /* We will handle a range of GPIO pins */
> > -       for (i = 0; i < info->nbanks; i++)
> > -               pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
> > +       for (i = 0; i < gpio_banks; i++)
> > +               if (gpio_chips[i])
> > +                       pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
> 
> I highly suspect the real solution to this problem is to get rid
> of the pinctrl_add_gpio_range() call from the driver.
> 
> Remobe these calls, and instead in at91_gpio_probe() in the same
> file, call gpiochip_add_pingroup_range() for each GPIO chip.
> 
> That way the GPIO ranges are inserted from the GPIO side instead
> of the pinctrl side, which is way better, since it is more relative,
> and make you only add ranges for the gpio chips actually there.

I had a quick look to Documentation about that stuff, I totally agree
that it is a better approach. Before going further I was wondering if it
would not cause backward compatibility issue with old dtb (it seems I'll
have to add some properties to gpio controllers).

Regards

Ludovic

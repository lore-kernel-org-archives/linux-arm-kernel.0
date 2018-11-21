From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Wed, 21 Nov 2018 18:01:16 +0100
Subject: [PATCH] gpio: mt7621: handle failure of devm_kasprintf()
In-Reply-To: <CAMpxmJUNYWqk4PEKcZ5o5PMR3RhMhudK+Pf+Pfo64mvJ8ND2wQ@mail.gmail.com>
References: <1542818142-27800-1-git-send-email-hofrat@osadl.org>
 <CAMpxmJUNYWqk4PEKcZ5o5PMR3RhMhudK+Pf+Pfo64mvJ8ND2wQ@mail.gmail.com>
Message-ID: <20181121170116.GA10656@osadl.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 05:43:43PM +0100, Bartosz Golaszewski wrote:
> ??r., 21 lis 2018 o 17:39 Nicholas Mc Guire <hofrat@osadl.org> napisa??(a):
> >
> > kasprintf() may return NULL on failure of internal allocation thus the
> > assigned  label  is not safe if not explicitly checked. On error
> > mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> > (unlikely) failure case should be fine here.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> > ---
> >
> > Problem located with experimental coccinelle script
> >
> > Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
> > GPIOLIB=y, GPIO_MT7621=y
> >
> > Patch is against 4.20-rc3 (localversion-next is next-20181121)
> >
> >  drivers/gpio/gpio-mt7621.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> > index d72af6f..42f0c67 100644
> > --- a/drivers/gpio/gpio-mt7621.c
> > +++ b/drivers/gpio/gpio-mt7621.c
> > @@ -244,6 +244,10 @@ mediatek_gpio_bank_probe(struct device *dev,
> >         rg->chip.of_xlate = mediatek_gpio_xlate;
> >         rg->chip.label = devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
> >                                         dev_name(dev), bank);
> > +       if (!rg->chip.label) {
> > +               dev_err(dev, "Could not allocate label\n");
> 
> No need for an error message here, an -ENOMEM says enough.
>

I just thought its more consistent with the rest of
the code - and as it is a highly unlikely event it would
probably be hard to pinpoint as some of the other functions
can return -ENOMEM (but with a message).

....and the call site of mediatek_gpio_bank_probe() actually 
currently ignores the return value so the -ENOMEM would go
unnoticed which is a bug as well - patch for that a bit later.

anyway fine with me - I?ll send a V2 and drop the dev_err() here.

thx!
hofrat
 
> Bart
> 
> > +               return -ENOMEM;
> > +       }
> >
> >         ret = devm_gpiochip_add_data(dev, &rg->chip, mtk);
> >         if (ret < 0) {
> > --
> > 2.1.4
> >

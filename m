From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Sep 2012 12:11:07 +0100
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
 <20120903100656.GC5782@gmail.com>
 <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
Message-ID: <CAF2Aj3hUo=Dx37cpwdJT74dLQoCfcOHVY4CAZnKDoiniG8Xkag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You're right. I rushed it to get it out the door, as I'm working on
something else.

Leave it with me. I'll spend more time on the semantics before posting
again.

On 3 September 2012 12:07, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Sep 3, 2012 at 12:07 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
> (...)
> > +       if (np) {
> > +               if (!pdata) {
> > +                       pdata = devm_kzalloc(&adev->dev, sizeof(*pdata),
> GFP_KERNEL);
> > +                       if (!pdata) {
> > +                               ret = -ENOMEM;
> > +                               goto err_no_mem;
> > +                       }
> > +               }
> > +               /* Provide the default configuration as a base. */
> > +               memcpy(pdata, &u8500_i2c, sizeof(struct
> nmk_i2c_controller));
>
> Here you blank out any pdata passed from say a board file or
> whatever if pdata != NULL.
>
> > +
> > +               nmk_i2c_of_probe(np, pdata);
> > +       }
> > +
> >         if (!pdata)
> >                 /* No i2c configuration found, using the default. */
> >                 pdata = &u8500_i2c;
>
> So this is still wrong, if pdata is passed to the driver it will
> not override the DT, you have the semantics the other way
> around, DT overrides pdata.
>
> Look at the switch statement in my previous comment,
> just add the allocations and a memcpy() and it still holds:
>
> if (!pdata) {
>     if (np) {
>               pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
>                       if (!pdata) {
>                               ret = -ENOMEM;
>                               goto err_no_mem;
>                       }
>               }
>               /* Provide the default configuration as a base. */
>               memcpy(pdata, &u8500_i2c, sizeof(struct nmk_i2c_controller));
>               nmk_i2c_of_probe(np, pdata);
>     } else
>          /* Just use the static pdata */
>          pdata = &u8500_i2c;
> }
>
> Yours,
> Linus Walleij
>



-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120903/f5680a71/attachment-0001.html>

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 May 2012 15:53:10 +0000
Subject: [PATCH 02/12] pinctrl: basic Nomadik pinctrl interface
In-Reply-To: <CACRpkdZ+8n-E_8nyq-kO=Y+GYekkjiNXd3nzTqFnxLszpuKKPg@mail.gmail.com>
References: <1336470270-23518-1-git-send-email-linus.walleij@stericsson.com>
 <CACRpkdaiTsaBT=20UUOx2mYsK4r5rArVqXfU9LMObFVb3iEA9w@mail.gmail.com>
 <CACRpkdZ+8n-E_8nyq-kO=Y+GYekkjiNXd3nzTqFnxLszpuKKPg@mail.gmail.com>
Message-ID: <201205101553.11304.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2012, Linus Walleij wrote:
> Then it's probably a good idea to actually loop in Arnd too...
> sorry for missing it!
> 
> On Thu, May 10, 2012 at 5:10 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, May 9, 2012 at 10:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> >>> +static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
> >>
> >>> +     /* Poke in other ASIC variants here */
> >>> +     if (platid->driver_data == PINCTRL_NMK_DB8500)
> >>> +             nmk_pinctrl_db8500_init(&npct->soc);
> >>
> >> Other platforms have a unique top-level driver for each variant, with
> >> the probe() function for each variant calling into a utility function.
> >> That way, the common/utility code doesn't need to contain a
> >> table/list/... of all the variants. Can the same approach be used here?
> >
> > Of course I could do it that way, but it's not using this feature
> > of the driver base to have a string identifier telling which version
> > it is.
> >
> > Since I'm unsure, let's ask Arnd.
> >
> > Arnd, what is your preferred design pattern of:
> >
> > A) sub-drivers that register one struct platform_driver per
> >  variant, then calls into a shared core driver, or
> >
> > B) a shared core driver registering one platform_driver
> >  with several struct platform_device_id that then call
> >  sub-drivers depending on which one is found
> >
> > Either way is actually OK for me, but I was thinking if one
> > is preferred over the other.

Out of those two, I'd always pick B.

In cases where the variants are different enough that you want to
put them into separate files, I'd do

C) Make the common code one module that just exports symbols but
registers no platform_driver at all, then put each variant into
its own module that binds to one ID and calls the exported
functions from the common module.

	Arnd

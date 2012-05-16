From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 May 2012 08:53:42 +0200
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20120516053301.GB21517@S2100-06.ap.freescale.net>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
Message-ID: <20403.20214.297216.188300@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Tue, May 15, 2012 at 09:17:50AM +0200, Lothar Wa?mann wrote:
> > This will blow up in your face when calling bgpio_init() without any
> > direction register (which is well supported by the generic driver).
> > 
> > You need to do this in the platform specific driver that uses the
> > generic driver. See gpio-mxc.c for reference:
> > |        err = bgpio_init(&port->bgc, &pdev->dev, 4,
> > |                         port->base + GPIO_PSR,
> > |                         port->base + GPIO_DR, NULL,
> > |                         port->base + GPIO_GDIR, NULL, false);
> > |        if (err)
> > |                goto out_iounmap;
> > |
> > |        port->bgc.gc.to_irq = mxc_gpio_to_irq;
> > |        port->bgc.gc.base = pdev->id * 32;
> > |        port->bgc.dir = port->bgc.read_reg(port->bgc.reg_dir);
> > |        port->bgc.data = port->bgc.read_reg(port->bgc.reg_set);
> > 
> Ah, thanks for the info.  I did not know that we ran into the issue
> on gpio-mxc and had it fixed there.  But instead of asking every
> single platform gpio driver to do the fixup, we should really fix it
> in generic driver.  Imaging if you fixed the issue in gpio-generic
> when you ran into the problem on MXC/IMX, I wouldn't have spent half
> day to track the issue down on MXS :)
> 
> So back to the right fixing, does the following one look good to you?
> 
> @@ -394,6 +394,10 @@ int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
>                 return ret;
> 
>         bgc->data = bgc->read_reg(bgc->reg_dat);
> +       if (bgc->gc.set == bgpio_set_set)
> +               bgc->data = bgc->read_reg(bgc->reg_set);
> +       if (bgc->reg_dir)
> +               bgc->dir = bgc->read_reg(bgc->reg_dir);
> 
>         return ret;
>  }
> 
That might change the behaviour of existing implementations.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

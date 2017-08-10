From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Aug 2017 19:10:34 +0200
Subject: linux-next 2017-08-08 keyboard failure on Nokia N900
In-Reply-To: <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
References: <20170808101756.GA12922@amd> <20170808103444.GA18247@amd>
 <20170808111243.GA20328@amd>
 <61264d43-eda3-df9d-0c06-28611f373ce7@ti.com>
Message-ID: <20170810171034.GA26019@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> I tried today's linux-next. It boots on n900 (up to X), but then my
> >>> screen locks and I can't get back. Touchscreen worked, so my guess is
> >>> keyboard does not...? Ssh connection over usb still works.
> >>
> >> Confirmed, its the keyboard.
> >>
...
> > [    0.682769] twl4030_madc 48070000.i2c:twl at 48:madc: could not
> > request irq
> > [    0.684051] twl4030_madc: probe of 48070000.i2c:twl at 48:madc failed
> 
> I've not precisely checked it, but smth is telling me that below 
> patch  can cause this:
> 
> commit 78daaca78ee57dead0f4aa5ee399f0499e81cd9e
...
>  int twl4030_init_irq(struct device *dev, int irq_num)
>  {
> -       static struct irq_chip  twl4030_irq_chip;
> +       struct irq_chip twl4030_irq_chip;
> 
> 
> but if we will look at code - it can be seen that this variable is passed by reference to
> irq_set_chip_and_handler(). 
> Ops. And what will happen when twl4030_init_irq() returns ;)

Thanks, this would take me a while to figure out. I'm testing
next-..-08-10, which should have this fixed... and yes, it does.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/ebae63d6/attachment.sig>

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Jan 2013 20:58:54 +0100
Subject: [PATCH 3.9 1/3] misc: new driver for GPIO-connected 7-segment
 displays
In-Reply-To: <201301071943.40074.arnd@arndb.de>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357576928-29133-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301071943.40074.arnd@arndb.de>
Message-ID: <20130107205854.1f019816@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 7 Jan 2013 19:43:39 +0000, Arnd Bergmann wrote:

> >  .../devicetree/bindings/misc/gpio-7seg.txt         |   18 +++
> >  drivers/misc/Kconfig                               |   13 ++
> >  drivers/misc/Makefile                              |    1 +
> >  drivers/misc/gpio-7seg.c                           |  168 ++++++++++++++++++++
> 
> I wonder if it would make sense to merge this into the LED subsystem
> rather than having it as a standalone driver.

Hum, maybe. How do you see it fitting inside the LED subsystem? The
purpose of the device is quite different in its userspace to kernel
interface, no?

> > diff --git a/Documentation/devicetree/bindings/misc/gpio-7seg.txt b/Documentation/devicetree/bindings/misc/gpio-7seg.txt
> > new file mode 100644
> > index 0000000..107d178
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/gpio-7seg.txt
> > @@ -0,0 +1,18 @@
> > +* 7-segment driver connected over GPIO through a BCD decoder
> > +
> > +Required properties:
> > +- compatible: "generic,gpio-7seg"
> > +- gpios: list of GPIOs to use to control the 7-segment display
> 
> Maybe list the minimum and maximum number of gpio lines here?

Indeed. Seems like it should be anywhere between 0 and 32 GPIOs.

> > +	sdev->dev_attr.attr.name = "value";
> > +	sdev->dev_attr.attr.mode = S_IRUGO | S_IWUGO;
> > +	sdev->dev_attr.show = gpio_7seg_show;
> > +	sdev->dev_attr.store = gpio_7seg_store;
> 
> Any reason why you are not using the DEVICE_ATTR macro?

DEVICE_ATTR declares the structure, and I wanted one per gpio_7seg
device, which is dynamically allocated, so I thought that using
DEVICE_ATTR was not possible. But now that you point this, I realize
that I was stupid. I can perfectly live with one single global 'struct
device_attribute' that I register to several devices using
device_create_file(), no?

That said, is it worth the effort to continue polishing this driver,
after seeing the feedback from Greg about it? I don't mind working on
it more and fix the problems of course, but if the general answer is
that we don't want such a driver in the kernel, then I'd better not
spend more time on this.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

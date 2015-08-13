From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 13 Aug 2015 15:28:13 +0200
Subject: [PATCH 2/6] gpio: Introduce gpio descriptor 'name'
In-Reply-To: <CACRpkdYv=-fCj+ts9tTmFsovPN0RPYkOdYh9Dj6oFDJiRV=RUA@mail.gmail.com>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-3-git-send-email-mpa@pengutronix.de>
 <CACRpkdYv=-fCj+ts9tTmFsovPN0RPYkOdYh9Dj6oFDJiRV=RUA@mail.gmail.com>
Message-ID: <20150813132813.GX19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 11:37:06AM +0200, Linus Walleij wrote:
> On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > The latest gpio hogging mechanism assigns each gpio a 'line-name' in the
> > devicetree. The 'name' field is different from the 'label' field.
> > 'label' is only used for requested GPIOs to describe its current use by
> > driver or userspace.
> >
> > The 'name' field describes the GPIO itself, not the use. This is most
> > likely identical to the label in the schematic on the GPIO line and
> > should help to find this particular GPIO.
> >
> > This patch adds a helper function to find gpio descriptors by name
> > instead of gpio number.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> Oh I realized there is a big problem with this.
> 
> struct gpio_chip already contains this:
> 
>         const char              *const *names;
> 
> Now it seems like names can be stored in two places:
> in an array in the gpio_chip and in a name tag in struct
> gpio_desc.
> 
> So how do we handle this?
> 
> I guess we need to keep just *one* of them, so maybe remove
> the names array from the struct gpio_chip and add a helper function
> that sets the names on the descs for the lines like:
> 
> int gpiochip_set_names(struct gpio_chip *gc, const char * const names);
> 
> And then refactor all code and chips that use the old names
> array to use this instead. I don't think they are too many, really.

That sounds good. There are just a few users of this names array, so it
should all be fine.

Just to clarify: The line names will then be the same as this name
array? So all GPIOs with name/line-names are then exported by their name
and not the number?

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/240de3a7/attachment-0001.sig>

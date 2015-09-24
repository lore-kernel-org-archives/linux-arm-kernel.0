From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 24 Sep 2015 08:39:31 +0200
Subject: [PATCH v2 2/3] gpiolib: gpiod_hog remove separate name argument
In-Reply-To: <CACRpkdZrXEXtkPpgtrcjqP5jD+M0UOj5Wj69o4zYJQKihsY6Xg@mail.gmail.com>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-3-git-send-email-mpa@pengutronix.de>
 <CACRpkdZrXEXtkPpgtrcjqP5jD+M0UOj5Wj69o4zYJQKihsY6Xg@mail.gmail.com>
Message-ID: <20150924063931.GS32203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 21, 2015 at 04:28:48PM -0700, Linus Walleij wrote:
> On Sun, Aug 30, 2015 at 12:44 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > The gpio name is now stored in the gpio descriptor, so we can simply use
> > that instead of an argument to the function.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> Several problems with this patch:
> 
> - Does not apply to v4.3-rc1

Yes, a bit older already, will rebase it.

> - Fixed that but noted that it just alters the call to gpiod_hog()
>   in of_gpiochip_scan_hogs(), there is a local const char *name that
>   should be removed too.

The local const char *name is temporarily used in
of_gpiochip_scan_hogs() to get the name from DT and assign it to the
descriptor:
	desc = of_parse_own_gpio(np, &name, &lflags, &dflags);
	...
	else
		desc->name = name;

> - Looking at of_get_gpio_hog() it is unclear to me that .name
>   is set in the gpio_desc as desired. Please check this.
> 
>   Crucial code looks like this:
> 
>     if (name && of_property_read_string(np, "line-name", name))
>         *name = np->name;

of_get_gpio_hog() only parses the properties of the DT. It does not
assign any properties to the descriptor itself. So I kept it this way
and added the code for assignment to of_gpiochip_scan_gpios.

> 
>   i.e. is the line-name really propagated to gpiod->name?
>   Are you sure you have tested this with a DTS using line-name
>   and verified that it propagates properly?

Yes this is tested and works for me. I am using the two series together
without problems.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/4293446e/attachment.sig>

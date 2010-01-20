From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed, 20 Jan 2010 19:13:41 +0100
Subject: [PATCH] otg Kconfig: add missing select USB_OTG_UTILS to	USB_ULPI
	option
In-Reply-To: <20100118084622.GA15054@pengutronix.de>
References: <1263576731-26075-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100118084622.GA15054@pengutronix.de>
Message-ID: <4B5747D5.9080104@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

Uwe Kleine-K?nig wrote:
> Hello Valentin,
> 
> On Fri, Jan 15, 2010 at 06:32:11PM +0100, Valentin Longchamp wrote:
>> Fixes a link error for mx3 platforms with ULPI host devices enabled. Should go for rc5 since it completes http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f9ffaa9ca9889f17ef30b82bc0bf954d141280f8 that was introduced in rc4.
> Actually I think this is a seperate issue.  f9ffaa9ca fixed arch code to
> only use ULPI if it is configured to be available, your patch asserts
> that the code is built-in for arch code if configured.

It is separate issue, but it is a direct sequel to that patch. And with 
the current usage and code, the code must be built-in for arch code.
> 
> The problem is that with CONFIG_USB_ULPI=y + CONFIG_USB<=m +
> CONFIGPCI=n + CONFIG_USB_OTG_UTILS=n drivers/usb/otg/ulpi.o isn't built-in.

Yeah, but that's how it is used now with all the platforms using 
USB_ULPI (meaning some mx31 platforms).

> 
> So there are several ways to fix it:
> 
>  - let CONFIG_USB_ULPI depend on CONFIG_USB_OTG_UTILS (as done here).
>    As drivers/Makefile has:
> 
> 	obj-$(CONFIG_USB_OTG_UTILS)     += usb/otg/
> 
>    this works fine.  The downside is that CONFIG_USB_ULPI doesn't really
>    depend on CONFIG_USB_OTG_UTILS.
> 
>  - add to drivers/Makefile
> 
> 	obj-$(CONFIG_USB_ULPI) += usb/otg/
> 
>    .  That's not pretty.
> 
>  - rework the code that arch code doesn't need functions provided by
>    drivers/usb/otg/ulpi.c.  That's my favorite, but probably needs some
>    work.

How would you achieve this ? I see a contradiction in the current status 
  of the code where the otg_transceiver struct sometimes needs some 
functions that are generic (ULPI) or platform specific (with isp1105 
serial transceiver for instance).

One way to do it would be add (a lot !) more fields in the 
mxc_usbh_platform_data struct so that the otg_transceiver can then be 
intialized in the ehci_mxc_drv_probe. How does this sound ?

> 
>  - extend Kconfig to have something like builtin-if-configured-modular.
>    Then we could have:
> 
> 	builtin-$(CONFIG_USB_ULPI) += ulpi.o
> 
>    in drivers/usb/otg/Makefile resulting in ulpi.o being linked into
>    drivers/builtin.o even though drivers/usb wouldn't be considered for
>    building in.
> 
>    Would be nice, but this looks more like a long-term-project.

Yeah, too long term and far beyond my scope of competencies.

> 
> That doesn't mean I'm against Valentin's patch, but IMHO the commit log
> should at least contain the breaking config (i.e. CONFIG_USB_ULPI=y +
> CONFIG_USB<=m + CONFIG_PCI=n + CONFIG_USB_OTG_UTILS=n) and the resulting
> error (message).
> 

I will change the commit log so that it contains this, and this will 
allow 2.6.33 to build correctly for mx3 platforms with USB host 
peripherals, while maybe we implement the above discussed solution.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne

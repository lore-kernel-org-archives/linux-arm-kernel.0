From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 00:53:53 -0700
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130731123351.GA30474@kroah.com>
References: <20130731073802.GT7656@atomide.com>
 <20130731123351.GA30474@kroah.com>
Message-ID: <20130802075352.GY7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Greg KH <greg@kroah.com> [130731 05:39]:
> On Wed, Jul 31, 2013 at 12:38:03AM -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > Probably the biggest kernel data bloat issue is in the ARM land, but
> > it also seems that it's becoming a Linux generic issue too, so I
> > guess it could be discussed in either context.
> 
> Why is it specific to ARM?  What is so unique to ARM that causes it to
> "bloat"?

I think it has so far showed up on ARM because of no discoverable busses,
but chances are it will be more of a generic problem.

> And what exactly do you mean by "bloat"?

Stuffing data to kernel that should not be in the kernel at all. Or
if the data is needed by kernel, there should be only one set of the
data defined rather than multiple copies of the data built into the
kernel for each SoC or driver variant.

> > Basically the data bloat issue is there for the arch code and drivers
> > and may not show up initially until things have headed the wrong way for
> > too long.
> 
> What do you mean by this?  You seem to be very vague here.

People are unnecessarily defining registers in kernel for similar devices
over and over again for each new SoC at the arch level and now more and
more at the driver level.

One example of that are device tree based drivers that don't describe
the actual hardware, but instead have a binding that points to an index
of defined registers in the driver.

One way to avoid these kind of bloat issues is to allow drivers to load
data at multiple points: Only abtolutely minimal set of data should be
static, some should only come from the bootloader as a device tree or
ACPI tables, and some is best to be loaded after booting from /lib/firmware.

Regards,

Tony

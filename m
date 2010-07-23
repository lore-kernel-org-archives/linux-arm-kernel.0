From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 23 Jul 2010 23:03:47 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
	<20100723141712.GC12300@rakim.wolfsonmicro.main>
	<61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
Message-ID: <20100723210347.GO20855@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Fri, Jul 23, 2010 at 08:38:50PM +0200, david at protonic.nl wrote:
> > Sometimes the bootloader code supplied with the BSP is
> > entertainingly baroque and discourages changes even if they are
> > technically possible.
>
> Well, I know one manufacturer delivering such a bootloader with their
> evaluation kit, but I'd never expect anyone to actually use that one
> in production!? Isn't it meant as a mere example?

That's theory. In practise, board vendors often just take what they got
from the chip vendor, hack around until it *somehow* boots and ship it.
Having worked on the Phytec cpu modules for the last years, we've even
seen that the vendors of the custom base boards reuse the machine number
of the eval kits, don't care about the error messages from the kernel
and ship.

And even if you try to make the bootloader high quality: ARM chip
manufacturers tend to keep lots of important errata secret. The i.MX
NAND controller has a bug which lets you interpret the wrong bits as the
factory bad block info - it took years until someone noticed, because it
just works (but with the wrong blocks marked as bad). This sort of bugs
often need bootloader fixes - but what do you do if you have some 100k
devices already shipped?

I second Russell's theroy: bootloaders cannot be trusted. That's why we
follow the pattern to init everything in Linux that's possible.

> Well, if you want to include _everything_ in the kernel, that's fine,
> but then don't use a bootloader, and set the rules accordingly.

People have done that. The downside is: The bootloader quite often is a
powerful debug tool during development. You can do things while Linux
and complexity stays out of the way. You can network boot quickly and
look into registers.

That's the reason why in the Barebox bootloader, we follow the paradigm
of supporting only what's necessary in the bootloader, and even for
that, we have Kbuild and can switch functionality on (during
development) and off (during production). If things have a reason for
being in the bootloader, they have a well defined place. We even have
modules, which makes it possible to fix issues in binary bootloaders
which have already been deployed into the field.

> > You need a mechanism to ensure all the engineers are applying
> > bootloader updates to their systems when required. It's not
> > insurmountable, but it's one more thing that needs doing.
>
> Sorry, I am still baffled at how that can be a problem... I mean they
> are engineers, developing a product together, right? I'll take your
> word, but I am surprised.

Please don't expect that large scale enterprise companies have the same
level of pragmatic professionalism which is standard in this community.

Quite often the people in the teams don't even know how to build their
components, because some people at the end of the world are responsible
for generating packets out of code, on a time scale of several weeks.
It's quite common to manage several thousands of requirements in highly
expensive Requirements Engineering tools, but not even the core
developers are able to build the same code out of some SCM repository.

> In the light of that, linux bootling linux seems a smart thing to do.
> Makes me think of RedBoot, which is the HAL from eCos (which once was
> Linux, remember) and a bootloader on top of that.

That's theory. RedBoot is so ... 90ies that it actually hurts. If you
want something that feels familiar for a Linux developer, use Barebox.

kexec is a good idea only in theory. Last time we tried it, it needed
something like 6 s additional boot time. Inacceptable - we bring Qt
based GUI systems into the application in 6 s, and automotive systems
into userspace in 336 ms. Not to mention that the first kernel needs to
be brought up as well.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

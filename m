From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Aug 2012 22:43:23 +0100
Subject: [PATCH 4/4] [RFC] ARM: treewide: manually change more
 mach-*/*.h includes
In-Reply-To: <201208221301.19439.arnd@arndb.de>
References: <201208221253.07278.arnd@arndb.de>
 <201208221301.19439.arnd@arndb.de>
Message-ID: <20120822214323.GA12255@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 01:01:19PM +0000, Arnd Bergmann wrote:
> These are lots of device drivers that include machine
> specific header files from ARM platforms and that are
> not easily scriptable. The changes have been found through
> manual inspection and should cause no visible changes
> because of the build script that maps the old names to the
> new ones.

And you end up missing a bunch of drivers in the process, such as the
sa1100 RTC driver which is shared between sa11x0 and PXA.  I wonder
how many of the Samsung platforms get broken by this as well...

In any case, what we _should_ be doing here as well is moving the headers
included by drivers for platform data out of the arch/arm/mach/ subtrees
and into include/linux/platform_data.  That will substantially reduce the
amount of mach/ headers to deal with.

Where I want this to get to is not a persistence of the existing crappy
situation where platforms stuff platform data definitions into arch/arm,
but instead put them in the right place.  That means providing them with
a good reason why the existing solution won't work, and not allowing
mach/ includes in drivers is a very good way to achieve that.

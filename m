From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 12 Jul 2011 12:13:08 -0500
Subject: [PATCH] new helper to define common struct resource constructs
In-Reply-To: <201107121529.17611.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107072304.05626.arnd@arndb.de>
	<E1QgHeh-0004k8-2m@octopus.hi.pengutronix.de>
	<201107121529.17611.arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383D6DAD4@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 12, 2011 6:29 AM, Arnd Bergmann wrote:
> On Monday 11 July 2011, Uwe Kleine-K?nig wrote:
>> resource definitions that just define start, end and flags = IORESOURCE_MEM
>> or IORESOURCE_IRQ (with start=end) are quite common. So introduce a shortcut
>> for them. Also make available a macro to specify named resources of both
>> types which are less common.
>> 
>> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> What do others think, is this worthwhile?

Assuming I found the correct patch in the archives, +1 from me.  Not sure what
the correct sign-off should be, possibly:

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> Should we also define macros for IORESOURCE_IO and IORESOURCE_DMA?

As a gross check, on linux-next I see:

$ git grep IORESOURCE_MEM | wc -l
3989
$ git grep IORESOURCE_IRQ | wc -l
2309
$ git grep IORESOURCE_IO | wc -l
687
$ git grep IORESOURCE_DMA | wc -l
521

The *_MEM and *_IRQ macros are going to have the largest impact on reducing
the lines of code.  But, for completeness it might be nice to have the *_IO
and *_DMA ones also.

If this patch is accepted there are a couple private macros in various places
that should probably be replaced or updated.

For instance in mach-nomadik/board-nhk8815.c and mach-nomadik/cpu-8815.c there
are these:

#define __MEM_4K_RESOURCE(x) \
	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}

And plat-omap/i2c.c has this:

#define I2C_RESOURCE_BUILDER(base, irq)			\
	{						\
		.start	= (base),			\
		.end	= (base) + OMAP_I2C_SIZE,	\
		.flags	= IORESOURCE_MEM,		\
	},						\
	{						\
		.start	= (irq),			\
		.flags	= IORESOURCE_IRQ,		\
	},

I seem to recall seeing others but can't remember exactly where.

Regards,
Hartley

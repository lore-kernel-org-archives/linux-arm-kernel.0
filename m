From: dilinger@queued.net (Andres Salomon)
Date: Fri, 4 Feb 2011 02:16:41 -0800
Subject: [PATCH 15/19] mc13xxx: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110204093458.GH30452@pengutronix.de>
References: <20110202195417.228e2656@queued.net>
	<20110202202015.0fe392a9@queued.net>
	<20110204093458.GH30452@pengutronix.de>
Message-ID: <20110204021641.4f7fc66a@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Feb 2011 10:34:58 +0100
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Andres,
> 
> On Wed, Feb 02, 2011 at 08:20:15PM -0800, Andres Salomon wrote:
> > 
> > No need to explicitly set the cell's platform_data/data_size.
> > 
> > In this case, move the various platform_data pointers
> > to driver_data.  All of the clients which make use of it
> > are also changed.
> > 
> > Mfd-core makes a copy of platform_data, but driver_data keeps a
> > pointer to the original data.  Because each cell's platform_data
> > previously pointed to a local (stack) variable, the various ARM
> > mach types that set the pdata are updated to keep the memory around.
> I didn't get this even after reading it 5 times.  You wrote in the
> subject that drivers now have access to mfd_cell.  I don't see where
> e.g. drivers/leds/leds-mc13783.c uses that?!  Does this depend on some
> mfd-changes I don't see and this is just a first step?
> 
> After reading the changes I think I understood:
> 
>  - You made things that were passed as platform_data before available
>    via driver_data.

Right.  And as someone pointed out, this doesn't really work as well as
I'd hoped, so I'll have to refine my approach.  Ideally, something
simpler..


>  - Because platform_data is copied and driver_data is not at register
>    time, the data being platform_data cannot be __initdata or stack
>    local anymore, so this needs fixing.
> 
> In sum this results in .data becoming bigger (which is bad).
> 
> And I think this patch has a conceptual problem, too.  In my opionion
> platform_data is the point to hand over platform specific data to a
> driver.  driver_data is something that is private to the driver and
> has to be considered opaque for the platform.  The driver was sort of
> OK before ...


I'll be sending updated patches once I've reworked things.

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 23:19:03 +0100
Subject: [PATCH V2] dma: tegra: register as an OF DMA controller
In-Reply-To: <CAPcyv4giXy++b6BJi8nNKEEY8PC-_4ATAH0_bN-YSOVH+8CaLw@mail.gmail.com>
References: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
 <201312040222.03604.arnd@arndb.de>
 <CAPcyv4giXy++b6BJi8nNKEEY8PC-_4ATAH0_bN-YSOVH+8CaLw@mail.gmail.com>
Message-ID: <201312062319.03939.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Dan Williams wrote:
> * nod.
> 
> I have a similar reaction to dma_request_channel().  There should be
> more than enough use case to find some common ground and reduce the
> need for magic filter routines.

Right. I didn't really like the addition of the _compat variant, though
I can see how it helps drivers that are transitioning from pdata to
DT probing. Once we have progressed enough with the ARM DT conversion,
a lot of those can surely be converted back to plain 
dma_request_slave_channel(), and if a significant number remain that
won't use DT, we can come up with a way to use the same interface
using the equivalent of clkdev to connect devices to request lines.

Also, once things have cooled down a little, we can do a mass-conversion
to the ERR_PTR variant and kill off the ones that just return NULL
on error.

Looking at the slave drivers that use the old dma_request_channel(),
I see these classes that are not moving to DT:

* Atmel arch/avr32 (some shared with ARM mach-at91, using DT there)
* Renesas arch/sh (some shared with ARM shmobile, using DT there)
* x86 topcliff/PCH
* mfd/timberdale
* ARM ep93xx, sa11x0

The other ones are all ARM or PowerPC platforms that should migrate
to describing their DMA channels in DT in the future and kill their
filter functions.

	Arnd

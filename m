From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 10 Nov 2010 08:14:30 -0800
Subject: [PATCH v3 13/13] OMAP: PM: DMA: Enable runtime pm
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC1@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Wed, 10 Nov 2010 19:32:19 +0530")
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-14-git-send-email-manjugk@ti.com>
	<87fwvajepy.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC1@dbde02.ent.ti.com>
Message-ID: <871v6tdul5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> 
>> > Enable runtime pm and use pm_runtime_get and pm_runtime_put
>> > for OMAP DMA driver.
>> >
>> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>> > Cc: Benoit Cousson <b-cousson@ti.com>
>> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > ---
>> >  arch/arm/plat-omap/dma.c |   13 +++++++++++++
>> >  1 files changed, 13 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> > index 41b14b0..feac7ee 100644
>> > --- a/arch/arm/plat-omap/dma.c
>> > +++ b/arch/arm/plat-omap/dma.c
>> > @@ -35,6 +35,7 @@
>> >  #include <linux/io.h>
>> >  #include <linux/slab.h>
>> >  #include <linux/delay.h>
>> > +#include <linux/pm_runtime.h>
>> >  
>> >  #include <asm/system.h>
>> >  #include <mach/hardware.h>
>> > @@ -367,6 +368,8 @@ int omap_request_dma(int dev_id, const 
>> char *dev_name,
>> >  	chan = dma_chan + free_ch;
>> >  	chan->dev_id = dev_id;
>> >  
>> > +	pm_runtime_get(&pd->dev);
>> 
>> The _get() call is asynchronous.  So if the device was actually
>> idled/disabled, immediately after this call it may still be
>> idle/disabled.   When using the asynchronous versions of the API, the
>> device should not be touched until the driver's ->runtime_resume()
>> callback is called.
>
> driver runtime_resume will call omap_device_enable. How do we make 
> we check from driver side, whether omap_device_enable execution is complete
> or not.

It is complete when the driver's runtime_resume hook is called.  The
OMAP runtime PM core calls omap_device_enable() before calling the
driver's callback.  See arch/arm/mach-omap2/pm_bus.c for details.

Alternatively, just use _get_sync() which doesn't return until the
device is ready.

Kevin

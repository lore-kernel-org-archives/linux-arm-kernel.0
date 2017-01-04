From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 04 Jan 2017 10:19:46 +0100
Subject: [PATCH v2 2/2] arm: perf: Mark as non-removable
In-Reply-To: <20161222224547.GA30170@remoulade>
References: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
 <20161221150340.25657-3-alexander.stein@systec-electronic.com>
 <20161222224547.GA30170@remoulade>
Message-ID: <2559413.O5mI12kdOo@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 22 December 2016 22:48:32, Mark Rutland wrote:
> On Wed, Dec 21, 2016 at 04:03:40PM +0100, Alexander Stein wrote:
> > This driver can only built into the kernel. So disallow driver bind/unbind
> > and also prevent a kernel error in case DEBUG_TEST_DRIVER_REMOVE is
> > enabled.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> > 
> >  arch/arm/kernel/perf_event_v7.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/kernel/perf_event_v7.c
> > b/arch/arm/kernel/perf_event_v7.c index b942349..795e373 100644
> > --- a/arch/arm/kernel/perf_event_v7.c
> > +++ b/arch/arm/kernel/perf_event_v7.c
> > @@ -2029,6 +2029,7 @@ static int armv7_pmu_device_probe(struct
> > platform_device *pdev)> 
> >  static struct platform_driver armv7_pmu_driver = {
> >  
> >  	.driver		= {
> >  	
> >  		.name	= "armv7-pmu",
> > 
> > +		.suppress_bind_attrs = true,
> > 
> >  		.of_match_table = armv7_pmu_of_device_ids,
> >  	
> >  	},
> 
> While this patch looks correct, the other perf_event_* drivers (e.g. those
> under arch/arm/) will need similar treatment.

Yep, but this is the only one I can actually test.

> More generally, updating each and every driver in this manner seems like a
> scattergun approach that is tiresome and error prone.
> 
> IMO, it would be vastly better for a higher layer to enforce that we don't
> attempt to unbind drivers where the driver does not have a remove callback,
> as is the case here (and I suspect most over cases where
> DEBUG_TEST_DRIVER_REMOVE is blowing up).

You mean something like this?
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 4eabfe2..3b6c1a2d 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -158,6 +158,9 @@ int driver_register(struct device_driver *drv)
> 
>                 printk(KERN_WARNING "Driver '%s' needs updating - please use
>                 "
>                 
>                         "bus_type methods\n", drv->name);
> 
> +       if (!drv->remove)
> +               drv->suppress_bind_attrs = true;
> +
> 
>         other = driver_find(drv->name, drv->bus);
>         if (other) {
>         
>                 printk(KERN_ERR "Error: Driver '%s' is already registered, "

> Is there any reason that can't be enforced at the bus layer, say?

I'm not sure if the change above works with remove functions set in struct 
bus_type too.
But on the other hand this would hide errors in drivers which are actually 
removable but do not cleanup properly which DEBUG_TEST_DRIVER_REMOVE tries to 
detect. By setting .suppress_bind_attrs = true explicitely you state "This 
driver cannot be removed!", so the remove callback is not missing by accident.

Best regards,
Alexander

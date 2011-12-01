From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 1 Dec 2011 11:25:10 +0000
Subject: [RFC PATCH 01/11] arm:omap:am33xx: Add voltage domain data
In-Reply-To: <87ipm1w3pz.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <1321809555-13833-2-git-send-email-hvaibhav@ti.com> <87ipm1w3pz.fsf@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8047586@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, December 01, 2011 5:41 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; paul at pwsan.com; linux-
> arm-kernel at lists.infradead.org; Cousson, Benoit; Mohammed, Afzal
> Subject: Re: [RFC PATCH 01/11] arm:omap:am33xx: Add voltage domain data
> 
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > Currently dummy voltage domain data is being created
> > in order to succeed boot process.
> > Nothing has been done w.r.t actual hardware (voltage control).
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> [...]
> 
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/voltagedomains33xx_data.c
> > @@ -0,0 +1,37 @@
> > +/*
> > + * AM33XX voltage domain data
> > + *
> > + * Copyright (C) 2011 Texas Instruments, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +
> > +#include "voltage.h"
> > +
> > +static struct voltagedomain am33xx_voltdm_mpu = {
> > +	.name = "mpu",
> > +};
> 
> According to the TRM, there is no MPU voltage domain.  Only CORE and RTC
> exist.
> 
> However, looking at the data manual (SPRS717 Oct 2011), it seems that
> some packages have a separate VDD_MPU while others have a combined
> VDD_MPU and VDD_CORE.
> 
> This should be clarified and documented in the changelog.
> 


No, we do have VDD_MPU specifically documented in TRM (SPRUH73 - October2011).

The TRM is accessible at - http://www.ti.com/lit/ug/spruh73/spruh73.pdf


> > +static struct voltagedomain am33xx_voltdm_core = {
> > +	.name = "core",
> > +};
> > +
> > +static struct voltagedomain am33xx_voltdm_rtc = {
> > +	.name = "rtc",
> > +};
> 
> Won't these basically empty voltage domains fail during voltage init?
> At a minimum, it seems they should have '.scaling = false' as well until
> voltage scalling is supported.
> 

It won't fail, but I agree to your point that we should clearly specify
the state here.
I will add ".scaling = false" in next version.

Thanks a ton for the review.

Thanks,
Vaibhav

> > +static struct voltagedomain *voltagedomains_am33xx[] __initdata = {
> > +	&am33xx_voltdm_mpu,
> > +	&am33xx_voltdm_core,
> > +	&am33xx_voltdm_rtc,
> > +	NULL,
> > +};
> > +
> > +void __init am33xx_voltagedomains_init(void)
> > +{
> > +	voltdm_init(voltagedomains_am33xx);
> > +}
> 
> Kevin

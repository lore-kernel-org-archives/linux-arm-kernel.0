From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 15 Dec 2010 10:39:19 -0600
Subject: [PATCH 13/14] OMAP2/3: PRCM: split OMAP2/3-specific PRCM code
	into OMAP2/3-specific files
In-Reply-To: <alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012516.3708.87606.stgit@twilight.localdomain>
	<alpine.DEB.2.00.1012142147040.15971@utopia.booyaka.com>
Message-ID: <AANLkTikhp8157yegSb1G3gXAxF_SLo0Q1OEgsf2Bt0Cm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 10:50 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi,
>
> On Mon, 6 Dec 2010, Paul Walmsley wrote:
>
>> In preparation for adding OMAP4-specific PRCM accessor/mutator
>> functions, split the existing OMAP2/3 PRCM code into OMAP2/3-specific
>> files. ?Most of what was in mach-omap2/{cm,prm}.{c,h} has now been
>> moved into mach-omap2/{cm,prm}2xxx_3xxx.{c,h}, since it was
>> OMAP2xxx/3xxx-specific.
>>
>> This process also requires the #includes in each of these files to be
>> changed to reference the new file name. ?As part of doing so, add some
>> comments into plat-omap/sram.c and plat-omap/mcbsp.c, which use
>> "sideways includes", to indicate that these users of the PRM/CM includes
>> should not be doing so.
>
> This patch has been updated to also take care of getting DSPBridge to
> build again. ?Omar, Felipe, could you please take a look at the
> mach-omap2/dsp.c and _tiomap.h changes and ack them?
...
> diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
> index 6feeeae..a8b62d7 100644
> --- a/arch/arm/mach-omap2/dsp.c
> +++ b/arch/arm/mach-omap2/dsp.c
> @@ -9,11 +9,16 @@
> ?* This program is free software; you can redistribute it and/or modify
> ?* it under the terms of the GNU General Public License version 2 as
> ?* published by the Free Software Foundation.
> + *
> + * XXX The function pointers to the PRM/CM functions are incorrect and
> + * should be removed. ?No device driver should be changing PRM/CM bits
> + * directly; that's a layering violation -- those bits are the responsibility
> + * of the OMAP PM core code.
> ?*/
>
> ?#include <linux/platform_device.h>
> -#include "prm.h"
> -#include "cm.h"
> +#include "cm2xxx_3xxx.h"
> +#include "prm2xxx_3xxx.h"
> ?#ifdef CONFIG_BRIDGE_DVFS
> ?#include <plat/omap-pm.h>
> ?#endif

I don't have a preference, I guess part of the license header makes
them even more noticeable.

> diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/staging/tidspbridge/core/_tiomap.h
> index 1c1f157..7fac488 100644
> --- a/drivers/staging/tidspbridge/core/_tiomap.h
> +++ b/drivers/staging/tidspbridge/core/_tiomap.h
> @@ -21,6 +21,12 @@
>
> ?#include <plat/powerdomain.h>
> ?#include <plat/clockdomain.h>
> +/*
> + * XXX These mach-omap2/ includes are wrong and should be removed. ?No
> + * driver should read or write to PRM/CM registers directly; they
> + * should rely on OMAP core code to do this.
> + */
> +#include <mach-omap2/cm2xxx_3xxx.h>
> ?#include <mach-omap2/prm-regbits-34xx.h>
> ?#include <mach-omap2/cm-regbits-34xx.h>
> ?#include <dspbridge/devdefs.h>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Just in case someone is wondering, there is a plan to use hwmod and
move start/stop/monitor functions to dsp.c code, so, the driver can
call them through pdata.

Regards,

Omar

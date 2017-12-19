From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Tue, 19 Dec 2017 15:21:19 +0000
Subject: [PATCH v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20171219144802.GA4534@kroah.com>
References: <20171129100844.19874-1-laurentiu.tudor@nxp.com>
 <20171219144802.GA4534@kroah.com>
Message-ID: <5A392E3A.6040303@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/19/2017 04:48 PM, Greg KH wrote:
> On Wed, Nov 29, 2017 at 12:08:44PM +0200, laurentiu.tudor at nxp.com wrote:
>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>
>> Move the source files out of staging into their final locations:
>>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>>    -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>>    -README.txt, providing and overview of DPAA goes to
>>     Documentation/dpaa2/overview.txt
>>
>> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
>> Update dpaa2_eth and dpio staging drivers.
>>
>> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> Notes:
>>      -v4:
>>        - regenerated patch with renames detection disabled (Andrew Lunn)
>>      -v3:
>>        - rebased
>
> Ok, meta-comments on the structure of the code.
>
> You have 8 .h files that are "private" to your bus logic.  That's 7 too
> many, some of them have a bigger license header than actual content :)
>
> Please consolidate into 1.
>
> Also, the headers should be moved to SPDX format to get rid of the
> boilerplate.  I _think_ it's BSD/GPL, right?  Hard to tell :(

It's 3-clause BSD and GPLv2. Will make it clear when moving to SPDX.

>
> Your "public" .h file does not need to go into a subdirectory, just name
> it fsl-mc.h and put it in include/linux/.

There's already a "fsl" subdirectory in include/linux/ so it seemed to 
make sense to use it.

> One comment on the fields in your .h file, all of the user/kernel
> crossing boundry structures need to use the "__" variant of types, like
> "__u8" and the like.  You mix and match them for some reason, you need
> to be consistent.
>
> Also, what's up with the .h files in drivers/staging/fsl-bus/include?
> You didn't touch those with this movement, right?  Why?

Those are not part of the bus "core". Some of them are part of the DPBP 
and DPCON device types APIs and are used by drivers probing on this bus 
and the rest are part of the DPIO driver which is also used by other 
drivers. Since these devices (DPBP, DPCON, DPIO) are interfaces used by 
all the other drivers it made sense to group them together with the bus.

> For this initial move, only move the bus "core" code out, not the other
> stuff like:
>
>>   drivers/irqchip/Makefile                           |   1 +
>>   drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c        | 119 +++
>
> these should be a separate file move, right?

This bus uses msi interrupts and this file contains glue code needed to 
enable interrupts in the GICv3 irqchip. Without this I don't think the 
bus driver can work because itself makes use of interrupts.

>>   drivers/staging/fsl-dpaa2/ethernet/README          |   2 +-
>
> Why does a README file for a different driver need to be touched?

It mentions a file in the old location of the bus. This is how the diff 
looks:

-       drivers/staging/fsl-mc/README.txt
+       Documentation/dpaa2/overview.txt


>>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   2 +-
>>   drivers/staging/fsl-dpaa2/ethernet/dpni.c          |   2 +-
>>   drivers/staging/fsl-mc/README.txt                  | 386 ---------
>
> This file gets moved to the Documentation directory, yet it is not tied
> into the documentation build process, that's not good.

Will look into that.

> It doesn't need to have a separate directory either, right?

Agreed, maybe the destination directory isn't the best choice. Maybe 
bus-devices/fsl-mc.txt makes more sense? Can you please suggest?

> And speaking of documentation, you have directories in sysfs, yet no
> Documentation/ABI/ files describing them.  Please fix that up.

Hmm, I was under the impression that we did have sysfs documentation.
Will look into it.

> that's a good start :)

Yep. :)

---
Thanks & Best Regards, Laurentiu

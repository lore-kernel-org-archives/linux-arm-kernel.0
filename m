From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 20 Dec 2017 10:26:49 +0000
Subject: [PATCH v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20171219161045.GA18839@kroah.com>
References: <20171129100844.19874-1-laurentiu.tudor@nxp.com>
 <20171219144802.GA4534@kroah.com> <5A392E3A.6040303@nxp.com>
 <20171219152916.GA11279@kroah.com> <5A3932BF.80106@nxp.com>
 <20171219161045.GA18839@kroah.com>
Message-ID: <5A3A3AE6.6080905@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/19/2017 06:10 PM, Greg KH wrote:
> On Tue, Dec 19, 2017 at 03:39:44PM +0000, Laurentiu Tudor wrote:
>> On 12/19/2017 05:29 PM, Greg KH wrote:
>>> On Tue, Dec 19, 2017 at 03:21:19PM +0000, Laurentiu Tudor wrote:
>>>>
>>>>
>>>> On 12/19/2017 04:48 PM, Greg KH wrote:
>>>>> On Wed, Nov 29, 2017 at 12:08:44PM +0200, laurentiu.tudor at nxp.com wrote:
>>>>>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>>>>>
>>>>>> Move the source files out of staging into their final locations:
>>>>>>      -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>>>>>      -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>>>>>>      -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>>>>>>      -README.txt, providing and overview of DPAA goes to
>>>>>>       Documentation/dpaa2/overview.txt
>>>>>>
>>>>>> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
>>>>>> Update dpaa2_eth and dpio staging drivers.
>>>>>>
>>>>>> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
>>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>>> ---
>>>>>> Notes:
>>>>>>        -v4:
>>>>>>          - regenerated patch with renames detection disabled (Andrew Lunn)
>>>>>>        -v3:
>>>>>>          - rebased
>>>>>
>>>>> Ok, meta-comments on the structure of the code.
>>>>>
>>>>> You have 8 .h files that are "private" to your bus logic.  That's 7 too
>>>>> many, some of them have a bigger license header than actual content :)
>>>>>
>>>>> Please consolidate into 1.
>>>>>
>>>>> Also, the headers should be moved to SPDX format to get rid of the
>>>>> boilerplate.  I _think_ it's BSD/GPL, right?  Hard to tell :(
>>>>
>>>> It's 3-clause BSD and GPLv2. Will make it clear when moving to SPDX.
>>>
>>> Thanks.
>>>
>>>>> Your "public" .h file does not need to go into a subdirectory, just name
>>>>> it fsl-mc.h and put it in include/linux/.
>>>>
>>>> There's already a "fsl" subdirectory in include/linux/ so it seemed to
>>>> make sense to use it.
>>>
>>> Ah, missed that.  Ok, nevermind :)`
>>>
>>>>> One comment on the fields in your .h file, all of the user/kernel
>>>>> crossing boundry structures need to use the "__" variant of types, like
>>>>> "__u8" and the like.  You mix and match them for some reason, you need
>>>>> to be consistent.
>>>>>
>>>>> Also, what's up with the .h files in drivers/staging/fsl-bus/include?
>>>>> You didn't touch those with this movement, right?  Why?
>>>>
>>>> Those are not part of the bus "core". Some of them are part of the DPBP
>>>> and DPCON device types APIs and are used by drivers probing on this bus
>>>> and the rest are part of the DPIO driver which is also used by other
>>>> drivers. Since these devices (DPBP, DPCON, DPIO) are interfaces used by
>>>> all the other drivers it made sense to group them together with the bus.
>>>
>>> But all of these .h files are only used by the code in this specific
>>> directory, no where else.
>>
>> They are also used by our ethernet driver, see:
>>     drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
>
> Ick, really?  Then they should not be buried in a bus-specific
> location, but rather be in include/linux/SOMEWHERE, right?

Right. The goal is that in the end, all headers be moved to the already 
existing include/linux/fsl/. For now I've left these in staging because 
they are not part of the bus "core" infrastructure.

---
Best Regards, Laurentiu

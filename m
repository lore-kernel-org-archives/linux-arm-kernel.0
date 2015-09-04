From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 4 Sep 2015 06:00:06 +0200
Subject: [PATCH 15/16] mtd: mtdcore: fix initcall level
In-Reply-To: <55E68A72.30909@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
 <1440592108-3740-16-git-send-email-holler@ahsoftware.de>
 <20150901211938.GJ81844@google.com> <55E68A72.30909@ahsoftware.de>
Message-ID: <55E91746.4060502@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.09.2015 um 07:34 schrieb Alexander Holler:
> Am 01.09.2015 um 23:19 schrieb Brian Norris:
>> Hi Alexander,
>>
>> No judgment here for the rest of this series, but for this patch:
>>
>> On Wed, Aug 26, 2015 at 02:28:27PM +0200, Alexander Holler wrote:
>>> The mtd-core has to be initialized before other dependent mtd-drivers,
>>> otherwise a crash might occur.
>>>
>>> Currently mtd_init() is called in the initcall-level device, which is
>>> the
>>> same level where most mtd-drivers will end up. By luck this seemed to
>>> have
>>> been called most of the time before other mtd-drivers without having
>>> been
>>> explicitly enforced.
>>
>> I can't really speak for the original authors, but it does not appear to
>> be entirely "by luck." Link order was one of the de facto ways to get
>> this ordering (though it's not really a great one), and mtdcore was
>> always linked first within the drivers/mtd/ directory structure.
>>
>> But that's just background, I think this is worth fixing anyway. It
>> could, for instance, become a problem if drivers are located outside
>> drivers/mtd/; I see random board files in arch/ that register with MTD,
>> and I'm actually not sure how they have never tripped on this.
>
> I've already found at least a half a dozen other drivers with the same
> problem through my shuffling of the drivers which all end up in the
> standard initcall level device. I'm aware that this is based on the link
> order, which itself is based on linker behaviour (and maybe other things
> like make or other build tools). I'm just calling it luck, because this
> is nowhere explicitly stated, at least I've never seen such a statement,
> neither in any source, nor somewhere in Documentation. So I've choosen
> the term "by luck" in order to provoke a bit (or to stimulate a
> discussion about that widespread problem).

A good example why "luck" might not be far away from the truth is what 
happens when a drivers moves e.g. from staging to it's real position. 
Also the position will stay inside the same initcall level, the move of 
the driver into another directory (maybe together with a rename) will 
likely change its position in the initcall-sequence, without anyone 
really expecting this.

>>> But if mtd_init() is not called before a dependent
>>> driver, a null-pointer exception might occur (e.g. because the mtd
>>> device
>>> class isn't registered).
>>>
>>> To fix this, mtd-init() is moved to the initcall-level fs (right before
>>> the standard initcall level device).
>>
>> Is there a good reason we shouldn't just make this a subsys_initcall()?
>> That would match the naming better, and it mirrors what, e.g.,
>> block/genhd uses. It would also allow flexibility if there are other
>> current/future use cases that might need to sit between the subsystem
>> and the drivers.
>
> No real reason here. The names for the initcall levels seem to be
> outdated since a long time anyway, and I think just speaking about the
> numbers 1-7 (or 0-14) would be better anyways. The only reason why I've
> used the fs (sync) level is because I was too lazy to check out if
> mtdcore might depend on something else in any other level. Therefor I've
> used the one most close to were it was before.

Lazy was the wrong term. It is time consuming, cumbersome and therefor 
error-prone to check on what other stuff a driver depends. One reason 
why choosing the right place in the initcall sequence isn't that easy 
and why some automation make sense.

> Also I've an idea about how to fix that in general for all drivers (by
> using the same algorithm I've now introduced just for DT-based drivers
> with a device description). Wouldn't be that hard to use that for all
> drivers, but as I've written in a follow up to the introductory mail,
> one step after another.
>
> Regards,
>
> Alexander Holler

From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Apr 2015 11:04:14 -0700
Subject: Allowing reset controllers before SMP initialization (on ARM)?
In-Reply-To: <2592960.UsK4Hr7GSl@wuerfel>
References: <552F0786.2000505@gmail.com> <2592960.UsK4Hr7GSl@wuerfel>
Message-ID: <CAGVrzca2My1WfhQOR56A7rs16BbPCuH9h3-fGgV-HZ4b0MDUyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-16 1:04 GMT-07:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 15 April 2015 17:51:18 Florian Fainelli wrote:
>> Hi,
>>
>> In order to support initialization of the secondary core on BCM63138
>> SoCs, I would want to utilize a reset controller to release the
>> secondary CPU from reset [1].
>>
>> Here are multiple options:
>>
>> - expose a custom function which registers the reset controller platform
>> driver as early as possible, which is probably acceptable, but also
>> requires the DT machine descriptor to populate the platform bus earlier,
>> which we could completely avoid
>
> I think populating the platform bus earlier is not realistic, that
> would break lots of existing dependencies. In particular, we can't
> do it much earlier because it has to be done after the platform bus
> itself is instantiated.

Agreed, I don't quite like that either.

>
>> - have a OF_DECLARE_RESET_CONTROLLER() which is running fairly early
>> during boot, such that we can utilize reset controllers are early as
>> possible,  before any initcall level, and before SMP initialization is
>> kicking in
>
> We've added a couple of those, and it could be done here, but putting
> them in the right order is a bit tricky, and I think we can avoid it.

Right, not only that, but it appears that the reset controller binding
has not standardized a "reset-controller" property, so there is any
good way to scan for all these kinds of controllers in a given Device
Tree today, other than looking at a #reset-cells property
presence/absence.

>
>> - since the code that boots secondary CPUs is relatively unique, even
>> within the scope of the reset controllers (sequence involves touching
>> multiple registers), pulling it outside of the reset controller might be
>> acceptable (there is still some level of sharing though for low-level
>> indirect read/write operations)
>
> Yes, it's a hack, but the SMP code is rather special and a lot of
> other platforms do similar hacks already. What I'd like to see
> happen in the long run is more along the lines of:

Right, and even within the context of 63138, bringing-up the secondary
CPU is about 10 times more lines of code, specific to the CPU complex,
that are not even shared with the reset of the on-chip peripherals, so
I can probably stick the low-level routines in a header file and share
them with not too much gymnastic.

>
> - Avoid dependencies on the early SMP code, and just set up the
>   data structures for possible CPUs early, which can be done without
>   any hardware interaction. Then move the actual CPU enable path
>   much later in the boot process, possibly combined with the cpuidle
>   driver.

That sounds like a nice goal, I suppose that as we start standardizing
on the firmware interface to bring-up secondary cores, that might
become easier as well.

Thanks for your feedback!
-- 
Florian

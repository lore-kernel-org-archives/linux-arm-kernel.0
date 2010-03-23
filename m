From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 23 Mar 2010 18:31:11 -0500
Subject: [PATCH 0/2] arm: add a /proc/cpuinfo platform extension
In-Reply-To: <4BA94840.2030505@bluewatersys.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F377@mi8nycmail19.Mi8.com>
	<4BA924CD.1010201@bluewatersys.com>
	<0D753D10438DA54287A00B02708426976368E58561@AUSP01VMBX24.collaborationhost.net>
	<4BA93A43.2010807@bluewatersys.com>
	<0D753D10438DA54287A00B02708426976368E58719@AUSP01VMBX24.collaborationhost.net>
	<4BA94840.2030505@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B02708426976368E5877E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 23, 2010 4:01 PM, Ryan Mallon wrote:
>> I did a grep of glibc's source (cvs-2.9, the only one currently on my
>> system) to see what it tries to parse out of /proc/cpuinfo.  These are
>> the only ones I could find:
>
> According to Google Codesearch there are a few utilities around which
> read /proc/cpuinfo. I honestly don't know if any of them will break,
> though I suspect not. I think that seemingly innocent userspace API
> changes like this have broken things in the past though.

Fair enough.

>>>>> The other problem I see is that you have a single callback for registering
>>>>> the arch specific information. In you ep93xx example, each of the ep93xx
>>>>> boards must add:
>>>>>
>>>>>  .arch_cpuinfo = ep93xx_cpuinfo,
>>>>>
>>>>> If one of the boards has some additional information to make available,
>>>>> it would need to reimplement the entire callback, which gets messy.
>>>> Not necessarily.
>>>>
>>>> If a board, such as the ts72xx, wanted to add additional information
>>>> it just has to register it's private callback then call the ep93xx core
>>>> supplied callback at the desired point in it's private one.
>>>>
>>>> The ts72xx currently does this exact thing with the .map_io callback.
>>>> It supplies it's own private one to map the external FPGA.  It first calls
>>>> the ep93xx core to map the ahb/apb space then it does an iotable_init to
>>>> map the FPGA.
>>> Okay, fair point. I still don't like having the seq_file callback being
>>> in machine_desc. It means that all of the board files have to be edited
>>> to add the callback. It should be something which happens automagically
>>> in the platform core. Perhaps using a weak function for the callback, or
>>> a #define check.
>> 
>> The callback is copied from the machine_desc in arch/arm/kernel/setup.c
>> just like the other architecture-specific pointers.  If an architecture
>> does not have any additional data to dump they don't have to provide the
>> callback.  If it's not provided, the main seq_file callback (c_show in
>> arch/arm/kernel/setup.c) will not call it.  See Patch 1/3 of the series.
>
> My point was that you end up adding to the machine_desc for _every_
> board on the platform. In the ep93xx patch example the callback is the
> same in every case. It doesn't belong in machine_desc, which is the
> descriptor for a specific machine or board, it belongs to the platform
> (ie ep93xx), so it should be hidden from the board specific files unless
> they are providing extensions to the core arch info.

The same argument could be made for the .map_io and .init_irq callbacks as
well as the .timer pointer.

The .map_io call back is the same for every ep93xx platform, except for ts72xx
which needs to map it's external FPGA.  The .init_irq callback and the .timer
pointer are the same for all the existing ep93xx platforms.

The point being, they might start out the same now but I can see at least the
ts72xx one changing to dump the jumper settings provided by the external FPGA.

My out-of-tree init file also uses a private .arch_cpuinfo to dump some
information that is used by my user space applications to determine what
features are available.

Also, if a platform maintainer decides that the extra information is of no
use on their platform, they don't need to provide the callback.

Regards,
Hartley

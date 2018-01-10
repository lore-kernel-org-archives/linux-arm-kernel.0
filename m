From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 10 Jan 2018 21:54:29 +0000
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
 <20171116193145.s2nja2kfevjxlnt5@pd.tnic>
Message-ID: <121880e53de2408f9699bb04b9caf2b9@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 17/11/17 08:32, Borislav Petkov wrote:
> On Fri, Nov 10, 2017 at 10:03:08AM +0100, Jan Luebbe wrote:
>> Add support for the ECC functionality as found in the DDR RAM and L2
>> cache controllers on the MV78230/MV78x60 SoCs. This driver has been
>> tested on the MV78460 (on a custom board with a DDR3 ECC DIMM).
>>
>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> 
> ...
> 
>> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
>> new file mode 100644
>> index 000000000000..cb9173b30aa9
>> --- /dev/null
>> +++ b/drivers/edac/armada_xp_edac.c
>> @@ -0,0 +1,658 @@
>> +/*
>> + * Copyright (C) 2017 Pengutronix, Jan Luebbe <kernel@pengutronix.de>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/edac.h>
>> +#include <linux/of_platform.h>
>> +
>> +#include <asm/hardware/cache-l2x0.h>
> 
> I get this when I cross-build it:
> 
> drivers/edac/armada_xp_edac.c:19:37: fatal error: asm/hardware/cache-l2x0.h: No such file or directory
>   #include <asm/hardware/cache-l2x0.h>
>                                       ^
> compilation terminated.
> make[2]: *** [drivers/edac/armada_xp_edac.o] Error 1
> make[1]: *** [drivers/edac] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> 
> 
> and that driver depends on ARCH_MVEBU which is arm64, AFAICT.
> 
> That header is
> 
> arch/arm/include/asm/hardware/cache-l2x0.h
> 
> however and not in arch/arm64/.
> 
> I could very well be missing something though...
> 

As Andrew said ARCH_MVEBU includes both 32-bit and 64-bit processors.

In terms of fixing this issue there are a few options. My first blunt 
tool approach is

-       depends on ARCH_MVEBU
+       depends on ARCH_MVEBU && !ARM64

But that's not a particularly common pattern outside of arch/arm

Another option would be

-       depends on ARCH_MVEBU
+       depends on MACH_MVEBU_V7

There seems to be plenty of precedent for depending on a MACH family in 
other drivers.

We could even go as far as wrapping header include and L2 cache parts 
with #ifdef CONFIG_CACHE_L2X0.

Do you have any preference for which option to take? I'm leaning towards 
MACH_MVEBU_V7.

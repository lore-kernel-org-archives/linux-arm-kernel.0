From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 29 Jul 2010 23:34:32 +0800
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <201007291726.39145.arnd@arndb.de>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<201007291726.39145.arnd@arndb.de>
Message-ID: <AANLkTikeoQf=WC8M9daA=O+tgPdMbDeQdMTWoT8U=CpK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 11:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 29 July 2010, Eric Miao wrote:
>> diff --git a/arch/arm/mach-dove/include/mach/io.h
>> b/arch/arm/mach-dove/include/mach/io.h
>> index 3b3e472..067435e 100644
>> --- a/arch/arm/mach-dove/include/mach/io.h
>> +++ b/arch/arm/mach-dove/include/mach/io.h
>> @@ -11,10 +11,9 @@
>>
>> ?#include "dove.h"
>>
>> -#define IO_SPACE_LIMIT ? ? ? ? 0xffffffff
>> -
>> -#define __io(a) ?((void __iomem *)(((a) - DOVE_PCIE0_IO_PHYS_BASE) +\
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DOVE_PCIE0_IO_VIRT_BASE))
>> -#define __mem_pci(a) ? ? ? ? ? (a)
>> +#define IO_SPACE_LIMIT 0xffffffff
>> +#define __io(a) ? ? ? ? ? ? ? ?__typesafe_io((a) - DOVE_PCIE0_IO_BUS_BASE + \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? DOVE_PCIE0_IO_VIRT_BASE)
>> +#define __mem_pci(a) ? (a)
>>
>> ?#endif
>>
>
> The IO_SPACE_LIMIT still looks wrong, AFAICT it should be
>
> #define IO_SPACE_LIMIT (DOVE_PCIE0_IO_SIZE + DOVE_PCIE1_IO_SIZE - 1)
>

And it looks like PCIE1_IO space is not used as indicated in its __io() macro.

> ? ? ? ?Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

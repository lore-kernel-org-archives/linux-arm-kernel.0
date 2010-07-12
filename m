From: alchark@gmail.com (Alexey Charkov)
Date: Mon, 12 Jul 2010 21:51:27 +0400
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <201007121906.52483.marek.vasut@gmail.com>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007121906.52483.marek.vasut@gmail.com>
Message-ID: <AANLkTilquvf61WTdhAVgmSmozVFYCxDotihjUhCsfvF7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, I've missed some points. Replying below:

2010/7/12 Marek Vasut <marek.vasut@gmail.com>:
> Dne Po 12. ?ervence 2010 18:50:25 Alexey Charkov napsal(a):
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 98922f7..0e171be 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -877,6 +888,8 @@ source "arch/arm/mach-realview/Kconfig"
>>
>> ?source "arch/arm/mach-sa1100/Kconfig"
>>
>> +source "arch/arm/mach-vt8500/Kconfig"
>> +
>
> Possibly keep this sorted?

Definitely. I was just confused by plat-* that immediately follow.

>> ?source "arch/arm/plat-samsung/Kconfig"
>> ?source "arch/arm/plat-s3c24xx/Kconfig"
>> ?source "arch/arm/plat-s5p/Kconfig"
>> diff --git a/arch/arm/boot/compressed/head-vt8500.S
>> b/arch/arm/boot/compressed/head-vt8500.S new file mode 100644
>> index 0000000..2faa7d6
>> --- /dev/null
>> +++ b/arch/arm/boot/compressed/head-vt8500.S
>> @@ -0,0 +1,23 @@
>> +/*
>> + * linux/arch/arm/boot/compressed/head-vt8500.S
>> + *
>> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> + *
>> + * VIA VT8500 specific tweaks. This is merged into head.S by the linker.
>> + *
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/mach-types.h>
>> +
>> + ? ? ? ? ? ? .section ? ? ? ?".start", "ax"
>> +
>> +__VT8500_start:
>> + ? ? ? ? ? ? /* Override the obscure machine id from bootloader */
>> +#ifdef CONFIG_MACH_BV07
>> + ? ? ? ? ? ? mov ? ? r7, #(MACH_TYPE_BV07 & ~0xf)
>> + ? ? ? ? ? ? orr ? ? r7, r7, #(MACH_TYPE_BV07 & 0xf)
>> +#elif defined CONFIG_MACH_WM8505_7IN_NETBOOK
>> + ? ? ? ? ? ? mov ? ? r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & ~0xf)
>> + ? ? ? ? ? ? orr ? ? r7, r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & 0xf)
>> +#endif
>
> Can't you replace the bootloader ?
>

Not yet, as I have no JTAG access to my device and fear bricking it
while testing custom bootloaders :(

Best regards,
Alexey

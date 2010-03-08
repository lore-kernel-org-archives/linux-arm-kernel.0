From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon, 08 Mar 2010 12:05:36 +0000
Subject: [PATCH] pxa: fix for UART reference in section text for a number
	of platforms.
In-Reply-To: <f17812d71003080348k7ff5cd77lf5e1262ce1ccf14@mail.gmail.com>
References: <4B94DC52.1040201@cam.ac.uk>
	<f17812d71003080348k7ff5cd77lf5e1262ce1ccf14@mail.gmail.com>
Message-ID: <4B94E810.7050307@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> What's the background?
Directly, the following compile error in current mainline:

`UART' referenced in section `.text' of arch/arm/boot/compressed/misc.o: defined in discarded section `.data' of arch/arm/boot/compressed/misc.o
`UART' referenced in section `.text' of arch/arm/boot/compressed/misc.o: defined in discarded section `.data' of arch/arm/boot/compressed/misc.o
make[2]: *** [arch/arm/boot/compressed/vmlinux] Error 1

A result of (I think):

5de813b6cd06460b337f9da9afe316823cf3ef45

ARM: Eliminate decompressor -Dstatic= PIC hack

We used to build decompressors with -Dstatic= to avoid any local data
being generated.  The problem is that local data generates GOTOFF
relocations, which means we can't relocate the data relative to the
text segment.

Global data, on the other hand, goes through the GOT, and can be
relocated anywhere.

Unfortunately, with the new decompressors, this presents a problem
since they declare static data within functions, and this leads to
stack overflow.

Fix this by separating out the decompressor code into a separate file,
and removing 'static' from BSS data in misc.c.

Also, discard the .data section - this means that should we end up
with read/write initialized data, the decompressor will fail to link
and the problem will be obvious.


> 2010/3/8 Jonathan Cameron <jic23@cam.ac.uk>:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> ---
>>  Fix exactly as proposed by Russell King.  Thanks!
>>
>>  arch/arm/mach-pxa/include/mach/uncompress.h |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
>> index 237734b..b009299 100644
>> --- a/arch/arm/mach-pxa/include/mach/uncompress.h
>> +++ b/arch/arm/mach-pxa/include/mach/uncompress.h
>> @@ -15,7 +15,7 @@
>>
>>  #define __REG(x)       ((volatile unsigned long *)x)
>>
>> -static volatile unsigned long *UART = FFUART;
>> +static volatile unsigned long *UART;
>>
>>  static inline void putc(char c)
>>  {
>> @@ -39,6 +39,8 @@ static inline void arch_decomp_setup(void)
>>            || machine_is_csb726() || machine_is_stargate2()
>>            || machine_is_cm_x300() || machine_is_balloon3())
>>                UART = STUART;
>> +       else
>> +               UART = FFUART;
>>  }
>>
>>  /*
>> --
>> 1.6.4.4
>>
>>
> 

From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Aug 2012 22:57:59 +0800
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <503CD58C.1010703@wwwdotorg.org>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208210757.32852.arnd@arndb.de>
 <CAGsJ_4yRbFrH8NPJZ6-gU1BebqVkQEBz_GLr4owQz+XpOyejug@mail.gmail.com>
 <201208210920.52816.arnd@arndb.de>
 <CAGsJ_4x4DdHsNgh7ArkD1fCHT22rxRs18vcobHtpSXJ-cq3o4Q@mail.gmail.com>
 <CAGsJ_4y3Snvf-2DLSrpU5+zmytkARtNxJN_nPdiOngd+BK-aDA@mail.gmail.com>
 <503CD58C.1010703@wwwdotorg.org>
Message-ID: <CAGsJ_4zgdsGE=Htuvg7+OGh8+2efUBMNyWBYmq5MhnBOgG+MLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/28 Stephen Warren <swarren@wwwdotorg.org>:
> On 08/28/2012 01:08 AM, Barry Song wrote:
>> 2012/8/28 Barry Song <21cnbao@gmail.com>:
>>> 2012/8/21 Arnd Bergmann <arnd@arndb.de>:
>>>> On Tuesday 21 August 2012, Barry Song wrote:
>>>>> then i add these to Kconfig.debug as it is a common way
>>>>>
>>>>>         config DEBUG_PRIMA2_UART1
>>>>>                 bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
>>>>>                 depends on ARCH_PRIMA2
>>>>>                 help
>>>>>                   Say Y here if you want the debug print routines to direct
>>>>>                   their output to UART1 serial port on SiRFprimaII devices.
>>>>>
>>>>>         config DEBUG_MARCO_UART1
>>>>>                 bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
>>>>>                 depends on ARCH_MARCO
>>>>>                 help
>>>>>                   Say Y here if you want the debug print routines to direct
>>>>>                   their output to UART1 serial port on SiRFmarco devices.
>>>>>
>>>>> and these in mach-prima2/include/mach/uart.h
>>>>>
>>>>>   #ifdef CONFIG_DEBUG_PRIMA2_UART1
>>>>>   #define SIRFSOC_UART1_PA_BASE          0xb0060000
>>>>>   #elif defined(CONFIG_DEBUG_MARCO_UART1)
>>>>>   #define SIRFSOC_UART1_PA_BASE          0xcc060000
>>>>>   #endif
>>>>>
>>>>> the above codes seem still ugly ?
>>>>>
>>>>
>>>> No, that's fine, about as a good as it gets with today's kernel
>>>> capabilities. Just fix the description to have the correct
>>>> SoC name instead of "DaVinci DA8XX" ;-)
>>>
>>> except the DEBUG_LL uart base address, i missed the zreladdr-y. for
>>> primaii, it is 0x00008000, for marco, it is 0x40008000 as marco's
>>> memory space begins from 0x4000000.
>>> i would to have AUTO_ZRELADDR for the whole SiRF series.
>>> but for uImage load address difference in uImage header, which blocks
>>> multiple SoCs from using same uImage, is "KERNEL_NOLOAD" uImage type
>>> the current generic solution?
>>
>> also add Stephen Warren.
>>
>> i have two verified ways to resolve this problem:
>>
>> 1. use "kernel noload", build uImage by:
>>
>> make uImage UIMAGE_TYPE=kernel_noload
>> and add the following patch in kernel:
>
> Very recent U-Boot have a bootz command, which acts just like bootm, but
> allows use of a raw zImage or the kernel, rather than a
> uImage-wrapped-zImage. This was implemented by Marek Vasut.

Thanks, Stephen. i guess xianglong will try bootz on SiRFmarco and try
to move from uImage to raw zImage.

Based on your past "kernel_noload" support patch, we actually can
compile an uImage by:
make uImage UIMAGE_TYPE=kernel_noload UIMAGE_ENTRYADDR=0x0
and it gets a cross-SoCs uImage which doesn't care about zreladdr-y in
Makefile.boot.
actually it just jumps to (loaded uImage dram address + 0x40).

anyway, we don't need to modify mach-prima2/Makefile.boot for marco any more.

do people think we have a chance to delete mach-xxx/Makefile.boot for
some platforms if  zreladdr-y and related address don't make many
senses again?

-barry

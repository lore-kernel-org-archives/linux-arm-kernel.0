From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 21 Aug 2012 17:16:02 +0800
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <201208210757.32852.arnd@arndb.de>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208202106.43206.arnd@arndb.de>
 <CAGsJ_4ynJjm6WuA6NGZdOgj80Xc=ZxKcRatQuEacVW=EXuxh=w@mail.gmail.com>
 <201208210757.32852.arnd@arndb.de>
Message-ID: <CAGsJ_4yRbFrH8NPJZ6-gU1BebqVkQEBz_GLr4owQz+XpOyejug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2012/8/21 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 21 August 2012, Barry Song wrote:
>> for the moment, that is needed just because the DEBUG UART base
>> address is difficult for different SoC. debug-macro.S is very early,
>> it depends on the SIRFSOC_UART1_PA_BASE.
>>
>>  /* UART-1: used as serial debug port */
>>  #ifdef CONFIG_ARCH_PRIMA2
>> #define SIRFSOC_UART1_PA_BASE          0xb0060000
>>  #elif defined(CONFIG_ARCH_MARCO)
>> #define SIRFSOC_UART1_PA_BASE          0xcc060000
>> #endif
>> otherwise, PRIMA2 and MARCO can co-exist.
>
> Ok, I see.
>
>> i think i can find some ways to set the rp dynamically according to chip type.
>>          .macro  addruart, rp, rv, tmp
>>          ldr     \rp, =SIRFSOC_UART1_PA_BASE             @ physical
>>          ldr     \rv, =SIRFSOC_UART1_VA_BASE             @ virtual
>>          .endm
>
> The most common way to do this is to have multiple entries in
> arch/arm/Kconfig.debug in the "Kernel low-level debugging port"
> menu. For production kernels, you would just leave out DEBUG_LL
> while for debugging you have to pick one UART.

then i add these to Kconfig.debug as it is a common way

        config DEBUG_PRIMA2_UART1
                bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
                depends on ARCH_PRIMA2
                help
                  Say Y here if you want the debug print routines to direct
                  their output to UART1 serial port on SiRFprimaII devices.

        config DEBUG_MARCO_UART1
                bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
                depends on ARCH_MARCO
                help
                  Say Y here if you want the debug print routines to direct
                  their output to UART1 serial port on SiRFmarco devices.

and these in mach-prima2/include/mach/uart.h

  #ifdef CONFIG_DEBUG_PRIMA2_UART1
  #define SIRFSOC_UART1_PA_BASE          0xb0060000
  #elif defined(CONFIG_DEBUG_MARCO_UART1)
  #define SIRFSOC_UART1_PA_BASE          0xcc060000
  #endif

the above codes seem still ugly ?

>
>         Arnd

-barry

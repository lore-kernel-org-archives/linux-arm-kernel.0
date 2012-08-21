From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 07:57:32 +0000
Subject: [PATCH 2/3] ARM: PRIMA2: make mach-prima2 common for all SiRF
 series SoC
In-Reply-To: <CAGsJ_4ynJjm6WuA6NGZdOgj80Xc=ZxKcRatQuEacVW=EXuxh=w@mail.gmail.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <201208202106.43206.arnd@arndb.de>
 <CAGsJ_4ynJjm6WuA6NGZdOgj80Xc=ZxKcRatQuEacVW=EXuxh=w@mail.gmail.com>
Message-ID: <201208210757.32852.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Barry Song wrote:
> for the moment, that is needed just because the DEBUG UART base
> address is difficult for different SoC. debug-macro.S is very early,
> it depends on the SIRFSOC_UART1_PA_BASE.
> 
>  /* UART-1: used as serial debug port */
>  #ifdef CONFIG_ARCH_PRIMA2
> #define SIRFSOC_UART1_PA_BASE          0xb0060000
>  #elif defined(CONFIG_ARCH_MARCO)
> #define SIRFSOC_UART1_PA_BASE          0xcc060000
> #endif
> otherwise, PRIMA2 and MARCO can co-exist.

Ok, I see.

> i think i can find some ways to set the rp dynamically according to chip type.
>          .macro  addruart, rp, rv, tmp
>          ldr     \rp, =SIRFSOC_UART1_PA_BASE             @ physical
>          ldr     \rv, =SIRFSOC_UART1_VA_BASE             @ virtual
>          .endm

The most common way to do this is to have multiple entries in
arch/arm/Kconfig.debug in the "Kernel low-level debugging port"
menu. For production kernels, you would just leave out DEBUG_LL
while for debugging you have to pick one UART.

	Arnd

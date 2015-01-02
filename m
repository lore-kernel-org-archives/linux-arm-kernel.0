From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 09:59:14 +0100
Subject: [PATCH 1/4] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <CAGsJ_4wgbDkVu4hEgyP6T7Q-RMHE3bhUppSMN28qeDEVPWDDwg@mail.gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <43053389.8mSSmmg5HD@wuerfel>
 <CAGsJ_4wgbDkVu4hEgyP6T7Q-RMHE3bhUppSMN28qeDEVPWDDwg@mail.gmail.com>
Message-ID: <14663003.FPHtjKFxH1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 January 2015 15:51:41 Barry Song wrote:
> 2014-12-31 23:31 GMT+08:00, Arnd Bergmann <arnd@arndb.de>:
> > On Wednesday 31 December 2014 23:05:44 Barry Song wrote:
> >> 2014-12-31 6:35 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> >> > On Thursday 25 December 2014 16:34:17 Barry Song wrote:
> >> >>  #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
> >> >> -#define SIRFSOC_UART1_PA_BASE          0xb0060000
> >> >> +#define SIRF_LLUART_PA_BASE          0xb0060000
> >> >>  #elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
> >> >> -#define SIRFSOC_UART1_PA_BASE          0xcc060000
> >> >> +#define SIRF_LLUART_PA_BASE          0xcc060000
> >> >> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART1)
> >> >> +#define SIRF_LLUART_PA_BASE          0x18020000
> >> >> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART0)
> >> >> +#define SIRF_LLUART_PA_BASE          0x18010000
> >> >>  #else
> >> >> -#define SIRFSOC_UART1_PA_BASE          0
> >> >> +#define SIRF_LLUART_PA_BASE          0
> >> >>  #endif
> >> >
> >> > I think it would be nicer to use DEBUG_UART_PHYS/DEBUG_UART_VIRT here.
> >>
> >> yes if it is more general name for all. my second feeling is that does
> >> this conflict CSR namespace stuff into high-level and common namespace
> >> things?
> >
> > I think my comment was misleading. What I meant was to use
> > CONFIG_DEBUG_UART_PHYS from arch/arm/Kconfig.debug the same way
> > we do for the 8250 and pl011 compatible uarts.
> 
> it is even better if all CSR ports are same in register layout. then
> we can simply have a Kconfig options for all ports and use the
> CONFIG_DEBUG_UART_VIRT/PHYS to differentiate ports.

Right. In most other cases, we still have one option per implementation
but then only use it to pick a different default for the UART address.

As a side note here, we don't yet have working CONFIG_EARLYCON support
on ARM, but there are new patches to implement that. With EARLYCON
working, it would be much less important to have DEBUG_LL configured
easily, and you could just leave entering the right address to
advanced users that need to debug the kernel earlier than the
earlycon init.

> but here we still
> need the options for different ports as TXFIFO_EMPTY bits are
> different on different ports.
> 
> +#ifdef CONFIG_DEBUG_SIRFATLAS7_UART0
> +#define SIRF_LLUART_TXFIFO_EMPTY                       (1 << 8)
> +#else
> +#define SIRF_LLUART_TXFIFO_EMPTY                       (1 << 6)
> +#endif

Yes, so we need two options at least, so we can tell the difference
between atlas7 and the others.


	Arnd

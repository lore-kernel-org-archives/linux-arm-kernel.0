From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 2 Jan 2015 15:51:41 +0800
Subject: [PATCH 1/4] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <43053389.8mSSmmg5HD@wuerfel>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <88770560.BUUQRjmk3f@wuerfel>
 <CAGsJ_4wUO6rOW4ZyciXkdKtZjkbdHyo=je7_20B5kumKnu8m9A@mail.gmail.com>
 <43053389.8mSSmmg5HD@wuerfel>
Message-ID: <CAGsJ_4wgbDkVu4hEgyP6T7Q-RMHE3bhUppSMN28qeDEVPWDDwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-31 23:31 GMT+08:00, Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 31 December 2014 23:05:44 Barry Song wrote:
>> 2014-12-31 6:35 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Thursday 25 December 2014 16:34:17 Barry Song wrote:
>> >>  #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
>> >> -#define SIRFSOC_UART1_PA_BASE          0xb0060000
>> >> +#define SIRF_LLUART_PA_BASE          0xb0060000
>> >>  #elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
>> >> -#define SIRFSOC_UART1_PA_BASE          0xcc060000
>> >> +#define SIRF_LLUART_PA_BASE          0xcc060000
>> >> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART1)
>> >> +#define SIRF_LLUART_PA_BASE          0x18020000
>> >> +#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART0)
>> >> +#define SIRF_LLUART_PA_BASE          0x18010000
>> >>  #else
>> >> -#define SIRFSOC_UART1_PA_BASE          0
>> >> +#define SIRF_LLUART_PA_BASE          0
>> >>  #endif
>> >
>> > I think it would be nicer to use DEBUG_UART_PHYS/DEBUG_UART_VIRT here.
>>
>> yes if it is more general name for all. my second feeling is that does
>> this conflict CSR namespace stuff into high-level and common namespace
>> things?
>
> I think my comment was misleading. What I meant was to use
> CONFIG_DEBUG_UART_PHYS from arch/arm/Kconfig.debug the same way
> we do for the 8250 and pl011 compatible uarts.

it is even better if all CSR ports are same in register layout. then
we can simply have a Kconfig options for all ports and use the
CONFIG_DEBUG_UART_VIRT/PHYS to differentiate ports. but here we still
need the options for different ports as TXFIFO_EMPTY bits are
different on different ports.

+#ifdef CONFIG_DEBUG_SIRFATLAS7_UART0
+#define SIRF_LLUART_TXFIFO_EMPTY			(1 << 8)
+#else
+#define SIRF_LLUART_TXFIFO_EMPTY			(1 << 6)
+#endif

but we can still get benefit to define the BASE address from Kconfig
and have some similar ways with:

include/debug/8250.S:           ldr     \rv, =CONFIG_DEBUG_UART_VIRT
include/debug/bcm63xx.S:        ldr     \rv, =CONFIG_DEBUG_UART_VIRT
include/debug/meson.S:  ldr     \rv, =(CONFIG_DEBUG_UART_VIRT)
 @ virtual
include/debug/msm.S:    ldr     \rv, =CONFIG_DEBUG_UART_VIRT
include/debug/pl01x.S:          ldr     \rv, =CONFIG_DEBUG_UART_VIRT
include/debug/s3c24xx.S:                ldr     \rv, = CONFIG_DEBUG_UART_VIRT


>
> 	Arnd
>

-barry

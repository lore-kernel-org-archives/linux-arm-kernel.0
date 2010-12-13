From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Dec 2010 15:20:45 +0100
Subject: [PATCH v6 00/15] ARM: mxs: Add initial support for MX23 and MX28
In-Reply-To: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101213142045.GD26210@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Dec 13, 2010 at 08:54:57PM +0800, Shawn Guo wrote:
> Changes for v6 of this patch series:
>  - Introduce inline functions __mxs_setl(), __mxs_clrl()
>    and __mxs_togl() for bit set/clear/toggle operations
>  - Address comments given by Uwe on gpio.c (detailed change log
>    can be found in the patch version log)
>  - Remove cpu.o from arch/arm/mach-mxs/Makefile
> 
>  [PATCH v6 01/15] ARM: mxs: Add core definitions
>  [PATCH v6 03/15] ARM: mxs: Add reset routines
>  [PATCH v6 06/15] ARM: mxs: Add timer support
>  [PATCH v6 07/15] ARM: mxs: Add gpio support
>  [PATCH v6 08/15] ARM: mxs: Add iomux support
>  [PATCH v6 15/15] ARM: mxs: Add build configuration for mxs

There are some things still on my list.  Most of them are only nitpicks,
but there is at least one bigger issue left:

 - use virtual address in get_irqnr_preamble (comment by Lothar Wa?mann)
   (Does irq handling really works without that?)
 - various namespace problems, at least:
   - ICOLL_VBASE in arch/arm/mach-mxs/include/mach/entry-macro.S
   - uart_base, UART in arch/arm/mach-mxs/include/mach/uncompress.h
   - clockevent_mxs, clockevent_mode in arch/arm/mach-mxs/timer.c
 - on TIMROTv1 there is no HW_TIMROT_RUNNING_COUNTn register.  That's
   called HW_TIMROT_TIMCOUNTn.
 - Typo in comment above timrot_is_v1: MX23 uses timers 0 and 1, too.
 - Would it make sense to detect the version of the TIMROT block by
   reading the TIMROT_VERSION register instead of using cpu_is_mxXYZ?
 - IMHO you could better use MXS_CLKCTRL_RESET instead of the watchdog
   in arch_reset.  You argued that this needs an cpu_is_mxXYZ, still I
   think this would be preferable.  Alternatively you can use an
   initcall that sets the address similar to how wdog_base is
   initialized now.  (BTW, wdog_base is another item in the namespace
   list above.)
 - Use clocksource_register_hz (recent comment by Russell King)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

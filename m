From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 14 Dec 2010 16:31:10 +0800
Subject: [PATCH v6 00/15] ARM: mxs: Add initial support for MX23 andMX28
In-Reply-To: <20101213142045.GD26210@pengutronix.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<20101213142045.GD26210@pengutronix.de>
Message-ID: <20101214083109.GB1913@ubuntu.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 07:20:45AM -0700, Uwe Kleine-K?nig wrote:
[...]
> 
> There are some things still on my list.  Most of them are only nitpicks,
> but there is at least one bigger issue left:
> 
>  - use virtual address in get_irqnr_preamble (comment by Lothar Wa?mann)
>    (Does irq handling really works without that?)
No, it does not work without that. I just did not ran into the case,
as only the path of icoll_base will be hit when both mx23 and mx28 are
built in.

It reminded me that I should test single SoC build carefully.

>  - various namespace problems, at least:
>    - ICOLL_VBASE in arch/arm/mach-mxs/include/mach/entry-macro.S
>    - uart_base, UART in arch/arm/mach-mxs/include/mach/uncompress.h
OK

>    - clockevent_mxs, clockevent_mode in arch/arm/mach-mxs/timer.c
Since clockevent_mxs already has namespace "_mxs" in there, I have to
assume that you are asking something like mxs_clockevent_device and
mxs_clockevent_mode. Correct me if I'm wrong.


>  - on TIMROTv1 there is no HW_TIMROT_RUNNING_COUNTn register.  That's
>    called HW_TIMROT_TIMCOUNTn.
I'm reusing the offset definition here. But it seems you are asking
two definitions to avoid confusion.

>  - Typo in comment above timrot_is_v1: MX23 uses timers 0 and 1, too.
It's a typo, but partially. mx28 uses timrot 0 and 1, while mx23 uses
0 and 2. There are 4 registers for each timrot instance on mx28,
but only 2 on mx23. So address step 0x40 in HW_TIMROT_TIMCTRLn strides
one instance on mx28 while two instances on mx23. Confusion again,
adding more definitions, right?

>  - Would it make sense to detect the version of the TIMROT block by
>    reading the TIMROT_VERSION register instead of using cpu_is_mxXYZ?
Yes, we can do that, but we can not avoid using cpu_is_mxXYZ anyway,
as the offset of TIMROT_VERSION is different between mx23 and mx28.
If you really want to go this way, I can work it out for you to
have a look.

>  - IMHO you could better use MXS_CLKCTRL_RESET instead of the watchdog
>    in arch_reset.  You argued that this needs an cpu_is_mxXYZ, still I
>    think this would be preferable.  Alternatively you can use an
>    initcall that sets the address similar to how wdog_base is
>    initialized now.  (BTW, wdog_base is another item in the namespace
>    list above.)
OK

>  - Use clocksource_register_hz (recent comment by Russell King)
OK

Regards,
Shawn

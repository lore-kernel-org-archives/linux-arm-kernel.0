From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 27 Oct 2010 11:59:17 +0200
Subject: [patch v3 10/10] efikamx: add reset
In-Reply-To: <20101027073629.GZ8554@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
	=?utf-8?Q?-K=C3=B6nig=22's?=
	message of "Wed, 27 Oct 2010 09:36:29 +0200")
References: <20101026200723.839428019@rtp-net.org>
	<20101026201006.680384588@rtp-net.org>
	<20101027073629.GZ8554@pengutronix.de>
Message-ID: <87hbg87y8a.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> On Tue, Oct 26, 2010 at 10:07:33PM +0200, Arnaud Patard wrote:
>> The efikamx board is using a gpio to reset the board so add support
>> for it
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
>> ===================================================================
>> --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-20 18:30:58.000000000 +0200
>> +++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-20 18:31:00.000000000 +0200
>> @@ -57,6 +57,9 @@
>>  #define EFIKAMX_SPI_CS0		(3*32 + 24)
>>  #define EFIKAMX_SPI_CS1		(3*32 + 25)
>>  
>> +#define EFIKAMX_RESET1_1	(2*32 + 2)
>> +#define EFIKAMX_RESET		(0*32 + 4)
> Maybe add a comment here about the difference.  When I first read that
> it looked strange.


ok

>
>> +
>>  /* the pci ids pin have pull up. they're driven low according to board id */
>>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>>  #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>> @@ -112,6 +115,10 @@
>>  	MX51_PAD_CSPI1_SS1__GPIO_4_25,
>>  	MX51_PAD_CSPI1_RDY__ECSPI1_RDY,
>>  	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
>> +
>> +	/* reset */
>> +	MX51_PAD_DI1_PIN13__GPIO_3_2,
>> +	MX51_PAD_GPIO_1_4__GPIO_1_4,
>>  };
>>  
>>  /* Serial ports */
>> @@ -306,6 +313,14 @@
>>  	.num_chipselect = ARRAY_SIZE(mx51_efikamx_spi_cs),
>>  };
>>  
>> +void mx51_efikamx_reset(void)
>> +{
>> +	if (system_rev == 0x11)
>> +		gpio_direction_output(EFIKAMX_RESET1_1, 0);
>> +	else
>> +		gpio_direction_output(EFIKAMX_RESET, 0);
>> +}
>> +
>>  static void __init mxc_board_init(void)
>>  {
>>  	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
>> @@ -327,6 +342,11 @@
>>  	spi_register_board_info(mx51_efikamx_spi_board_info,
>>  		ARRAY_SIZE(mx51_efikamx_spi_board_info));
>>  	imx51_add_ecspi(0, &mx51_efikamx_spi_pdata);
>> +
>> +	if (system_rev == 0x11)
>> +		gpio_request(EFIKAMX_RESET1_1, "reset");
>> +	else
>> +		gpio_request(EFIKAMX_RESET, "reset");
> gpio_direction_output(..., 1)?

default setting is fine but adding this will not harm. Will change.


>
>>  }
>>  
>>  static void __init mx51_efikamx_timer_init(void)
>> Index: linux-2.6-submit/arch/arm/plat-mxc/include/mach/common.h
>> ===================================================================
>> --- linux-2.6-submit.orig/arch/arm/plat-mxc/include/mach/common.h	2010-10-20 18:30:27.000000000 +0200
>> +++ linux-2.6-submit/arch/arm/plat-mxc/include/mach/common.h	2010-10-20 18:31:00.000000000 +0200
>> @@ -50,5 +50,5 @@
>>  extern void mxc91231_power_off(void);
>>  extern void mxc91231_arch_reset(int, const char *);
>>  extern void mxc91231_prepare_idle(void);
>> -
>> +extern void mx51_efikamx_reset(void);
>>  #endif
>> Index: linux-2.6-submit/arch/arm/plat-mxc/system.c
>> ===================================================================
>> --- linux-2.6-submit.orig/arch/arm/plat-mxc/system.c	2010-10-20 18:30:27.000000000 +0200
>> +++ linux-2.6-submit/arch/arm/plat-mxc/system.c	2010-10-20 18:31:00.000000000 +0200
>> @@ -26,6 +26,7 @@
>>  #include <mach/common.h>
>>  #include <asm/proc-fns.h>
>>  #include <asm/system.h>
>> +#include <asm/mach-types.h>
>>  
>>  static void __iomem *wdog_base;
>>  
>> @@ -42,6 +43,11 @@
>>  		return;
>>  	}
>>  #endif
>> +#ifdef CONFIG_MACH_MX51_EFIKAMX
>> +	if (machine_is_mx51_efikamx())
>> +		mx51_efikamx_reset();
>> +#endif
> Depending on how fast the reset occurs mx51_efikamx_reset returns and
> the processor continues to execute the watchdog reset.  Is this
> intended?

hmm... sticking to the original code, a return is needed. As the system
was rebooting fine, I didn't notice that. I'm going to test if it's
still working without the watchdog reset and update my patch
accordingly.

Arnaud

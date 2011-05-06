From: paulo@nlink.com.br (Paulo Fragoso)
Date: Fri, 06 May 2011 09:57:25 -0300
Subject: External serial 8250/16550
In-Reply-To: <BANLkTinMrZvO_bNcAKXvaa_pXE+jOxO2uw@mail.gmail.com>
References: <4DB44883.3000608@nlink.com.br>
	<BANLkTinMrZvO_bNcAKXvaa_pXE+jOxO2uw@mail.gmail.com>
Message-ID: <4DC3F035.9030208@nlink.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 26/04/2011 13:39, Andrew Victor escreveu:

>
> Those AT91_SMC  registers and bits only exist on the AT91RM9200,
> whereas you're using a SAM9-based processor.
>
> You should be configuring the memory controller by:
>    #include<mach/at91sam9_smc.h>
>    #include "sam9_smc.h"
>
> and declaring a "struct sam9_smc_config" with all the setting&

I changed the code following TL16C2550 datasheet and now I am using 
correct registers for AT91sam:

static struct sam9_smc_config tms_uart_smc_config = {
	.ncs_read_setup		= 0,
	.nrd_setup		= 2,
	.ncs_write_setup	= 0,
	.nwe_setup		= 2,

	.ncs_read_pulse		= 5,
	.nrd_pulse		= 4,
	.ncs_write_pulse	= 4,
	.nwe_pulse		= 3,

	.read_cycle		= 10,
	.write_cycle		= 9,

	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | 
AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8 | AT91_SMC_BAT_WRITE,
	.tdf_cycles		= 3,
};

> timings, and then calling:
>     sam9_smc_configure(CHIP_SELECT_NUMBER,&your_smc_config_struct);

#define SERIAL_FLAGS	(UPF_BOOT_AUTOCONF | UPF_IOREMAP| UPF_SHARE_IRQ)
#define SERIAL_CLK	(1843200)

#define PORT(_base, _irq)				\
	{						\
		.mapbase	= _base,		\
		.irq		= _irq,			\
		.uartclk	= SERIAL_CLK,		\
		.iotype		= UPIO_MEM,		\
		.regshift	= 0,			\
		.flags		= SERIAL_FLAGS,		\
	}

static struct plat_serial8250_port tms_uart_data[] = {
	PORT(AT91_CHIPSELECT_1, AT91_PIN_PC0),
	PORT(AT91_CHIPSELECT_2, AT91_PIN_PC1),
	{ },
};

static struct platform_device tms_uart_device = {
	.name			= "serial8250",
	.id			= PLAT8250_DEV_PLATFORM,
	.dev			=
		{
			.platform_data	= &tms_uart_data,
		},
};

>
> If you specify UPF_IOREMAP in the "struct plat_serial8250_port" flags,
> the serial-driver will automatically map the IO region for you.

and I am trying init in this way:

static void __init ek_board_init(void)
{
	/* Serial */
	at91_add_device_serial();
	/* USB HS Host */
	at91_add_device_usbh_ohci(&ek_usbh_hs_data);
	at91_add_device_usbh_ehci(&ek_usbh_hs_data);
	/* USB HS Device */
	at91_add_device_usba(&ek_usba_udc_data);

...

	/* External serial */
	tms_add_device_uart();
}

>
> Not for a SAM9-based board.  But for an AT91RM9200 example, look at
> board-tms.c in the AT91 patches on http://maxim.org.za/at91_26.html .
> SAM9 should be the same, except for the SMC memory-controller
> configuration (as described above).

I'm getting kernel opps yet! What is wrong in my code?

Entire code is here:
http://users.nlink.com.br/~paulo/TMS/20110504/board-sweda_tms2.c

Thanks,
Paulo.

>
>
> Regards,
>    Andrew Victor

From: paulo@nlink.com.br (Paulo Fragoso)
Date: Sun, 24 Apr 2011 12:57:55 -0300
Subject: External serial 8250/16550
Message-ID: <4DB44883.3000608@nlink.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was called for help to add a external serial using a board based on 
at91sam9g45, was useded chip TL16c2550 conected on EBI1_D[0-7] for data 
and EBI_A[0-2] for address register.

There are two UART in this chip which will be select by EBI1_NCS1 and 
PC13/NCS2

I'm trying to register this uart in this way:

static struct plat_serial8250_port tms_serial_data[] = {
	PORT(0x70000000, AT91_PIN_PC0),
	PORT(0x80000000, AT91_PIN_PC1),
	{ },
};

static struct platform_device tms_serial_device = {
         .name                   = "serial8250",
         .id                     = -1,
         .dev                    =
                 {
                         .platform_data  = &tms_serial_data,
                 },
};

static void tms_add_device_serial(void)
{
         at91_sys_write(AT91_SMC_CSR(1),
                                   AT91_SMC_ACSS_STD
                                 | AT91_SMC_DBW_8
                                 | AT91_SMC_BAT
                                 | AT91_SMC_WSEN
                                 | AT91_SMC_NWS_(32)     /* wait states */
                                 | AT91_SMC_RWSETUP_(6)  /* setup time */
                                 | AT91_SMC_RWHOLD_(4)   /* hold time */

         );
         at91_sys_write(AT91_SMC_CSR(2),
                                   AT91_SMC_ACSS_STD
                                 | AT91_SMC_DBW_8
                                 | AT91_SMC_BAT
                                 | AT91_SMC_WSEN
                                 | AT91_SMC_NWS_(32)     /* wait states */
                                 | AT91_SMC_RWSETUP_(6)  /* setup time */
                                 | AT91_SMC_RWHOLD_(4)   /* hold time */
         );

         platform_device_register(&tms_serial_device);
}

//#endif

static void __init ek_map_io(void)
{
	/* Initialize processor: 12.000 MHz crystal */
	at91sam9g45_initialize(12000000);

	/* DGBU on ttyS0. (Rx & Tx only) */
	at91_register_uart(0, 0, 0);

	/* USART0 on ttyS2. (Rx, Tx, RTS, CTS) - Used by smartcard */
	at91_register_uart(AT91SAM9G45_ID_US0, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);

	/* USART1 on ttyS1. (Rx, Tx, RTS, CTS) */
	at91_register_uart(AT91SAM9G45_ID_US1, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);

	/* set serial console to ttyS0 (ie, DBGU) */
	at91_set_serial_console(0);

	/* antes: at91_init_serial(&tms_uart_config); */
         /* how to map IO */
}

static void __init ek_board_init(void)
{
	/* Serial */
	at91_add_device_serial();
...
	/* External Serial */
	tms_add_device_serial();
}

But doesn't work, how to map correctly external serial port?

Is there any sample code for external uart using linux-2.6.36 and arm 
AT91SAM9?

Thanks.
Paulo.

From: paulo@nlink.com.br (Paulo Fragoso)
Date: Thu, 19 May 2011 17:13:31 -0300
Subject: External serial 8250/16550
In-Reply-To: <4DCB449C.8060808@nlink.com.br>
References: <4DB44883.3000608@nlink.com.br>	<BANLkTinMrZvO_bNcAKXvaa_pXE+jOxO2uw@mail.gmail.com>	<4DC3F035.9030208@nlink.com.br>	<4DC8AFF9.9030508@nlink.com.br>
	<4DCB449C.8060808@nlink.com.br>
Message-ID: <4DD579EB.50609@nlink.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 11/05/2011 23:23, Paulo Fragoso escreveu:
> On 10-05-2011 00:24, Paulo Fragoso wrote:
> I have one doubt about new-style UART initialization, how can I
> initialize a board using AT91sam9 with two internal USART and two
> external 8250 UART at same time?
>
> For example:
>
> /* DGBU on ttyS0. (Rx & Tx only) */
> at91_register_uart(0, 0, 0);
>
> /* USART0 on ttyS1. (Rx, Tx, RTS, CTS) */
> at91_register_uart(AT91SAM9G45_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
>
> /* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
> at91_register_uart(AT91SAM9G45_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
>
> If I wish to put two more 8250 external serial in sequence (ttyS3 and
> ttyS4) which ID will be used at at91_register_uart function?
>
> Looking at91_register_uart function all structs pdev are defined
> internaly, how I will define serila8250 platform_device and pass at
> at91_register_uart function?

I discovered NCS1 is always on level 0 (selected) and NCS2 is always on 
level 1, those lines never change its state after boot, and they were 
configured correctly:

     sam9_smc_configure(1, &tms_uart_smc_config);
     sam9_smc_configure(2, &tms_uart_smc_config);

Entire file is here: 
http://users.nlink.com.br/~paulo/TMS/20110519/board-sweda_tms2.c

This explain constant output on COMA from TL16C2550 and COMB is detected 
at boot time but doesn't work.

I will research what can be happening but what can be wrong with NCS1 
and NCS2?

Thanks,
Paulo.

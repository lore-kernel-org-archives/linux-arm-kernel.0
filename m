From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Tue, 18 Nov 2014 10:59:03 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <20141117222127.GN27002@pengutronix.de>
References: <20141114232601.GW27002@pengutronix.de>
 <5467A980.5090204@elproma.com.pl> <20141116214239.GX27002@pengutronix.de>
 <54693A51.5080907@elproma.com.pl> <54695654.3070209@elproma.com.pl>
 <20141117082848.GZ27002@pengutronix.de> <546A29B9.5030104@elproma.com.pl>
 <546A2B69.4010409@elproma.com.pl> <20141117184229.GM27002@pengutronix.de>
 <546A465E.5080904@elproma.com.pl> <20141117222127.GN27002@pengutronix.de>
Message-ID: <546B1867.30308@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

W dniu 2014-11-17 o 23:21, Uwe Kleine-K?nig pisze:
> Hello Janusz,
>
> On Mon, Nov 17, 2014 at 08:02:54PM +0100, Janusz U?ycki wrote:
>> W dniu 2014-11-17 o 19:42, Uwe Kleine-K?nig pisze:
>>> On Mon, Nov 17, 2014 at 06:07:53PM +0100, Janusz U?ycki wrote:
>>>>> It looks there could be one more helper useful.
>>>>> Both atmel_serial.c and mxs-auart.c checks if the line is
>>>>> supported by mctrl_gpio.
>>>>> One time it is eg.:
>>>>> (s->gpio_irq[UART_GPIO_DCD] > 0)
>>>>> another time it is eg.:
>>>>> IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS))
>>>>>
>>>>> The first one is no possible now. The second seems rude.
>>>>> bool mctrl_gpio_is_gpio((struct mctrl_gpios *gpios, enum
>>>>> mctrl_gpio_idx gidx);
>>>>> The name is hard. Moreover the implementation could be very similar
>>>>> to mctrl_gpio_to_gpiod(). Any ideas?
>>>> The differences:
>>>> - faster
>>>> - not exported
>>>> - used mainly in uart's interrupt
>>>> - assumes that struct mctrl_gpios *gpios exists
>>> I wonder why you need it at all?!
>> If the line is not supported by gpio it could be supported by native
>> uart's hardware
>> if possible. There are different configurations. One port has the
>> lines, other
>> which uses the same driver doesn't have.
>> Let's look at disable/enable_ms() in atmet_serial.c.
>> In mxs-auart DMA is not used if CTS or RTS is gpio line (timming).
> For the atmel driver I would expect that it doesn't hurt to set
> ATMEL_US_CTSIC if CTS is realized using a gpio. But maybe I'm too
> optimistic here. So atmel_enable_ms could look as follows:
>
> 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>
> 	/*
> 	 * Interrupt should not be enabled twice
> 	 * ukl: is this check really needed?
> 	 */
> 	if (atmel_port->ms_irq_enabled)
> 		return;
>
> 	atmel_port->ms_irq_enabled = true;
>
> 	mctrl_gpio_enable_ms(...);
> 	UART_PUT_IER(port, ATMEL_US_CTSIC | ATMEL_US_DSRIC | ATMEL_US_RIIC | ATMEL_US_DCDIC);

It is too optimistic I think. We shouldn't assume that internal lines 
are biased if not selected by pinmux.
They should be but it is not ensured in most datasheets. Moreover today 
time to market makes erratas longer
and too often not complete. Sadly but true.

best regards
Janusz
> Best regards
> Uwe
>

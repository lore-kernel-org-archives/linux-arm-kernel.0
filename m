From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Mon, 17 Nov 2014 18:07:53 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <546A29B9.5030104@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de>
 <546A29B9.5030104@elproma.com.pl>
Message-ID: <546A2B69.4010409@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2014-11-17 o 18:00, Janusz U?ycki pisze:
>
> W dniu 2014-11-17 o 09:28, Uwe Kleine-K?nig pisze:
>> I think:
>>
>>     struct mctrl_gpios {
>>         struct uart_port *port;
>>         struct {
>>             gpio_desc *gpio;
>>             unsigned int irq;
>>         } mctrl_line[UART_GPIO_MAX];
>>     };
>>
>>     struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, 
>> unsigned int idx_if_needed);
>>     int mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>>     int mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
>>     void mctrl_gpio_free(struct mctrl_gpios *gpios);
>
> It looks there could be one more helper useful.
> Both atmel_serial.c and mxs-auart.c checks if the line is supported by 
> mctrl_gpio.
> One time it is eg.:
> (s->gpio_irq[UART_GPIO_DCD] > 0)
> another time it is eg.:
> IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS))
>
> The first one is no possible now. The second seems rude.
> bool mctrl_gpio_is_gpio((struct mctrl_gpios *gpios, enum 
> mctrl_gpio_idx gidx);
> The name is hard. Moreover the implementation could be very similar
> to mctrl_gpio_to_gpiod(). Any ideas?

The differences:
- faster
- not exported
- used mainly in uart's interrupt
- assumes that struct mctrl_gpios *gpios exists

Just inline function?

best regards
Janusz

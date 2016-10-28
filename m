From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 28 Oct 2016 11:26:26 +0200
Subject: [PATCH v6] tty/serial: at91: fix hardware handshake on Atmel
 platforms
In-Reply-To: <20161027180229.5faqrvxa2a4pos7i@pengutronix.de>
References: <20161027160406.25738-1-richard.genoud@gmail.com>
 <20161027180229.5faqrvxa2a4pos7i@pengutronix.de>
Message-ID: <CACQ1gAhX-WCY3EqxBQ1=MJVsR0G5S21C8KxmO7=x9yW4H6P=xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-27 20:02 GMT+02:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Richard,
>
> On Thu, Oct 27, 2016 at 06:04:06PM +0200, Richard Genoud wrote:
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index fd8aa1f4ba78..168b10cad47b 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -2132,11 +2132,29 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>>               mode |= ATMEL_US_USMODE_RS485;
>>       } else if (termios->c_cflag & CRTSCTS) {
>>               /* RS232 with hardware handshake (RTS/CTS) */
>> -             if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
>> -                     dev_info(port->dev, "not enabling hardware flow control because DMA is used");
>> -                     termios->c_cflag &= ~CRTSCTS;
>> -             } else {
>> +             if (atmel_use_fifo(port) &&
>> +                 !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
>> +                     /*
>> +                      * with ATMEL_US_USMODE_HWHS set, the controller will
>> +                      * be able to drive the RTS pin high/low when the RX
>> +                      * FIFO is above RXFTHRES/below RXFTHRES2.
>> +                      * It will also disable the transmitter when the CTS
>> +                      * pin is high.
>> +                      * This mode is not activated if CTS pin is a GPIO
>> +                      * because in this case, the transmitter is always
>> +                      * disabled (there must be an internal pull-up
>> +                      * responsible for this behaviour).
>> +                      * If the RTS pin is a GPIO, the controller won't be
>> +                      * able to drive it according to the FIFO thresholds,
>> +                      * but it will be handled by the driver.
>> +                      */
>>                       mode |= ATMEL_US_USMODE_HWHS;
>
> You use
>
>         !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)
>
> as indicator that the cts mode of the respective pin is used. Is this
> reliable? (It's not if there are machines that don't use CTS, neither as
> gpio nor using the hardware function.) Maybe this needs a dt property to
> indicate that there is no (hw)handshaking available?
I used that to filter-out the case where CTS is a GPIO.
Now, for the machines that don't use CTS neither as GPIO nor using the
hardware function, it's a whole different story, beyond the scope of this patch.
And like you said, a DT property could be useful to handle this case.
( It's a little bit like if there was an RS232 cable with just TX/RX/GND, but
this will be way harder to detect :) )
Anyway, patches are welcome to handle that, but I don't think it belongs
in this one.

>> +             } else {
>> +                     ...
>>               }
>
> Best regards
> Uwe
>

regards,
Richard

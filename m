From: dev.c0debabe@gmail.com (Stefan Schoenleitner)
Date: Sat, 10 Jul 2010 09:10:07 +0200
Subject: SAM9-L9260: TXD1 is not working on AT91SAM9260
Message-ID: <4C381CCF.2050305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have an Olimex SAM9-L9260 board with an AT91SAM9260 controller on it.
The board is running a sound-2.6 git kernel (2.6.35).

My problem is that for USART1 (which uses the RXD1 and TXD1 pins), the
transmit pin (i.e. TXD1) is not working.
I looked at it with my scope and discovered that it is high all the time
(which is most likely due to the configured pull-up resistor).

Here is what I did to get the UART up and running (just like what I
already did for the DBG UART and UART0):


In my board file (arch/arm/mach-at91/board-sam9-l9260.c) I added the
following line to ek_map_io(), to register USART1 as ttyS2:

-----------------------------------------------------------------------
at91_register_uart(AT91SAM9260_ID_US1, 2, 0);
-----------------------------------------------------------------------


A look at at91sam9260_devices.c reveals that this will lead to a call of
-----------------------------------------------------------------------
configure_usart1_pins(pins);
-----------------------------------------------------------------------

which in turn does the following:
-----------------------------------------------------------------------
at91_set_A_periph(AT91_PIN_PB6, 1);     /* TXD1 */
at91_set_A_periph(AT91_PIN_PB7, 0);     /* RXD1 */
-----------------------------------------------------------------------


Hence the pins PB6 and PB7 are configured to be UART pins.
I also made sure that there is no other code, that sets the
functionality of those pins to something else (e.g. pin PB6 could also
be used as TCLK1).



Then, when I boot the kernel, I get the following lines, which show that
the UARTs are recognized:

-----------------------------------------------------------------------
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a ATMEL_SERIAL
-----------------------------------------------------------------------


While this looks good so far, the odd behavior is that I can correctly
receive data on /dev/ttyS2 (i.e. data is received on the RXD1/PB7 pin),
but I can not send (i.e. *no* data is being transmitted on the TXD1/PB6
pin).


* Is this a bug in the kernel or am I doing something wrong here ?

* Did you experience similar behavior on the at91sam9260 ?

As I already said, I have done this with other UART devices as well
(i.e. USART0) and it worked flawlessly.

cheers,
stefan

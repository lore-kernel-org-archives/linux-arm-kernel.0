From: torso.nafi@gmail.com (=?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=)
Date: Sat, 26 Dec 2015 19:17:41 +0300
Subject: GPIO-driven RTS on TI hardware with 8250_omap driver
Message-ID: <CAEo2pzugEO+jnwdWrRqKR3y4Gzveh9MMaZmRrksfgYzMf6WpPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

We are upgrading to the 4.1.x kernel for our smart metering appliance
project, which is based on TI's Sitara hardware (AM335x SoC), and I
decided to switch from omap-serial legacy driver to the newer
8250-based one. It marginally increases throughput efficiency, CPU
cycle wise, among other goodies, but I'm looking to implement a rather
important feature that is present in the legacy driver, but the newer
one is lacking.

Namely, our project makes use of RS232<->RS485 converters, which in
turn need to consume RTS signals to switch between Rx and Tx modes at
the RS485 side, due to the bus variant we use being half-duplex.
However, the already manufactured hardware is already designed to make
the use of certain pins to take the RTS signal from, which can only be
configured as GPIO for that purpose (in other words, no "native" UART
RTS) - and basically redesigning the h/w configuration now is
definitely out of question. The omap-serial driver already provides
FDT options for that, named "rts-gpio", "rs485-rts-active-high" etc.

As far as I could ascertain, the 8250_omap driver (as well as the 8250
framework itself) at the moment lacks the means to make use of GPIO
pins for that purpose. While trying to implement it myself, I noticed
that the legacy driver has it made in a comparably straightforward
approach, via dispatching the code to switch the pin in its .start_tx
and .stop_tx handlers, and some timing adjustments. Unfortunately, the
situation with 8250-based drivers is different - the aforementioned
handlers are provided by the 8250_core module and are common for all
drivers within the framework.

At first, I thought that implementing such feature for the 8250
framework itself sounds like a good idea, but after reading this
particular post:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271377.html
I decided to comply with the point of view specified there. However,
I'm not that familiar with the 8250 framework internals (or serial
internals at all, for that matter), and my time is quite short, so I
would appreciate much any useful directions on how to do it
hardware-specific style, which functions/structs/handlers to use, etc.
Of particular interest is the following part:

> I don't care whether the drive does it via serial_out magic or a more explicit hook but it doesn't belong here in core code.

Any ideas/clarifications on what might be meant on that part?

Regards,
Ilyas G.

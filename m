From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 7 Jun 2010 11:33:05 +0200
Subject: [PATCH] ARM: PL011 baudrate extension for ST-Ericssons derivative
In-Reply-To: <1275507433-32644-1-git-send-email-linus.walleij@stericsson.com>
References: <1275507433-32644-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTingPGmsrG_7Kn6X1xSKVozRFfQ6AAoYkZMXIA3R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting self

2010/6/2 Linus Walleij <linus.walleij@stericsson.com>:

> Implementation of the ST-Ericsson baudrate extension in the PL011
> block. In this modified variant it is possible to change the
> sampling factor from 16 to 8, and thanks to this we can get higher
> baudrates while still using the same peripheral clock.
>
> Also replace the simple division to determine the baud divisor
> with DIV_ROUND_CLOSEST() rather than a simple integer division.
> (...)
> -       baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
> -       quot = port->uartclk * 4 / baud;
> + ? ? ? baud = uart_get_baud_rate(port, termios, old, 0,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? port->uartclk/(uap->oversampling ? 8 : 16));
> +
> + ? ? ? if (baud > port->uartclk/16)
> + ? ? ? ? ? ? ? quot = DIV_ROUND_CLOSEST(port->uartclk * 8, baud);
> + ? ? ? else
> + ? ? ? ? ? ? ? quot = DIV_ROUND_CLOSEST(port->uartclk * 4, baud);

I should add that we have measured some hard data on this change,
and it fixes a real-life bug for us: below you can see what are diversions from
fixed baudrates for the two algorithms,
first: original, second: DIV_ROUND_CLOSEST:

baud=   9600, FBRD=0x00 IBRD=0xFA os=0, real baud=   9600 (0.00%)
baud=   9600, FBRD=0x00 IBRD=0xFA os=0, real baud=   9600 (0.00%)
----
baud=  19200, FBRD=0x00 IBRD=0x7D os=0, real baud=  19200 (0.00%)
baud=  19200, FBRD=0x00 IBRD=0x7D os=0, real baud=  19200 (0.00%)
----
baud=  38400, FBRD=0x20 IBRD=0x3E os=0, real baud=  38400 (0.00%)
baud=  38400, FBRD=0x20 IBRD=0x3E os=0, real baud=  38400 (0.00%)
----
baud=  57600, FBRD=0x2A IBRD=0x29 os=0, real baud=  57614 (0.02%)
baud=  57600, FBRD=0x2B IBRD=0x29 os=0, real baud=  57592 (0.01%)
----
baud= 115200, FBRD=0x35 IBRD=0x14 os=0, real baud= 115228 (0.02%)
baud= 115200, FBRD=0x35 IBRD=0x14 os=0, real baud= 115228 (0.02%)
----
baud= 230400, FBRD=0x1A IBRD=0x0A os=0, real baud= 230630 (0.10%)
baud= 230400, FBRD=0x1B IBRD=0x0A os=0, real baud= 230284 (0.05%)
----
baud= 460800, FBRD=0x0D IBRD=0x05 os=0, real baud= 461261 (0.10%)
baud= 460800, FBRD=0x0D IBRD=0x05 os=0, real baud= 461261 (0.10%)
----
baud= 500000, FBRD=0x33 IBRD=0x04 os=0, real baud= 500325 (0.07%)
baud= 500000, FBRD=0x33 IBRD=0x04 os=0, real baud= 500325 (0.07%)
----
baud= 576000, FBRD=0x0A IBRD=0x04 os=0, real baud= 577443 (0.25%)
baud= 576000, FBRD=0x0B IBRD=0x04 os=0, real baud= 575280 (0.13%)
----
baud= 921600, FBRD=0x26 IBRD=0x02 os=0, real baud= 925301 (0.40%)
baud= 921600, FBRD=0x27 IBRD=0x02 os=0, real baud= 919760 (0.20%)
----
baud=1000000, FBRD=0x19 IBRD=0x02 os=0, real baud=1003921 (0.39%)
baud=1000000, FBRD=0x1A IBRD=0x02 os=0, real baud= 997402 (0.26%)
----
baud=1152000, FBRD=0x05 IBRD=0x02 os=0, real baud=1154887 (0.25%)
baud=1152000, FBRD=0x05 IBRD=0x02 os=0, real baud=1154887 (0.25%)
----
baud=1500000, FBRD=0x26 IBRD=0x01 os=0, real baud=1505882 (0.39%)
baud=1500000, FBRD=0x26 IBRD=0x01 os=0, real baud=1505882 (0.39%)
----
baud=2000000, FBRD=0x0C IBRD=0x01 os=0, real baud=2021052 (1.05%)
baud=2000000, FBRD=0x0D IBRD=0x01 os=0, real baud=1994805 (0.26%)
----
baud=2500000, FBRD=0x3A IBRD=0x01 os=1, real baud=2518032 (0.72%)
baud=2500000, FBRD=0x3B IBRD=0x01 os=1, real baud=2497560 (0.10%)
----
baud=3000000, FBRD=0x26 IBRD=0x01 os=1, real baud=3011764 (0.39%)
baud=3000000, FBRD=0x26 IBRD=0x01 os=1, real baud=3011764 (0.39%)
----
baud=3500000, FBRD=0x17 IBRD=0x01 os=1, real baud=3531034 (0.89%)
baud=3500000, FBRD=0x18 IBRD=0x01 os=1, real baud=3490908 (0.26%)
----
baud=4000000, FBRD=0x0C IBRD=0x01 os=1, real baud=4042104 (1.05%)
baud=4000000, FBRD=0x0D IBRD=0x01 os=1, real baud=3989610 (0.26%)

As you see, the effect kicks in at the higher baudrates in the ST-Ericsson
derivative, but it's still marginally improving the non-exended case as well.

Yours,
Linus Walleij

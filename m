From: mboards@prograde.net (Michael Cashwell)
Date: Tue, 11 May 2010 11:00:36 -0400
Subject: PXA/8250 UART Conflicts
Message-ID: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I'm using a PXA270-based Gumstix and a provisional 2.6.33.2 kernel to explore supporting a dual 8250-like UART chip over i2c for one of our hardware guys. But enabling both the 8250 and pxa2xx-uart drivers conflicts at the ttySn level. Both seem to do the following:

serial_core: uart_register_driver() ->
tty_io:      tty_register_driver() ->
char_dev:    register_chrdev_region()

using the same starting minor number. Thus the first driver gets /dev/ttyS0 and up and the rest fail with -EBUSY.

Am I missing something? Are these drivers just incompatible and Kconfig shouldn't let me turn both on? (In fact, doing so kills the console if it's on an internal PXA uart because the 8250 driver loads first. That was "fun with JTAG".)

I'd like the tty layer to just assign the minor numbers in sequence, first come first served. But I don't see how to get that. Or is there some platform way to influence the tty range requested?

Any pearls of wisdom would be welcome.

-Mike

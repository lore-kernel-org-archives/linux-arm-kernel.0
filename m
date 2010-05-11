From: maz@misterjones.org (Marc Zyngier)
Date: Tue, 11 May 2010 18:29:43 +0200
Subject: PXA/8250 UART Conflicts
In-Reply-To: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
References: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
Message-ID: <23b656b0c689be0c7ec0faaf37b6a9e6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 11 May 2010 11:00:36 -0400, Michael Cashwell
<mboards@prograde.net>
wrote:
> Greetings,
> 
> I'm using a PXA270-based Gumstix and a provisional 2.6.33.2 kernel to
> explore supporting a dual 8250-like UART chip over i2c for one of our
> hardware guys. But enabling both the 8250 and pxa2xx-uart drivers
conflicts
> at the ttySn level. Both seem to do the following:
> 
> serial_core: uart_register_driver() ->
> tty_io:      tty_register_driver() ->
> char_dev:    register_chrdev_region()
> 
> using the same starting minor number. Thus the first driver gets
> /dev/ttyS0 and up and the rest fail with -EBUSY.
> 
> Am I missing something? Are these drivers just incompatible and Kconfig
> shouldn't let me turn both on? (In fact, doing so kills the console if
it's
> on an internal PXA uart because the 8250 driver loads first. That was
"fun
> with JTAG".)

Both Viper and Zeus platforms faced the exact same problem. On the Viper,
either we let the 8250 driver manage all the serial ports (including the
PXA ports), or we only have the 3 PXA UARTs. On the Zeus, the PXA driver is
simply out of the picture as the console lives on one of the 8250 UARTs.

> I'd like the tty layer to just assign the minor numbers in sequence,
first
> come first served. But I don't see how to get that. Or is there some
> platform way to influence the tty range requested?

I remember a SPARC hack in drivers/serial/8250.c (grep for CONFIG_SPARC)
for the exact same purpose. Not that I would recommend doing so for PXA or
any other platform...

        M.
-- 
Who you jivin' with that Cosmik Debris?

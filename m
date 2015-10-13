From: peda@lysator.liu.se (Peter Rosin)
Date: Tue, 13 Oct 2015 17:19:03 +0200
Subject: [PATCH] i2c: at91: fix write transfers by clearing pending
 interrupt first
In-Reply-To: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
References: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <561D20E7.5070405@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-13 16:21, Ludovic Desroches wrote:
> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> In some cases a NACK interrupt may be pending in the Status Register (SR)
> as a result of a previous transfer. However at91_do_twi_transfer() did not
> read the SR to clear pending interruptions before starting a new transfer.
> Hence a NACK interrupt rose as soon as it was enabled again at the I2C
> controller level, resulting in a wrong sequence of operations and strange
> patterns of behaviour on the I2C bus, such as a clock stretch followed by
> a restart of the transfer.
> 
> This first issue occurred with both DMA and PIO write transfers.
> 
> Also when a NACK error was detected during a PIO write transfer, the
> interrupt handler used to wrongly start a new transfer by writing into the
> Transmit Holding Register (THR). Then the I2C slave was likely to reply
> with a second NACK.
> 
> This second issue is fixed in atmel_twi_interrupt() by handling the TXRDY
> status bit only if both the TXCOMP and NACK status bits are cleared.
> 
> Tested with a at24 eeprom on sama5d36ek board running a linux-4.1-at91
> kernel image. Adapted to linux-next.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Fixes: 93563a6a71bb ("i2c: at91: fix a race condition when using the DMA controller")
> Reported-by: Peter Rosin <peda@lysator.liu.se>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable at vger.kernel.org #4.1

The regression is gone with this patch (vanilla 4.2), thank you!

However, looking at the bus, there are two NACKs after each
successful chunk of memory written by the eeprom driver.

Looking at the eeprom driver, I expect this on the bus:

S 0x50 0x00 "hello there guys" P
S 0x50 NACK P
delay for at least 1 ms (since the eeprom driver has a msleep(1) call).
S 0x50 NACK P
delay for at least 1 ms
...
...
S 0x50 NACK P
delay for at least 1 ms
S 0x50 0x10 "and girls\n" P

This is not what I observe on the bus, most of the time there is a
second NACK immediately following the first. I suspect that it is
the i2c bus driver that somehow confuses itself and reissues the
command for some reason?

But this behavior has been there since the beginning, so it's probably
orthogonal, and killing the data corrupting regression is much more
important to me than fussing over a surplus failed transfer. Hence

Tested-by: Peter Rosin <peda@lysator.liu.se>

Cheers,
Peter

From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Oct 2015 15:07:35 +0200
Subject: [PATCH v2 1/2] i2c: at91: fix write transfers by clearing
 pending interrupt first
In-Reply-To: <1445435048-25889-1-git-send-email-ludovic.desroches@atmel.com>
References: <1445435048-25889-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151022130735.GD1517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 03:44:03PM +0200, Ludovic Desroches wrote:
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
> Tested-by: Peter Rosin <peda@lysator.liu.se>
> Cc: stable at vger.kernel.org #4.1

Applied to for-next, thanks!

I considered for-current, but really want this to sit a little in
for-next to make sure there are no regressions. It will go back via
stable.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/9aaaf81d/attachment.sig>

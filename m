From: eric@anholt.net (Eric Anholt)
Date: Wed, 28 Sep 2016 15:00:05 -0700
Subject: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR
 interrupts
In-Reply-To: <1475085056-5205-3-git-send-email-noralf@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-3-git-send-email-noralf@tronnes.org>
Message-ID: <87oa37fzx6.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noralf Tr?nnes <noralf@tronnes.org> writes:

> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining == 0),
> the driver has no way to fill/drain the FIFO to stop the interrupts.
> In this case the controller has to be disabled and the transfer
> completed to avoid hang.
>
> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
> the controller is disabled in the transfer function after completion.
> Unite the code paths and do disabling inside the interrupt routine.
>
> Clear interrupt status bits in the united completion path instead of
> trying to do it on every interrupt which isn't necessary.
> Only CLKT, ERR and DONE can be cleared that way.
>
> Add the status value to the error value in case of TXW/RXR errors to
> distinguish them from the other S_LEN error.

I was surprised that not writing the TXW/RXR bits on handling their
interrupts was OK, given that we were doing so before, but it's a level
interrupt and those bits are basically ignored on write.

This patch and 3, 4, and 6 are:

Reviewed-by: Eric Anholt <eric@anholt.net>

Patch 5 is:

Acked-by: Eric Anholt <eric@anholt.net>

Note for future debug: The I2C_C_CLEAR on errors will take some time to
resolve -- if you were in non-idle state and I2C_C_READ, it sets an
abort_rx flag and runs through the state machine to send a NACK and a
STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
be hanging around queued up for next time we start the engine.

Patch 7 I had questions about but probably will send an ack when you
reply.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160928/15c6f921/attachment.sig>

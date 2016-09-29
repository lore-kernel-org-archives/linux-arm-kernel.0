From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 29 Sep 2016 07:37:23 +0200 (CEST)
Subject: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR
 interrupts
In-Reply-To: <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-3-git-send-email-noralf@tronnes.org>
 <87oa37fzx6.fsf@eliezer.anholt.net>
 <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
Message-ID: <1708178720.178936.b155d019-5320-4754-bbe2-4afc1ae71cd6.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Noralf Tr?nnes <noralf@tronnes.org> hat am 29. September 2016 um 00:22
> geschrieben:
> 
> 
> 
> Den 29.09.2016 00:00, skrev Eric Anholt:
> > Noralf Tr?nnes <noralf@tronnes.org> writes:
> >
> >> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining == 0),
> >> the driver has no way to fill/drain the FIFO to stop the interrupts.
> >> In this case the controller has to be disabled and the transfer
> >> completed to avoid hang.
> >>
> >> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
> >> the controller is disabled in the transfer function after completion.
> >> Unite the code paths and do disabling inside the interrupt routine.
> >>
> >> Clear interrupt status bits in the united completion path instead of
> >> trying to do it on every interrupt which isn't necessary.
> >> Only CLKT, ERR and DONE can be cleared that way.
> >>
> >> Add the status value to the error value in case of TXW/RXR errors to
> >> distinguish them from the other S_LEN error.
> > I was surprised that not writing the TXW/RXR bits on handling their
> > interrupts was OK, given that we were doing so before, but it's a level
> > interrupt and those bits are basically ignored on write.
> >
> > This patch and 3, 4, and 6 are:
> >
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> >
> > Patch 5 is:
> >
> > Acked-by: Eric Anholt <eric@anholt.net>
> >
> > Note for future debug: The I2C_C_CLEAR on errors will take some time to
> > resolve -- if you were in non-idle state and I2C_C_READ, it sets an
> > abort_rx flag and runs through the state machine to send a NACK and a
> > STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
> > be hanging around queued up for next time we start the engine.
> 
> Maybe you're able to explain the issues I had with reset:
> https://github.com/raspberrypi/linux/issues/1653
> 
> Should we put your note into the commit message?
> It will most likely be lost if it just stays in this email.

I prefer to have this kind of information as a code comment.

> 
> Noralf.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

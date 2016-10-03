From: eric@anholt.net (Eric Anholt)
Date: Mon, 03 Oct 2016 12:42:29 -0700
Subject: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR
 interrupts
In-Reply-To: <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-3-git-send-email-noralf@tronnes.org>
 <87oa37fzx6.fsf@eliezer.anholt.net>
 <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
Message-ID: <8760p9xlqy.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noralf Tr?nnes <noralf@tronnes.org> writes:

> Den 29.09.2016 00:00, skrev Eric Anholt:
>> Noralf Tr?nnes <noralf@tronnes.org> writes:
>>
>>> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining == 0),
>>> the driver has no way to fill/drain the FIFO to stop the interrupts.
>>> In this case the controller has to be disabled and the transfer
>>> completed to avoid hang.
>>>
>>> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
>>> the controller is disabled in the transfer function after completion.
>>> Unite the code paths and do disabling inside the interrupt routine.
>>>
>>> Clear interrupt status bits in the united completion path instead of
>>> trying to do it on every interrupt which isn't necessary.
>>> Only CLKT, ERR and DONE can be cleared that way.
>>>
>>> Add the status value to the error value in case of TXW/RXR errors to
>>> distinguish them from the other S_LEN error.
>> I was surprised that not writing the TXW/RXR bits on handling their
>> interrupts was OK, given that we were doing so before, but it's a level
>> interrupt and those bits are basically ignored on write.
>>
>> This patch and 3, 4, and 6 are:
>>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>>
>> Patch 5 is:
>>
>> Acked-by: Eric Anholt <eric@anholt.net>
>>
>> Note for future debug: The I2C_C_CLEAR on errors will take some time to
>> resolve -- if you were in non-idle state and I2C_C_READ, it sets an
>> abort_rx flag and runs through the state machine to send a NACK and a
>> STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
>> be hanging around queued up for next time we start the engine.
>
> Maybe you're able to explain the issues I had with reset:
> https://github.com/raspberrypi/linux/issues/1653

One of the questions I think you might have is "what state does the
controller end up in after the various interrupts?"

ERR:
- produced if we get a nack that's not at the end of a read.

- Proceeds to repeated start if BCM2835_I2C_C_ST is queued, otherwise
  stop.

CLKT:
- Triggered by a counter outside of the state machine when stretching
  happens and then times out.

- Sets cs_override, which causes proceeding through the state machine as
  if the clock wasn't getting stretched, until the end of the next byte
  sent/received.

- According to Wolfram we shouldn't be timing out on clock stretching
  for i2c, just on the transfer as a whole
  (https://patchwork.kernel.org/patch/9148431/), so I wrote
  https://github.com/anholt/linux/commit/894200276239d2e4c60b378bdc52164fcb13af8d.
  However, I don't see an obvious way to get back to IDLE while the
  slave is still stretching, without triggering the clock stretching
  timeout path.

DONE:
- Signaled at STOP, and just moves to IDLE state which keeps scl/sda
  high and waits for a BCM2835_I2C_C_ST while we're not clearing the
  FIFOs (if you do signal start while the fifos are clearing, the start
  will hang around until the fifo clear is done).  This is the only way
  to get to IDLE.

I'm don't think I have an answer to the "what should I do?" question you
had, but hopefully this helps.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161003/0b6762c3/attachment.sig>

From: eric@anholt.net (Eric Anholt)
Date: Mon, 03 Oct 2016 11:58:32 -0700
Subject: [PATCH v3 2/7] i2c: bcm2835: Protect against unexpected TXW/RXR
 interrupts
In-Reply-To: <0c943ee9-d152-79c4-2ad7-8a88c2d9c960@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-3-git-send-email-noralf@tronnes.org>
 <87oa37fzx6.fsf@eliezer.anholt.net>
 <d93a0590-1783-b913-9362-007628cb17d6@tronnes.org>
 <1708178720.178936.b155d019-5320-4754-bbe2-4afc1ae71cd6.open-xchange@email.1und1.de>
 <0c943ee9-d152-79c4-2ad7-8a88c2d9c960@tronnes.org>
Message-ID: <878tu5xns7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noralf Tr?nnes <noralf@tronnes.org> writes:

> Den 29.09.2016 07:37, skrev Stefan Wahren:
>>> Noralf Tr?nnes <noralf@tronnes.org> hat am 29. September 2016 um 00:22
>>> geschrieben:
>>>
>>>
>>>
>>> Den 29.09.2016 00:00, skrev Eric Anholt:
>>>> Noralf Tr?nnes <noralf@tronnes.org> writes:
>>>>
>>>>> If an unexpected TXW or RXR interrupt occurs (msg_buf_remaining == 0),
>>>>> the driver has no way to fill/drain the FIFO to stop the interrupts.
>>>>> In this case the controller has to be disabled and the transfer
>>>>> completed to avoid hang.
>>>>>
>>>>> (CLKT | ERR) and DONE interrupts are completed in their own paths, and
>>>>> the controller is disabled in the transfer function after completion.
>>>>> Unite the code paths and do disabling inside the interrupt routine.
>>>>>
>>>>> Clear interrupt status bits in the united completion path instead of
>>>>> trying to do it on every interrupt which isn't necessary.
>>>>> Only CLKT, ERR and DONE can be cleared that way.
>>>>>
>>>>> Add the status value to the error value in case of TXW/RXR errors to
>>>>> distinguish them from the other S_LEN error.
>>>> I was surprised that not writing the TXW/RXR bits on handling their
>>>> interrupts was OK, given that we were doing so before, but it's a level
>>>> interrupt and those bits are basically ignored on write.
>>>>
>>>> This patch and 3, 4, and 6 are:
>>>>
>>>> Reviewed-by: Eric Anholt <eric@anholt.net>
>>>>
>>>> Patch 5 is:
>>>>
>>>> Acked-by: Eric Anholt <eric@anholt.net>
>>>>
>>>> Note for future debug: The I2C_C_CLEAR on errors will take some time to
>>>> resolve -- if you were in non-idle state and I2C_C_READ, it sets an
>>>> abort_rx flag and runs through the state machine to send a NACK and a
>>>> STOP, I think.  Since we're setting CLEAR without I2CEN, that NACK will
>>>> be hanging around queued up for next time we start the engine.
>>> Maybe you're able to explain the issues I had with reset:
>>> https://github.com/raspberrypi/linux/issues/1653
>>>
>>> Should we put your note into the commit message?
>>> It will most likely be lost if it just stays in this email.
>> I prefer to have this kind of information as a code comment.
>
> Eric, does this look good to you as a code comment:
>
> /*
>   * Note about I2C_C_CLEAR on error:
>   * The I2C_C_CLEAR on errors will take some time to resolve -- if you 
> were in
>   * non-idle state and I2C_C_READ, it sets an abort_rx flag and runs through
>   * the state machine to send a NACK and a STOP. Since we're setting CLEAR
>   * without I2CEN, that NACK will be hanging around queued up for next time
>   * we start the engine.
>   */
>
>
> If it is, I'll resend the series with this change and add all the ack's 
> and r-b's.

Looks good to me.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161003/29b87d31/attachment.sig>

From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Mon, 19 Sep 2016 19:36:23 +0200
Subject: [PATCH 1/3] i2c: bcm2835: Fix hang for writing messages larger
 than 16 bytes
In-Reply-To: <87zin3omsa.fsf@eliezer.anholt.net>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
 <87zin3omsa.fsf@eliezer.anholt.net>
Message-ID: <64c65af1-fdd9-bbe7-7c2b-6e8d87f08bb8@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 19.09.2016 18:51, skrev Eric Anholt:
> Noralf Tr?nnes <noralf@tronnes.org> writes:
>
>> Writing messages larger than the FIFO size results in a hang, rendering
>> the machine unusable. This is because the RXD status flag is set on the
>> first interrupt which results in bcm2835_drain_rxfifo() stealing bytes
>> from the buffer. The controller continues to trigger interrupts waiting
>> for the missing bytes, but bcm2835_fill_txfifo() has none to give.
>> In this situation wait_for_completion_timeout() apparently is unable to
>> stop the madness.
>>
>> The BCM2835 ARM Peripherals datasheet has this to say about the flags:
>>    TXD: is set when the FIFO has space for at least one byte of data.
>>    RXD: is set when the FIFO contains at least one byte of data.
>>    TXW: is set during a write transfer and the FIFO is less than full.
>>    RXR: is set during a read transfer and the FIFO is or more full.
>>
>> Implementing the logic from the downstream i2c-bcm2708 driver solved
>> the hang problem.
>>
>> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
> Patches 1, 3 are:
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
>
> For patch 2 I followed some of it, but couldn't quite say it's a review.
> I trust your testing, and that the path has had a lot more testing in
> the downstream tree, so it's:

I don't know how much testing downstream really has had since this feature
is disabled by default. So there is a possibility that this can break some
devices (while at the same time enable others).
I wondered about adding a module parameter so it could be disabled at
runtime, but decided to see what the review would be first.
It is of course possible to add a this module parameter later should it
turn out to break some device.

Noralf.

> Acked-by: Eric Anholt <eric@anholt.net>
>
> Thanks!

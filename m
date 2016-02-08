From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 8 Feb 2016 13:20:12 +0100
Subject: [PATCH V4 2/7] clk: bcm2835: clamp clock divider to highest
 integer only
In-Reply-To: <87k2mo3tnm.fsf@eliezer.anholt.net>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-3-git-send-email-kernel@martin.sperl.org>
 <87k2mo3tnm.fsf@eliezer.anholt.net>
Message-ID: <56B887FC.5070001@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02.02.2016 00:19, Eric Anholt wrote:
> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> The clock divider calculation right now clamps the
>> divider to the highest possible fractional divider.
>> So typically (BIT(div_int_bits) - 1) + 4095 / 4096.
>>
>> As the fractional clock divider is alterating between
>> (Fosc / div_int) and (Fosc / (div_int + 1))
>> the divider will overflow for the (div_int + 1) case.
>> As with the "underflow" case we have seen for (div < 2),
>> we can assume that the same applies on the upper limit
>> as well.
>>
>> So this patch will instead clamp to the divider to the
>> max of (BIT(div_int_bits) - 1)
>
> Looks like this restriction might be necessary, though it's not quite
> spelled out in the docs.
>
> This also needs to be conditional on it being a MASH clock, and the
> limit on the divider changes in the same way based on the mash number as
> for the minimum.
>
See:
[PATCH V4 7/7] clk: bcm2835: apply limits on dividers to MASH mode.
That "downgrades" to lower mash values in case we are out of range.
Also note that it applies to MASH=1 as well.

If the other (non mash-supported) clocks support this "better" (if it 
works), then we can make that change only apply to mash enabled clocks.
But so far I doubt it works correctly so I have applied those limits to
all clocks.

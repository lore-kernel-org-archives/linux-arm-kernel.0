From: eric@anholt.net (Eric Anholt)
Date: Mon, 01 Feb 2016 15:19:57 -0800
Subject: [PATCH V4 2/7] clk: bcm2835: clamp clock divider to highest
 integer only
In-Reply-To: <1452867667-2447-3-git-send-email-kernel@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87k2mo3tnm.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The clock divider calculation right now clamps the
> divider to the highest possible fractional divider.
> So typically (BIT(div_int_bits) - 1) + 4095 / 4096.
>
> As the fractional clock divider is alterating between
> (Fosc / div_int) and (Fosc / (div_int + 1))
> the divider will overflow for the (div_int + 1) case.
> As with the "underflow" case we have seen for (div < 2),
> we can assume that the same applies on the upper limit
> as well.
>
> So this patch will instead clamp to the divider to the
> max of (BIT(div_int_bits) - 1)

Looks like this restriction might be necessary, though it's not quite
spelled out in the docs.

This also needs to be conditional on it being a MASH clock, and the
limit on the divider changes in the same way based on the mash number as
for the minimum.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/318facdd/attachment-0001.sig>

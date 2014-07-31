From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 31 Jul 2014 16:38:37 +0100
Subject: [PATCH] drivers: CCI: Correct use of ! and &
In-Reply-To: <CAOesGMgAY7-MDVG2CzesQurWtMLdODjsdBNV8jScFJtAB3NAJg@mail.gmail.com>
 (Olof Johansson's message of "Wed, 30 Jul 2014 23:00:24 -0700")
References: <1406716655-32494-1-git-send-email-punit.agrawal@arm.com>
 <20140730195424.GG18384@quad.lixom.net>
 <CAOesGMgAY7-MDVG2CzesQurWtMLdODjsdBNV8jScFJtAB3NAJg@mail.gmail.com>
Message-ID: <9hhoaw55yiq.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Olof Johansson <olof@lixom.net> writes:

> Hi,
>
> On Wed, Jul 30, 2014 at 12:54 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, Jul 30, 2014 at 11:37:35AM +0100, Punit Agrawal wrote:
>>> From: Himangi Saraogi <himangi774@gmail.com>
>>>
>>> In commit ae91d60ba88ef0bdb1b5e9b2363bd52fc45d2af7, a bug was fixed that
>>> involved converting !x & y to !(x & y).  The code below shows the same
>>> pattern, and thus should perhaps be fixed in the same way.
>>>
>>> The Coccinelle semantic patch that makes this change is as follows:
>>>
>>> // <smpl>
>>> @@ expression E1,E2; @@
>>> (
>>>   !E1 & !E2
>>> |
>>> - !E1 & E2
>>> + !(E1 & E2)
>>> )
>>> // </smpl>
>>>
>>> Cc: stable at vger.kernel.org
>>> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
>>> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>>> Acked-by: Punit Agrawal <punit.agrawal@arm.com>
>>> ---
>>
>> Thanks, applied (adding a Fixes: tag, please use those in the future)

Will do.

>
> On second look, I see that the code doesn't actually change behavior
> (since the mask is done with 0x1, it happens to have the same result).
> Pure luck before. :)

Although I'd tested the original submission and had seen interrupts
handled correctly, this fix made me question if I was mis-remembering
(since this was about a year ago).

I had convinced myself that the fix was required. Re-evaluating all the
conditions after reading your response, I agree that it is not a change
in behaviour but still a correct fix.

>
> Because of this, I've moved this to our next/fixes-non-critical
> branch, which will be sent up during the 3.17 merge window, and I took
> off the stable cc. It's still a good fix, but since it doesn't
> actually fix broken behavior there's no need to rush it.

Ack. Thanks a lot.

>
>
> -Olof
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

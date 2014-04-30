From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 15:27:17 +0200
Subject: [PATCH for v3.15] net: mvmdio: Check for a valid interrupt instead
 of an error
In-Reply-To: <20140430114209.GA1907@arch.cereza>
References: <1398800999-9814-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <53601B96.3000608@gmail.com> <20140430114209.GA1907@arch.cereza>
Message-ID: <5360FA35.7070209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2014 01:42 PM, Ezequiel Garcia wrote:
> On Apr 29, Sebastian Hesselbarth wrote:
>> On 04/29/2014 09:49 PM, Ezequiel Garcia wrote:
>>> The following commit:
>>>
>>> commit 9ec36cafe43bf835f8f29273597a5b0cbc8267ef
>>> Author: Rob Herring <robh@kernel.org>
>>> Date:   Wed Apr 23 17:57:41 2014 -0500
>>>
>>>      of/irq: do irq resolution in platform_get_irq
>>>
>>> changed platform_get_irq() which now returns ENODEV and EPROBE_DEFER,
>>> in addition to ENXIO. If there's no interrupt for mvmdio, platform_get_irq()
>>> returns ENODEV, but we currently check only for ENXIO.
>>>
>>> Fix this by looking for a positive integer, which is the proper way of
>>> validating a virtual interrupt number.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>>   drivers/net/ethernet/marvell/mvmdio.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
>>> index b161a52..eb2cabf 100644
>>> --- a/drivers/net/ethernet/marvell/mvmdio.c
>>> +++ b/drivers/net/ethernet/marvell/mvmdio.c
>>> @@ -232,7 +232,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
>>>   		clk_prepare_enable(dev->clk);
>>>
>>>   	dev->err_interrupt = platform_get_irq(pdev, 0);
>>> -	if (dev->err_interrupt != -ENXIO) {
>>> +	if (dev->err_interrupt > 0) {
>>
>> Ezequiel,
>>
>> I cannot find where Rob's mentioned patch set adds -ENODEV, but isn't
>
> Well, I don't think it's not mentioned in the patch. The path is:
>
> platform_get_irq -> of_irq_get -> of_irq_parse_one -> EINVAL.
>
> So it's EINVAL, not ENODEV. But the lesson is to avoid checking for
> a particular error (except EPROBE_DEFER which is special) because
> it's a fragile practice.

Ok, thanks for the clarification.

>> the semantic for -EPROBE_DEFER: there *should* be an irq, but it is
>> not yet available. That basically means, we should also defer on that
>> error otherwise we would ignore that we have actually been given an irq
>> to work with, right?
>>
>
> Yes, I agree. Did another patch for that, but haven't send it yet.
> AFAICS, mvebu platforms will never hit the deferred case as the irqchip
> is the first driver registered (as per drivers/Makefile).
>
> Not that we should count on that :)

It doesn't hit it _now_ because of the above. I read about proper
platform_device for early devices here and there over and over
again, so I guess some day it may become an issue.

As we know about the potential -EPROBE_DEFER now, I suggest to
deal with it now, too.

Can you resend this as v2 with the other patch you mentioned
squashed in?

Sebastian

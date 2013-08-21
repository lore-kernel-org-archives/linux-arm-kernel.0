From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 21 Aug 2013 15:08:29 +0300
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <5214AC80.2090102@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
 <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
 <5214AC80.2090102@gmail.com>
Message-ID: <CAHp75VcMxLifOdAYvjg2n5fVt5HrkVPzpqHOfE+=JomqMFwGQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 3:03 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 21.08.2013 13:52, Andy Shevchenko wrote:
>> On Wed, Aug 21, 2013 at 2:35 PM, Xiang Wang <wangx@marvell.com> wrote:
>>> One thing I want to check with you and all:
>>> If we have these descriptors in the running chain:
>>> D1T1 -> D2T1 -> D3T1 => D1T2 -> D2T2 -> D3T2
>>> |    Transaction 1    | Transaction 2      |
>>>
>>> And DMA currently running to D2T1, if we provide the cookie of D3T2, what
>>> the residual value we should get? All unfinished bytes in T1+T2 or only
>>> unfinished bytes in T2 (seems not easy to implement)?
>>
>> You have a really good question. Different drivers do different things.
>
> I think the idea of how things should work is pretty clear, but I'd like
> Vinod to ack my understanding here :)
>
> The user is free to submit multiple transactions per channel, and
> dmaengine_submit() will submit a new cookie for each one.
>
> When the engine is asked about the residue of a specific cookie, it
> should of course only return the value for the related transaction. If
> that transaction is not yet processed, the residue value should be the
> complete length, regardless of the transaction that is currently processed.
>
>> In dw_dmac, for example, we return the T1 (means 'active') residue always.
>
> I'd say that's a bug.

When I wrote and sent the previous message I have the same thought.
Now I'm looking how to fix it properly (fix seems to be really
simple).
Though, we are using workflow when we didn't submit more than one
transaction at the time (which makes quite sense in case of HSUART).

-- 
With Best Regards,
Andy Shevchenko

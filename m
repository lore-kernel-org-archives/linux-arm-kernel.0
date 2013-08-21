From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 21 Aug 2013 14:52:16 +0300
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <5214A601.1010607@marvell.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
Message-ID: <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 2:35 PM, Xiang Wang <wangx@marvell.com> wrote:
> On 08/17/2013 01:05 AM, Daniel Mack wrote:
>>
>> In order to report the channel's residue, we walk the list of running
>> descriptors, look for those which match the cookie, and then try to find
>> the descriptor which defines upper and lower boundaries that embrace the
>> current transport pointer.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>

> One thing I want to check with you and all:
> If we have these descriptors in the running chain:
> D1T1 -> D2T1 -> D3T1 => D1T2 -> D2T2 -> D3T2
> |    Transaction 1    | Transaction 2      |
>
> And DMA currently running to D2T1, if we provide the cookie of D3T2, what
> the residual value we should get? All unfinished bytes in T1+T2 or only
> unfinished bytes in T2 (seems not easy to implement)?

You have a really good question. Different drivers do different things.
In dw_dmac, for example, we return the T1 (means 'active') residue always.

I don't think you have different cookies per descriptors in chain of
one transaction.

-- 
With Best Regards,
Andy Shevchenko

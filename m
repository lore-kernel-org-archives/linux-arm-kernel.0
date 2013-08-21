From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Aug 2013 13:55:27 +0200
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <5214A601.1010607@marvell.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
Message-ID: <5214AAAF.6010409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiang,

On 21.08.2013 13:35, Xiang Wang wrote:
> On 08/17/2013 01:05 AM, Daniel Mack wrote:

> Hi, Daniel
> One thing I want to check with you and all:
> If we have these descriptors in the running chain:
> D1T1 -> D2T1 -> D3T1 => D1T2 -> D2T2 -> D3T2
> |    Transaction 1    | Transaction 2      |
> 
> And DMA currently running to D2T1, if we provide the cookie of D3T2, 
> what the residual value we should get? All unfinished bytes in T1+T2 or 
> only unfinished bytes in T2 (seems not easy to implement)?

We returned the cookie of T2 when the user submitted the transaction,
and so if we're asked about the residue of cookie(T2), it should only
count bytes of T2. That's also how I implemented it.

>> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
>> +				     dma_cookie_t cookie)
>> +{
>> +	struct mmp_pdma_desc_sw *sw;
>> +	u32 curr, residue = 0;
>> +	bool passed = false;
>> +	bool cyclic = chan->cyclic_first != NULL;
>> +
>> +	/*
>> +	 * If the channel does not have a phy pointer anymore, it has already
>> +	 * been completed. Therefore, its residue is 0.
>> +	 */
>> +	if (!chan->phy)
>> +		return 0;
> 
>  From my point of view, there is one concern:
> If we want to use the End-of-Receive Interrupt (EORIRQEN in DCSR), when 
> an interrupt comes, usually it doesn't mean there is no bytes left.

If an interrupt occurs, it does because any of the descriptors has
EORIRQEN set. And an interrupt for one specific channel will occur for
the first descriptor in the list. If there is another one which has
EORIRQEN set, there will be a second one for this one, too.

For non-cyclic transfers, an occured interrupt that occurs at the end of
a transaction *does* mean that it is finished, and hence the above check
returns 0 in that case. I believe that's correct, but only as long as we
really just handle and complete the oldest transaction in the chain.

Note that for cyclic transfers, things are different, because every
descriptor in the transaction has the EORIRQEN set. That is necessary
because users want a callback after each period.

> We talked about this in this thread:
> http://thread.gmane.org/gmane.linux.kernel/1500713
> 
> I posted a patch some time ago:
> http://thread.gmane.org/gmane.linux.kernel/1510435
> There were some comments suggested by Vinod.

Yes, I've read that, and I believe that all these comments are addressed
in my series. I'll repost a v5 now, which includes one more patch to
remove the clearing of EORIRQEN of the last descriptor when a
transaction is appended.


Many thanks for your review. Much appreciated :)


Daniel

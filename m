From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Apr 2014 12:15:34 +0530
Subject: [PATCH RESEND] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <534576C3.2020409@zonque.org>
References: <1392636546-15541-1-git-send-email-zonque@gmail.com>
 <20140319151352.GJ1976@intel.com> <534576C3.2020409@zonque.org>
Message-ID: <20140416064534.GL32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 06:35:15PM +0200, Daniel Mack wrote:
> > for cookie in queue, the residue is not 0 but complete length of transaction.
> 
> Hmm, the code quoted above simply resets the internal residue counter to
> 0, and the loop will continue increasing it as it iterates more members
> of the chain_running list. Maybe the example below clarifies.
> 
> Again, the problem here is that we have multiple mmp_pdma_desc_sw
> members that belong to the same transaction.
Okay i missed that point, again.

> 
> > Possibly you should check this in mmp_pdma_tx_status and only invoke current
> > function for current transaction.
> 
> I can't, because I don't have a specific pointer that leads me to the
> current transaction inside the chain_running list. That's why I have to
> walk the list at all.
> 
> > Secondly, if you have 3 descriptor in the chain_running, the residue on last
> > will add all lengths till last one, that is not something we wnat.
> 
> Not sure wheter I follow, or if I still have a knot in my brain in
> understanding how the residue logic is supposed to work. Allow me
> illustrate this with an example, maybe that'd help either one of the two
> of us :)
> 
> Let's assume we have 3 descriptors (in terms of mmp_pdma_desc_sw) in
> chain_running, and let's assume there's only one transaction, so all 3
> descriptors are nicely chained up and the last one has the cookie we're
> looking for. Further, let's assume the DMA engine is half way through on
> the 2nd descriptor, at byte 1500.
> 
> So the layout looks something like this:
> 
> bytes: 0         1024        2048        3072
> descs: |----(1)----|----(2)----|----(3)----|
> curr:                   ^
> 
> 
> What will happen with the code above is:
> 
> 1. We start off with passed=false and residue=0
> 2. The first descriptor is looked at, /passed/ is false, and
>    (curr >= start && curr <= end) is false, so residue remains 0.
> 3. The second descriptor is looked at, /passed/ is false, but
>    (curr >= start && curr <= end) is true, and the residue is increased
>    by what's left to do in this descriptor, and /passed/ is latched so
>    we know we've passed /curr/ in the iteration.
> 4. The third descriptor is looked at, and as we've passed the /curr/
>    mark, all bytes of the descriptor are still to go, and so we add the
>    entire length of that third descriptor to the residue sum.
> 5. The cookie comparison in the end simply exists to address the fact
>    that we might have operated on an unreleated descriptor, and we have
>    to start over.
> 
> So in short, the logic will return the bytes that are not yet processed
> for a specific transaction, which is the expected thing to do, right?
Looks fine then BUT I have another questions.

Assuming that you have two txn submitted and driver split them to 3 descriptors
each, then in that case the driver would walk over all 6 descriptors and sum up
the value, which would lead to incorrect residue. It will work for single
pending txn only, right?

While at it and looking at the code again, I think right solution maybe to
update the parent child in the descriptors. So on query you simply walk the
list for all child descriptors and continue. But the parent and child are
defined under CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH.

So adding Dan (his updated email id), would it be okay if we make these as
generic in descriptor and use them to manage larger length transactions in
drivers?

> 
> >> +	ret = dma_cookie_status(dchan, cookie, txstate);
> >> +	if (likely(ret != DMA_ERROR))
> >> +		dma_set_residue(txstate, mmp_pdma_residue(chan, cookie));
> > Pls check if resuide is not NULL, then only invoke mmp_pdma_residue()
> 
> Did you mean "Pls check if *txstate* is not NULL"? I can fix that, yes.
Yup!

> 
> 
> Thanks again for your time!
> Daniel
> 

-- 

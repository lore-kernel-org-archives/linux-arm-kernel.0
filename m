From: daniel@zonque.org (Daniel Mack)
Date: Wed, 09 Apr 2014 18:35:15 +0200
Subject: [PATCH RESEND] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20140319151352.GJ1976@intel.com>
References: <1392636546-15541-1-git-send-email-zonque@gmail.com>
 <20140319151352.GJ1976@intel.com>
Message-ID: <534576C3.2020409@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 03/19/2014 04:13 PM, Vinod Koul wrote:
> On Mon, Feb 17, 2014 at 12:29:06PM +0100, Daniel Mack wrote:
> Sorry for delay, This hit my inboxwhen my vacation started...

No problem :)

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
>> +
>> +	if (chan->dir == DMA_DEV_TO_MEM)
>> +		curr = readl(chan->phy->base + DTADR(chan->phy->idx));
>> +	else
>> +		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
>> +
>> +	list_for_each_entry(sw, &chan->chain_running, node) {
>> +		u32 start, end, len;
>> +
>> +		if (chan->dir == DMA_DEV_TO_MEM)
>> +			start = sw->desc.dtadr;
>> +		else
>> +			start = sw->desc.dsadr;
>> +
>> +		len = sw->desc.dcmd & DCMD_LENGTH;
>> +		end = start + len;
>> +
>> +		/*
>> +		 * 'passed' will be latched once we found the descriptor which
>> +		 * lies inside the boundaries of the curr pointer. All
>> +		 * descriptors that occur in the list _after_ we found that
>> +		 * partially handled descriptor are still to be processed and
>> +		 * are hence added to the residual bytes counter.
>> +		 */
>> +
>> +		if (passed) {
>> +			residue += len;
>> +		} else if (curr >= start && curr <= end) {
>> +			residue += end - curr;
>> +			passed = true;
>> +		}
>> +
>> +		/*
>> +		 * Descriptors that have the ENDIRQEN bit set mark the end of a
>> +		 * transaction chain, and the cookie assigned with it has been
>> +		 * returned previously from mmp_pdma_tx_submit().
>> +		 *
>> +		 * In case we have multiple transactions in the running chain,
>> +		 * and the cookie does not match the one the user asked us
>> +		 * about, reset the state variables and start over.
>> +		 *
>> +		 * This logic does not apply to cyclic transactions, where all
>> +		 * descriptors have the ENDIRQEN bit set, and for which we
>> +		 * can't have multiple transactions on one channel anyway.
>> +		 */
>> +		if (cyclic || !(sw->desc.dcmd & DCMD_ENDIRQEN))
>> +			continue;
>> +
>> +		if (sw->async_tx.cookie == cookie) {
>> +			return residue;
>> +		} else {
>> +			residue = 0;
>> +			passed = false;
>> +		}
> for cookie in queue, the residue is not 0 but complete length of transaction.

Hmm, the code quoted above simply resets the internal residue counter to
0, and the loop will continue increasing it as it iterates more members
of the chain_running list. Maybe the example below clarifies.

Again, the problem here is that we have multiple mmp_pdma_desc_sw
members that belong to the same transaction.

> Possibly you should check this in mmp_pdma_tx_status and only invoke current
> function for current transaction.

I can't, because I don't have a specific pointer that leads me to the
current transaction inside the chain_running list. That's why I have to
walk the list at all.

> Secondly, if you have 3 descriptor in the chain_running, the residue on last
> will add all lengths till last one, that is not something we wnat.

Not sure wheter I follow, or if I still have a knot in my brain in
understanding how the residue logic is supposed to work. Allow me
illustrate this with an example, maybe that'd help either one of the two
of us :)

Let's assume we have 3 descriptors (in terms of mmp_pdma_desc_sw) in
chain_running, and let's assume there's only one transaction, so all 3
descriptors are nicely chained up and the last one has the cookie we're
looking for. Further, let's assume the DMA engine is half way through on
the 2nd descriptor, at byte 1500.

So the layout looks something like this:

bytes: 0         1024        2048        3072
descs: |----(1)----|----(2)----|----(3)----|
curr:                   ^


What will happen with the code above is:

1. We start off with passed=false and residue=0
2. The first descriptor is looked at, /passed/ is false, and
   (curr >= start && curr <= end) is false, so residue remains 0.
3. The second descriptor is looked at, /passed/ is false, but
   (curr >= start && curr <= end) is true, and the residue is increased
   by what's left to do in this descriptor, and /passed/ is latched so
   we know we've passed /curr/ in the iteration.
4. The third descriptor is looked at, and as we've passed the /curr/
   mark, all bytes of the descriptor are still to go, and so we add the
   entire length of that third descriptor to the residue sum.
5. The cookie comparison in the end simply exists to address the fact
   that we might have operated on an unreleated descriptor, and we have
   to start over.

So in short, the logic will return the bytes that are not yet processed
for a specific transaction, which is the expected thing to do, right?

>> +	ret = dma_cookie_status(dchan, cookie, txstate);
>> +	if (likely(ret != DMA_ERROR))
>> +		dma_set_residue(txstate, mmp_pdma_residue(chan, cookie));
> Pls check if resuide is not NULL, then only invoke mmp_pdma_residue()

Did you mean "Pls check if *txstate* is not NULL"? I can fix that, yes.


Thanks again for your time!
Daniel

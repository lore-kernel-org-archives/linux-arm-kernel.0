From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 09 May 2015 19:00:43 +0200
Subject: [PATCH v2 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <20150509115911.GL3521@localhost> (Vinod Koul's message of "Sat,
 9 May 2015 17:29:11 +0530")
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-4-git-send-email-robert.jarzmik@free.fr>
 <20150508063434.GZ3521@localhost> <873837uubu.fsf@belgarion.home>
 <20150509115911.GL3521@localhost>
Message-ID: <87twvln0sk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Fri, May 08, 2015 at 02:28:37PM +0200, Robert Jarzmik wrote:
>> Sorry I don't get this comment, would you care to explain me please ?
> Right now you are using very genric names which can conflict with others, so
> makese sense to add PXA_DCMD_LENGTH with me lesser prone to conflicts rather
> than DCMD_LENGTH
OK, got it, for v3.

>> >> +	} while (0)
>> >> +
>> >> +/*
>> > ??
>> > Does this code compile?
Ah I see what happens. The patch 4/5 adds :
+ * Debug fs
+ */

And fixes this. Actually this line belongs to patch 4/5, and not 3/5. That's why
I didn't see the compilation issue, I compiled with all 5 patches applied. I'll
move that comment beginner to patch 4/5, good catch.

I'll also run it through my "bissectability check" automaton to see if other
culprits lay around.

>> >> +	spin_lock_irqsave(&pdev->phy_lock, flags);
>> >> +	for (prio = pchan->prio; prio >= PXAD_PRIO_HIGHEST; prio--) {
>> >> +		for (i = 0; i < pdev->nr_chans; i++) {
>> >> +			if (prio != (i & 0xf) >> 2)
>> >> +				continue;
>> >> +			phy = &pdev->phys[i];
>> >> +			if (!phy->vchan) {
>> >> +				phy->vchan = pchan;
>> >> +				found = phy;
>> >> +				goto out_unlock;
>> > what does phy have to do with priorty here?
>> Each phy has a priority, it's part of the hardware.  IOW each phy has a "granted
>> bandwidth". This guarantee is based on the number of request on the system bus
>> the DMA IP can place.
>> 
>> In PXA2xx/PXA3xx, the DMA IP can have 8 simulaneous request. The highest
>> priority phys always get 4 slots, the high 2 slots, etc ...
>> 
>> So a priority is an intrinsic property of a phy.
> Yes that part is ok, but why are you looking up priorty while searching for
> a phy, searching thru number of channels should suffice?
This loop has this as a requirement :
 - if available, find the first free phy of priority prio
 - if not available, find the first free phy of higher priority than prio
 - etc ... up to all priorities

That fullfills the bandwidth requirement, ie. a channel request of priority prio
ends up mapped on a phy of priority prio or better. Is it any clearer now ?

>> >> +static enum dma_status pxad_tx_status(struct dma_chan *dchan,
>> >> +				      dma_cookie_t cookie,
>> >> +				      struct dma_tx_state *txstate)
>> >> +{
>> >> +	struct pxad_chan *chan = to_pxad_chan(dchan);
>> >> +	enum dma_status ret;
>> >> +
>> >> +	ret = dma_cookie_status(dchan, cookie, txstate);
>> > pls check if txstate is valid
>> My understanding is that's already the job of dma_cookie_status() and
>> dma_set_residue().
> Yes it is, but is txstate is NULL then no need to calculate residue so bail
> out here
Ah got it now, it's an optimization to not call pxad_residue() needlessly. Ok,
I'll add that for v3, good idea.

-- 
Robert

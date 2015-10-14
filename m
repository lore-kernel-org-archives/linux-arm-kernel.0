From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Oct 2015 14:12:03 +0300
Subject: [PATCH v4 20/25] dmaengine: edma: Simplify the interrupt handling
In-Reply-To: <20151014102039.GK27370@localhost>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-21-git-send-email-peter.ujfalusi@ti.com>
 <20151014102039.GK27370@localhost>
Message-ID: <561E3883.6000705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 01:20 PM, Vinod Koul wrote:
> On Thu, Sep 24, 2015 at 01:02:07PM +0300, Peter Ujfalusi wrote:
> 
>> +	if (edesc->cyclic) {
>> +		vchan_cyclic_callback(&edesc->vdesc);
>> +		spin_unlock(&echan->vchan.lock);
>> +		return;
>> +	} else if (edesc->processed == edesc->pset_nr) {
>> +		dev_dbg(dev, "Transfer completed on channel %d\n",
>> +			echan->ch_num);
> 
> perhaps not a great choice for a print, we would ideally want to complete
> the cookie and then print

OK, I have moved the print.

> 
>> +	sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 0);
>> +	if (!sh_ipr) {
>> +		sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 1);
>> +		if (!sh_ipr)
>> +			return IRQ_NONE;
>> +		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 1);
>> +		bank = 1;
>> +	} else {
>> +		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 0);
>> +		bank = 0;
>> +	}
>> +
>> +	do {
>> +		u32 slot;
>> +		u32 channel;
>> +
>> +		dev_dbg(ecc->dev, "IPR%d %08x\n", bank, sh_ipr);
> 
> Too much debug prints...

OK, removed this one and changed the dev_dbg for both completion and error
interrupt handler at the start of each function to dev_vdbg() to generate less
noise.

> 
>> +	edma_read_slot(ecc, echan->slot[0], &p);
>> +	/*
>> +	 * Issue later based on missed flag which will be sure
>> +	 * to happen as:
>> +	 * (1) we finished transmitting an intermediate slot and
>> +	 *     edma_execute is coming up.
>> +	 * (2) or we finished current transfer and issue will
>> +	 *     call edma_execute.
>> +	 *
>> +	 * Important note: issuing can be dangerous here and
>> +	 * lead to some nasty recursion when we are in a NULL
>> +	 * slot. So we avoid doing so and set the missed flag.
>> +	 */
>> +	if (p.a_b_cnt == 0 && p.ccnt == 0) {
>> +		dev_dbg(dev, "Error on null slot, setting miss\n");
> 
> Shouldn't this be err?

Probably yes. I have not seen this one ever happening, but it indicates that
something went wrong for sure.

> 
>> +		} else if (edma_read(ecc, EDMA_QEMR)) {
>> +			dev_dbg(ecc->dev, "QEMR %02x\n",
>> +				edma_read(ecc, EDMA_QEMR));
>> +			for (i = 0; i < 8; i++) {
>> +				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
>> +					/* Clear the corresponding IPR bits */
>> +					edma_write(ecc, EDMA_QEMCR, BIT(i));
>> +					edma_shadow0_write(ecc, SH_QSECR,
>> +							   BIT(i));
>> +
>> +					/* NOTE:  not reported!! */
> 
> what does this mean?

For QEMR and CCERR registers the Linux driver only acks the event, but do not
do anything.
In Linux we are not using the qDMA of the eDMA3 and there is not much we can
do when the CCERR happens.
Hrm, probably moving the CCERR print to dev_err() might be useful, but again I
have not seen this happen. But if it does, we need to come up with something
to avoid it. Basically repartition the use of Transfer Controllers, but this
can not be done with this stack. An upcoming series will give us ways to fine
tune the use of TCs.

-- 
P?ter

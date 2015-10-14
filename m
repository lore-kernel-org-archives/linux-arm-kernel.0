From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Oct 2015 14:16:06 +0300
Subject: [PATCH v4 20/25] dmaengine: edma: Simplify the interrupt handling
In-Reply-To: <561E3883.6000705@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
 <1443088932-21731-21-git-send-email-peter.ujfalusi@ti.com>
 <20151014102039.GK27370@localhost> <561E3883.6000705@ti.com>
Message-ID: <561E3976.3050100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 02:12 PM, Peter Ujfalusi wrote:
>>> +		} else if (edma_read(ecc, EDMA_QEMR)) {
>>> +			dev_dbg(ecc->dev, "QEMR %02x\n",
>>> +				edma_read(ecc, EDMA_QEMR));
>>> +			for (i = 0; i < 8; i++) {
>>> +				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
>>> +					/* Clear the corresponding IPR bits */
>>> +					edma_write(ecc, EDMA_QEMCR, BIT(i));
>>> +					edma_shadow0_write(ecc, SH_QSECR,
>>> +							   BIT(i));
>>> +
>>> +					/* NOTE:  not reported!! */
>>
>> what does this mean?
> 
> For QEMR and CCERR registers the Linux driver only acks the event, but do not
> do anything.
> In Linux we are not using the qDMA of the eDMA3 and there is not much we can
> do when the CCERR happens.
> Hrm, probably moving the CCERR print to dev_err() might be useful, but again I
> have not seen this happen. But if it does, we need to come up with something
> to avoid it. Basically repartition the use of Transfer Controllers, but this
> can not be done with this stack. An upcoming series will give us ways to fine
> tune the use of TCs.

In the interrupt handler simplification patch I move the CCERR to dev_warn()
so I leave it like this for this patch - as the function has been just moved
down in the code to be able to call the actual handler of the events.

-- 
P?ter

From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Tue, 17 Aug 2010 02:02:44 -0700
Subject: [PATCH v4] arm: msm: Add MSM IOMMU support.
In-Reply-To: <20100816183226.GA31512@phenom.dumpdata.com>
References: <1281469529-23340-1-git-send-email-stepanm@codeaurora.org>
	<20100816183226.GA31512@phenom.dumpdata.com>
Message-ID: <4C6A5034.2090406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  On 8/16/2010 11:32 AM, Konrad Rzeszutek Wilk wrote:
> I did a very brief look.
>
>> +	dmac_flush_range(fl_table, fl_table + SZ_16K);
>> +
>> +	for (i = 0; i<  4096; i++)
> Can you use a #define for the 4096? Will that value ever change?
I suppose a #define can be used, but this is a HW-specific number that 
will never ever change.

>> +		if ((fl_table[i]&  0x03) == FL_TYPE_TABLE) {
>> +			void *sl_table = __va(fl_table[i]&  0xFFFFFC00);
> Does it make sense to define say:
> #define MASK_XX (x) x&  0xFFFFFC00
> and
> #define MASK_XY (x) x&  0xFFFF0000
>
> and use those instead of these hard-coded values?
I guess so.. again, HW specific.


>> +	priv->pgtable = (unsigned long *)__get_free_pages(GFP_KERNEL, 2);
> Ugh.  Can you use get_order(SZ_16K) instead?
>
>> +	/* Invalidate context TLB */
>> +	SET_CTX_TLBIALL(base, ctx, 0);
>> +	SET_V2PPR_VA(base, ctx, va>>  12);
> Hmm, PAGE_SHIFT can't be used? Or some other #define?
I guess I can use the IOMMU PA shift. PAGE_SHIFT is not appropriate here 
because that is MMU-specific.

I can put out a v5 early next week.

Thanks
Steve

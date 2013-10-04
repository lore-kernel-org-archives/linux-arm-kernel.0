From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Oct 2013 12:03:59 -0400
Subject: [PATCH v3 6/6] ARM: mm: Change the order of TLB/cache maintenance
 operations.
In-Reply-To: <20131004155243.GT24303@mudshark.cambridge.arm.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-7-git-send-email-santosh.shilimkar@ti.com>
 <20131004155243.GT24303@mudshark.cambridge.arm.com>
Message-ID: <524EE6EF.1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 October 2013 11:52 AM, Will Deacon wrote:
> On Thu, Oct 03, 2013 at 10:18:00PM +0100, Santosh Shilimkar wrote:
>> From: Sricharan R <r.sricharan@ti.com>
>>
>> As per the arm ARMv7 manual, the sequence of TLB maintenance
>> operations after making changes to the translation table is
>> to clean the dcache first, then invalidate the TLB. With
>> the current sequence we see cache corruption when the
>> flush_cache_all is called after tlb_flush_all.
>>
>> STR rx, [Translation table entry]
>> ; write new entry to the translation table
>> Clean cache line [Translation table entry]
>> DSB
>> ; ensures visibility of the data cleaned from the D Cache
>> Invalidate TLB entry by MVA (and ASID if non-global) [page address]
>> Invalidate BTC
>> DSB
>> ; ensure completion of the Invalidate TLB operation
>> ISB
>> ; ensure table changes visible to instruction fetch
>>
>> The issue is seen only with LPAE + THUMB BUILT KERNEL + 64BIT patching,
>> which is little bit weird.
> 
> NAK.
> 
> I don't buy your reasoning. All current LPAE implementations also implement
> the multi-processing extensions, meaning that the cache flush isn't required
> to make the PTEs visible to the table walker. The dsb from the TLB_WB flag
> is sufficient, so I think you still have some debugging to do as this change
> is likely masking a problem elsewhere.
> 
> On top of that, create_mapping does all the flushing you need (for the !SMP
> case) when the tables are initialised, so this code doesn't need changing.
> 
Fair enough. We will drop this patch from this series and continue to look
at the issue further. As such the patch has no hard dependency with rest of
the series.

Regards,
Santosh

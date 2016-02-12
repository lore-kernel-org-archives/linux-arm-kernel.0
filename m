From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Feb 2016 11:35:05 -0600
Subject: [PATCH 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <20160212165707.GB20262@leverpostej>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-3-git-send-email-jeremy.linton@arm.com>
 <20160212165707.GB20262@leverpostej>
Message-ID: <56BE17C9.6090608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2016 10:57 AM, Mark Rutland wrote:
(trimming)
 > On Fri, Feb 12, 2016 at 10:06:48AM -0600, Jeremy Linton wrote:
>> +static void clear_cont_pte_range(pte_t *pte, unsigned long addr)
>> +{
>> +	int i;
>> +
>> +	pte -= CONT_RANGE_OFFSET(addr);
>> +	for (i = 0; i < CONT_PTES; i++) {
>> +		if (pte_cont(*pte))
>> +			set_pte(pte, pte_mknoncont(*pte));
>> +		pte++;
>> +	}
>> +	flush_tlb_all();
>> +}
>
> As far as I can tell, "splitting" contiguous entries comes with the same
> caveats as splitting sections. In the absence of a BBM sequence we might
> end up with conflicting TLB entries.

As I mentioned a couple weeks ago, I'm not sure that inverting a BBM to 
a full "make partial copy of the whole table->break TTBR to copy 
sequence" is so bad if the copy process maintains references to the 
original table entries when they aren't in the modification path. It 
might even work with all the CPU's spun up because the break sequence 
would just be IPI's to the remaining cpu's to replace their TTBR/flush 
with a new value. I think you mentioned the ugly part is arbitrating 
access to the update functionality (and all the implied rules of when it 
could be done). But doing it that way doesn't require stalling the CPU's 
during the "make partial copy" portion.

> However, I think we're OK for now.
>
> The way we consistently map/unmap/modify image/linear "chunks" should
> prevent us from trying to split those, and if/when we do this for the
> EFI runtime page tables thy aren't live.
>
> It would be good to figure out how to get rid of the splitting entirely.

Well we could hoist some of it earlier by taking the 
create_mapping_late() calls and doing them earlier with RWX permissions, 
and then applying the RO,ROX,RW later as necessarily.

Which is ugly, but it might solve particular late splitting cases.

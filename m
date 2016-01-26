From: zhongjiang@huawei.com (zhong jiang)
Date: Tue, 26 Jan 2016 22:05:43 +0800
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <5695DA67.5080201@huawei.com>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
 <569454F6.1060207@huawei.com> <20160112111531.GA4858@leverpostej>
 <5695DA67.5080201@huawei.com>
Message-ID: <56A77D37.10107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/13 13:02, Xishi Qiu wrote:
> On 2016/1/12 19:15, Mark Rutland wrote:
> 
>> On Tue, Jan 12, 2016 at 09:20:54AM +0800, Xishi Qiu wrote:
>>> On 2016/1/11 21:31, Mark Rutland wrote:
>>>
>>>> Hi,
>>>>
>>>> On Mon, Jan 11, 2016 at 08:59:44PM +0800, zhong jiang wrote:
>>>>>
>>>>> http://www.spinics.net/lists/arm-kernel/msg472090.html
>>>>>
>>>>> Hi, Can I ask you a question? Say, This patch tells that the section spilting
>>>>> and merging wiil produce confilct in the liner mapping area. Based on the
>>>>> situation, Assume that set up page table in 4kb page table way in the liner
>>>>> mapping area, Does the set_memroy_** will work without any conplict??
>>>>
>>>> I'm not sure I understand the question.
>>>>
>>>> I'm also not a fan of responding to off-list queries as information gets
>>>> lost.
>>>>
>>>> Please ask your question on the mailing list. I am more than happy to
>>>> respond there.
>>>>
>>>> Thanks,
>>>> Mark.
>>>>
>>>
>>> Hi Mark,
>>>
>>> In your patch it said "The presence of conflicting TLB entries may result in
>>> a variety of behaviours detrimental to the system " and "but this(break-before-make
>>> approach) cannot work for modifications to the swapper page tables that cover the
>>> kernel text and data."
>>>
>>> I'm not quite understand this, why the direct mapping can't work?
>>
>> The problem is that the TLB hardware can operate asynchronously to the
>> rest of the CPU. At any point in time, for any reason, it can decide to
>> destroy TLB entries, to allocate new ones, or to perform a walk based on
>> the existing contents of the TLB.
>>
>> When the TLB contains conflicting entries, TLB lookups may result in TLB
>> conflict aborts, or may return an "amalgamation" of the conflicting
>> entries (e.g. you could get an erroneous output address).
>>
>> The direct mapping is in active use (and hence live in TLBs). Modifying
>> it without break-before-make (BBM) risks the allocation of conflicting
>> TLB entries. Modifying it with BBM risks unmapping the portion of the
>> kernel performing the modification, resulting in an unrecoverable abort.
>>
>>> flush tlb can't resolve it?
>>
>> Flushing the TLB doesn't help because the page table update, TLB
>> invalidate, and corresponding barrier(s) are separate operations. The
>> TLB can allocate or destroy entries at any point during the sequence.
>>
>> For example, without BBM a page table update would look something like:
>>
>> 1)	str	<newpte>, [<*pte>]
>> 2)	dsb	ish
>> 3)	tlbi	vmalle1is
>> 4)	dsb	ish
>> 5)	isb
>>
>> After step 1, the new pte value may become visible to the TLBs, and the
>> TLBs may allocate a new entry for it. Until step 4 completes, this entry
>> may remain active in the TLB, and may conflict with an existing entry.
>>
>> If that entry covers the kernel text for steps 2-5, executing the
>> sequence may result in an unrecoverable TLB conflict abort, or some
>> other behaviour resulting from an amalgamated TLB, e.g. the I-cache
>> might fetch instructions from the wrong address such that steps 2-5
>> cannot be executed.
>>
>> If the kernel doesn't explicitly access the address covered by that pte,
>> there may still be a problem. The TLB may perform an internal lookup
>> when performing a page table walk, and could then use an erroneous
>> result to continue the walk, resulting in a variety of potential issues
>> (e.g. reading from an MMIO peripheral register).
>>
>> BBM avoids the conflict, but as that would mean kernel text and/or data
>> would be unmapped, you can't execute the code to finish the update.
>>
>>> I find x86 does not have this limit. e.g. set_memory_r*.
>>
>> I don't know much about x86; it's probably worth asking the x86 guys
>> about that. It may be that the x86 architecture requires that a conflict
>> or amalgamation is never visible to software, or it could be that
>> contemporary implementations happen to provide that property.
>>
>> Thanks,
>> Mark.
>>
> 
> Hi Mark,
> 
> If I do like this, does it have the problem too?
> 
> kmalloc a size
> no access
> flush tlb
> call set_memory_ro to change the page table flag
> flush tlb
> start access
> 
> Thanks,
> Xishi Qiu 
> 

Hi, Mark,

I have some confuse about the tlb conflict when split from 2M block to 4K pages.
I think if core A starts to split page table from 2M to 4K pages, with the
operation __sync_icache_dcache to make sure flush the pte to PoU. Other core
will have three kinds of situation:

1. have the old pmd cached in tlb, so it will see the old physical address.
2. have no old pmd cached in tlb, it will see the new entry when
 __sync_icache_dcache is over.
3. have no old pmd cached in tlb, it maybe see the old entry before
__sync_icache_dcache is over. But, if the core A finish tlbi and dsb sy, all
the tlbs will see the new pte.

In my opinion, It seems that the below example will only trigger tlb conflict
when merging to huge page.

For example, without BBM a page table update would look something like:
 1)	str	<newpte>, [<*pte>]
 2)	dsb	ish
 3)	tlbi	vmalle1is
 4)	dsb	ish
 5)	isb

So I have no idea about how to trigger conflict when tlb conflict.
Can you give some advice and example ?


Thanks
zhongjiang

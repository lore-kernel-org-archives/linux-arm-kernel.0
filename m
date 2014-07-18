From: marc.ceeeee@gmail.com (Marc C)
Date: Fri, 18 Jul 2014 10:32:04 -0700
Subject: [PATCH] ARM: zImage: add DSB and ISB barriers after relocating
 code
In-Reply-To: <20140602095324.GA3855@e103592.cambridge.arm.com>
References: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
 <alpine.LFD.2.11.1405222155240.17310@knanqh.ubzr>
 <537EB8F2.3090401@gmail.com>
 <20140602095324.GA3855@e103592.cambridge.arm.com>
Message-ID: <53C95A14.5030300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

My apologies for not addressing this prior to submitting my v2 of the patch.

> How is what we're trying to achieve here different from the operation
> that needs to be done in between decompressing the kernel and jumping
> to it?  Can't we just call cache_clean_flush?
>
> Except that a possibly-redundant flush of the D-cache will be done,
> this should do exactly the right thing.

I agree - I don't see why we can't just perform a cache_clean_flush
prior to jumping to the relocated code. It seems like a simpler and less
error-prone solution.

-Marc

On 6/2/14, 2:53 AM, Dave Martin wrote:
> On Thu, May 22, 2014 at 07:56:50PM -0700, Marc Carino wrote:
>> Hi Nicolas,
>>
>>> Beware... This statement isn't true in most cases.
>>
>> Ah, yes - I do have to reword that bit. (Per the booting document, the
>> I-cache can either be on or off upon entry, correct?)
>>
>>> Are you sure of that?  When the MMU is off, memory access is strongly
>>> ordered.  I'm wondering if instruction prefetching applies in that
>>> case.
>>
>> I'm unable to find a statement in the ARM architecture reference manual
>> (ARM ARM) supporting the need for the DSB, so upon second glance I think
>> I'll eliminate it.
> 
> I believe you won't find a statement in the ARM ARM supporting the view
> that you _don't_ need a DSB either :)
> 
> I believe you need it.  DSB is the only operation that can serialise
> program order against the D-side for abitrary code.
> 
> Strongly-ordered memory on the D-side guarantees that D-side operations
> cannot occur out of order with respect to this CPU, but there is still
> no guarantee about how that relates to the I-side, even with ISB.
> 
>> Anyway, you are correct. While the MMU is off, data accesses are
>> assigned the strongly-ordered memory type. However for instruction
>> fetches, memory is assigned the Normal memory type (B3.2.1). Further,
>> the architecture allows for prefetching of instructions within the
>> current and subsequent 4K page from the currently-executing program
>> counter (B3.2.3).
>>
>> Furthermore, I've encountered the "self-modifying code" example within
>> the ARM ARM, which implies that a pipeline flush is needed after
>> performing stores memory that is a part of the instruction stream.
>>
>> Another interesting tidbit is that there id no specification of
>> coherency order between data and instructions for _any_ memory type
>> (A3.9.3). It is expected that the programmer to insert an ISB to ensure
>> instruction fetches are synced-up with the most-recent view of memory.
>>
>>> Also, is this a problem that you actually experienced in practice?
>>
>> Yes.
>>
>>> Are you sure those CP15 accesses are fine on all the CPU variants
>>> that may execute this code?  Officially we still support back to
>>> ARMv4 implementations.
>>
>> No. I suppose I would have to leverage a lookup table scheme as is done
>> with the cache maintenance operations in order for this patch to be
>> portable?
> 
> How is what we're trying to achieve here different from the operation
> that needs to be done in between decompressing the kernel and jumping
> to it?  Can't we just call cache_clean_flush?
> 
> Except that a possibly-redundant flush of the D-cache will be done,
> this should do exactly the right thing.
> 
> This code is hairy to get right ... it would be better not to fragment
> it unnecessarily.
> 
> Cheers
> ---Dave
> 

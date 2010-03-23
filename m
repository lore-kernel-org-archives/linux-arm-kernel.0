From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Tue, 23 Mar 2010 14:59:14 +0100
Subject: ARM caches variants.
In-Reply-To: <1269351756.13209.34.camel@e102109-lin.cambridge.arm.com>
References: <4BA8B672.7030508@xenomai.org>	
	<1269348826.13209.10.camel@e102109-lin.cambridge.arm.com>	
	<4BA8BF0A.6030907@xenomai.org>
	<1269351756.13209.34.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4BA8C932.6060701@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Tue, 2010-03-23 at 13:15 +0000, Gilles Chanteperdrix wrote:
>> Catalin Marinas wrote:
>>> On Tue, 2010-03-23 at 12:39 +0000, Gilles Chanteperdrix wrote:
>>>> Now, the stupid question: why not using the cache colouring technique
>>>> used for VIPT caches to solve issue #3 with VIVT caches?
>>> Because with aliasing VIPT it is guaranteed that if a virtual address
>>> has the same offset in a 16KB block (i.e. the same colour - there are
>>> only 4 colours given by bits 13 and 12 of the virtual address), you get
>>> the same cache line allocated for a given physical address. The tag of a
>>> cache line is given by bits 31..14 of the physical address.
>>>
>>> With VIVT, the cache tags are not aware of the physical address, hence
>>> you can have 2^20 colours (bits 31..12 of the virtual address). You
>>> would need to map a physical address at the same virtual address in all
>>> applications sharing it (and you may end up with uClinux :)).
>> Ok. I do not get it. Let us do it in slow motion: as I understand, the
>> problem with issue #2 and #3 is not really about the tag, but about two
>> different virtual addresses ending up using different cache lines,
>> whatever the tag. By using cache colouring, can not we ensure that they
>> end up in the same cache line and simply evict each other because they
>> do not have the same tag?
>>
>> In other word, is not the cache line used by virtual address addr:
>> (addr % cache size) / (cache line size)
> 
> With any cache line, you have an index and a tag for identifying it. The
> cache may have multiple ways (e.g. 4-way associative) to speed up the
> look-up. For a 32KB 4-way associative cache you have 8KB per way (2^13).
> 
> If the cache line size is 32B (2^5), the index of a cache line is:
> 
> addr & (2^13 - 1) >> 5
> 
> e.g. bits 12..5 from the VA are used for indexing the cache line.
> 
> The tag is given by the rest of the top bits, in the above case bits
> 31..13 of the VA (if VIVT cache) or PA (VIPT cache).
> 
> The cache look-up for a VA goes something like this:
> 
>      1. extracts the index. With a 4-way associative cache there are 4
>         possible cache lines for this index
>      2. extracts the tag (from either VA or PA, depending on the cache
>         type). For VIPT caches, it needs to do a TLB look-up as well to
>         find the physical address
>      3. check the four cache lines identified by the index at step 1
>         against their tag
>      4. if the tag matches, you get a hit, otherwise a miss
> 
> For your #2 and #3 issues, if two processes map the same PA using
> different VAs, data can end up pretty much anywhere in a VIVT cache. If
> you calculate the index and tag (used to identify a cache line) for two
> different VAs, the only common part are bits 11..5 of the index (since
> they are inside a page). If you want to have the same index and tag for
> the two different VAs, you end up with having to use the same VA in both
> processes.
> 
> With VIPT caches, the tag is the same for issues #2 and #3. The only
> difference may be in a few top bits of the index. In the above case,
> it's bit 12 of the VA which may differ. This gives you two page colours
> (with 64KB 4-way associative cache you have 2 bits for the colour
> resulting in 4 colours).
> 

Thanks for the explanation, I need to read your e-mail in detail to
understand it fully. It seemed to me that having the same index was
enough to solve issues #2 and #3, and that it was possible by using
cache coulouring, but as I understand, the fact that a cache can have
multiple ways means that the same index can index several cache lines.
This is exactly the information I was looking for.

-- 
					    Gilles.

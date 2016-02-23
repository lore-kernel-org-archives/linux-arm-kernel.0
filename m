From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Feb 2016 13:26:13 +0100
Subject: [RFC PATCH 1/2] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <CAKv+Gu8oCnu6kv5SxUAdWE_Z0V+PMAKDgM6MxTi4mTm5z6EFqA@mail.gmail.com>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456149728-16706-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
 <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
 <20160222200227.GF19428@n2100.arm.linux.org.uk>
 <CAKv+Gu9gwnuu7hnYpjv7ozuKYmC8ApMakSJmYvQMaevNEd5zvA@mail.gmail.com>
 <20160223115835.GI19428@n2100.arm.linux.org.uk>
 <CAKv+Gu8oCnu6kv5SxUAdWE_Z0V+PMAKDgM6MxTi4mTm5z6EFqA@mail.gmail.com>
Message-ID: <CAKv+Gu_iEOC6E+N28pp9eEJxWFYTgLaQcBYEy1SvTUHT=cybYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2016 at 13:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 23 February 2016 at 12:58, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Feb 22, 2016 at 09:35:24PM +0100, Ard Biesheuvel wrote:
>>> OK, thanks for the historical context.
>>>
>>> So what is your opinion on this series, i.e., to wire up memremap() to
>>> remap arbitrary memory regions into the vmalloc area with MT_MEMORY_RW
>>> attributes, and at the same time lift the restriction that the region
>>> must be disjoint from memory covered by lowmem or kmap?
>>
>> The historical context is still present, because pxa2xx-flash has
>> been converted to use memremap() from ioremap_cache() - possibly
>> inappropriately.
>>
>> I've already described the semantics of ioremap_cache(), which are
>> to always create a cacheable mapping irrespective of the system
>> memory mapping type.  However, memremap() says that MEMREMAP_WB
>> matches system RAM, which on ARM it doesn't right now.
>>
>
> Indeed. Hence this series, to decouple memremap(MEMREMAP_WB) from
> ioremap_cache() for ARM
>
>> Changing it to MT_MEMORY_RW would satisfy that comment against
>> memremap(), but at the same time changes what happens with
>> pxa2xx-flash - the memory region (which is not system RAM) then
>> changes with the cache status of system RAM.
>>
>> So, I'm not that happy about the memremap() stuff right now, and
>> I don't like the idea of making memremap() conform to its stated
>> requirements without first preventing pxa2xx-flash being affected
>> by such a change.
>>
>
> Actually, my change fixes this issue, since it will cause memremap()
> to always create MT_MEMORY_RW mappings, and not fallback to
> ioremap_cache() for ranges that are not covered by lowmem.
>
>> Perhaps we need to reinstate the original ioremap_cached() API for
>> pxa2xx-flash, and then switch memremap() to MT_MEMORY_RW - that
>> would seem to result in the expected behaviour by all parties.
>>
>
> I think we can simply revert the change to pxa2xx-flash if it is
> deemed inappropriate.

OK, I see what you mean. I find it unfortunate that ioremap_cache()
instances are blindly being replaced with memremap(), and I wonder if
this wasted test by and/or cc'ed to people who can actually test this
driver. Dan?

Anyway, I don't think it makes sense to stipulate at the generic level
that ioremap_cache() and memremap(MEMREMAP_WB) shall be the same, and
deprecating it is a bit premature since the cross-architecturally
loosely defined semantics of ioremap_cache() can never be replaced 1:1
with what memremap() promises.

So what I suggest is that I revert the change to pxa2xx-flash as a new
1/3 in this series, and put these existing two on top to decouple
memremap(MEMREMAP_WB) from ioremap_cache() entirely.

Thanks,
Ard.

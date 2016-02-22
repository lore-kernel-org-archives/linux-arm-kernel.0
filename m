From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:35:24 +0100
Subject: [RFC PATCH 1/2] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <20160222200227.GF19428@n2100.arm.linux.org.uk>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456149728-16706-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
 <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
 <20160222200227.GF19428@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9gwnuu7hnYpjv7ozuKYmC8ApMakSJmYvQMaevNEd5zvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2016 at 21:02, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 22, 2016 at 08:17:11PM +0100, Ard Biesheuvel wrote:
>> I am not exactly sure why ioremap_cache() does not use MT_MEMORY_RW
>> attributes, but the ARM architecture simply does not allow mismatched
>> attributes, so we cannot simply replace each instance of
>> ioremap_cache() with memremap()
>>
>> Perhaps Russell can explain?
>
> ARM has had ioremap_cached() for a while - it was introduced in the
> bitkeeper times of 2.6, so pre-git.  In those kernels, and into the
> git era, pre-dating ARMv6 support, it was merely:
>
> +#define ioremap_cached(cookie,size)    __arch_ioremap((cookie),(size),L_PTE_CACHEABLE)
>
> which means that we got write-through cache behaviour for mappings
> created by this, where supported, or if not, read-allocate writeback.
> This was completely independent of the system memory mapping
> attributes, which could be specified on the kernel command line.
>
> This was originally used by pxa2xx-flash to provide faster flash
> access on those systems - in other words, it's created to remap
> devices with cacheable attributes.
>
> When creating ARMv6 support, I ended up completely rewriting how
> the memory attributes were handled, and so it then became this:
>
> +#define ioremap_cached(cookie,size)    __arch_ioremap((cookie), (size), MT_DEVICE_CACHED)
>
> which gives very similar behaviour, though we now default to RAWB
> mappings, which fall back to WT on CPUs that don't support RAWB.
> Again, independent of the system memory mapping.
>
> Then, in 2013, with the advent of Xen, ioremap_cached() became
> ioremap_cache() so that Xen would build on ARM, and to align it
> with other architectures.  Whether ioremap_cached() actually was
> suitable to become ioremap_cache(), I'm not sure, but that's
> what happened.
>
> Since it was just renamed, it preserves the original goal which is
> to remap device memory with cacheable attributes, which may differ
> from the cacheable attributes of the system RAM.  It has never
> been intended for remapping system memory: none of the ioremap_*
> family of functions on ARM were ever intended for that purpose.
>
> However, some people did use it for that purpose on ARMv5 and
> earlier architectures, where, due to the virtual cache architecture,
> you could get away with remapping the same memory with differing
> attributes without any problem.  With the advent of ARMv6
> (pre-dating 2013), this was clearly stated as being illegal at
> architecture level, but people were married to the idea - despite
> me telling them not to.
>
> So eventually, I had no other option than to add a code check to
> ioremap*() which prevents any ioremap*() function from being used
> on system memory - iow, memory that Linux maps itself either as
> part of lowmem or via the kmap*() API - since an ioremap*()
> mapping would conflict with those.
>
> That's basically where we are today: ioremap*() does not permit
> system memory to be remapped, even ioremap_cache().
>

OK, thanks for the historical context.

So what is your opinion on this series, i.e., to wire up memremap() to
remap arbitrary memory regions into the vmalloc area with MT_MEMORY_RW
attributes, and at the same time lift the restriction that the region
must be disjoint from memory covered by lowmem or kmap?

It would make my life a lot easier, since we can more easily share
code between x86, arm64 and ARM to permanently map memory regions that
have been populated by the firmware. As I noted in the commit log,
memremap() already does the right thing wrt lowmem, i.e., it returns
the existing mapping rather than creating a new one. For highmem, I
don't think kmap() is the way to go considering the unknown size and
the potentially permanent nature of the mappings (which resemble
ioremap more than they resemble kmap)

-- 
Ard.

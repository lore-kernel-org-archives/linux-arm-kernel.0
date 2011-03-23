From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Mar 2011 12:26:39 +0000
Subject: memmap_valid_within problem with sparsely populated sections
In-Reply-To: <1299858492.11981.6.camel@e102144-lin.cambridge.arm.com>
References: <1299858492.11981.6.camel@e102144-lin.cambridge.arm.com>
Message-ID: <1300883199.28839.97.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-11 at 15:48 +0000, Will Deacon wrote:
> Hello,

Replying to myself...

> In commit eb33575c ("[ARM] Double check memmap is actually valid with a memmap
> has unexpected holes V2"), a new function, memmap_valid_within, was introduced
> to mmzone.h so that holes in the memmap which pass pfn_valid in SPARSEMEM
> configurations can be detected and avoided.
> 
> The fix to this problem checks that the pfn <-> page linkages are correct by
> calculating the page for the pfn and then checking that page_to_pfn on that
> page returns the original pfn. Unfortunately, in SPARSEMEM configurations, this
> results in reading from the page flags to determine the correct section. Since
> the memmap here has been freed, junk is read from memory and the check is no
> longer robust.
> 
> In the best case, reading from /proc/pagetypeinfo will give you the wrong
> answer. In the worst case, you get SEGVs, Kernel OOPses and hung CPUs.
> 
> It seems that the only code which can really tell you if the pfn has a valid
> corresponding page is architecture-specific. Indeed, the ARM implementation of
> pfn_valid will give you the correct answer. I think that memmap_valid_within
> needs to check whether the pfn has a struct page associated with it before
> blindly reading the page flags:

I think it's worth pointing out that freeing the memmap backing the
unused parts of SPARSEMEM sections is really a worthwhile thing to do.
Consider a platform with two 1GB sections at 0x0 and 0x80000000. If the
command line reads mem=256M at 0x0, mem=256M at 0x80000000 then we have 1.5GB
of unused section space (393216 pages).

If struct page is 32 bytes, then we're wasting 12MB of our memory on
unused memmap entries. One option is to reduce the section size, but
that introduces penalties elsewhere and still doesn't prevent the user
from passing a command line which exhibits the problem above.

Providing a hook like the one I originally suggested allows SPARSEMEM to
handle these holes without impacting architectures that leave the unused
memmap entries intact.

Will

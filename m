From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 02 Dec 2010 16:56:33 +0000
Subject: Cache maintenance on page table updates
In-Reply-To: <AANLkTikHpQLh53JN4OhjS2_T9XC=66Lk1MMPh2y1jc3u@mail.gmail.com>
References: <AANLkTikHpQLh53JN4OhjS2_T9XC=66Lk1MMPh2y1jc3u@mail.gmail.com>
Message-ID: <1291308993.11271.60.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Thu, 2010-12-02 at 16:39 +0000, Christoffer Dall wrote:
> When I update the page table mappings' AP bits, it is for some reason
> not enough to clean caches, but I must also invalidate them for the
> changes to take effect. The system runs on an arm1136 processor and I
> was under the impression that page table walks never read from the L1
> cache. If this is true, I cannot understand why an invalidation of
> caches would make a difference.

Cleaning the D-cache should be enough. If you modified an existing valid
page table entry, you also need to issue a TLB invalidation.

Also make sure that you have a DSB after that operation (the TLB
functions in Linux do this already) since cache cleaning happens in
background and may not finish by the time you need to access the page
table. Maybe the invalidation just adds some extra delay.

If the page table walks would read from L1, you don't even need to do
the cache cleaning.

> In the course of understanding this behavior I have come across the
> RGN, S and C bits in the TTBR0. I don't quite understand how these
> bits affect the memory system - should they simply match the way that
> the page tables themselves are mapped in virtual memory or do they
> somehow control how the page table walk mechanism behaves?

These bits should follow the same attributes which are used for mapping
the page table entry (in Linux normal cacheable), even though the
hardware may not support L1 page table walks (and you need the extra
cache flushing).

-- 
Catalin

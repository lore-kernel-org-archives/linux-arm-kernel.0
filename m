From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Dec 2011 22:41:51 +0000
Subject: Oops in guest after ioremap() on ARMv7
In-Reply-To: <20111222192923.GN2577@n2100.arm.linux.org.uk>
References: <4EF31DA7.9030407@citrix.com> <20111222144937.GE20635@arm.com>
 <4EF35CFF.3050200@citrix.com> <20111222181356.GI20635@arm.com>
 <20111222192923.GN2577@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk49U52XaD841JE2HRxmAeFNQ7sT+7VbHFXWqJTR6=+uBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2011 19:29, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 22, 2011 at 06:13:56PM +0000, Catalin Marinas wrote:
>> It could as well be a model bug but people are on holiday at the moment
>> (and I'm off shortly as well, until 3rd of January). Could you try to
>> disable the cacheability of the page table walks for both stage 1 (TTBRx
>> with classic page tables or TTBCR with LPAE) and stage 2 (VTCR)? Since
>> Linux does the correct cache flushing and I assume the hypervisor as
>> well, this may work around possible model bug.
>
> Note that Linux, through and through, expects that page table entries are
> not negatively cached. ?Non-present page table entries are expected to be
> refetched without requiring any kind of TLB flushing at any point.

The TLB on ARM does not do any negative caching. Full translations are
only stored if the page table walk succeeds. You may get some partial
caching (like level 1) if there is a valid entry in the page table but
that's not negative caching. For this scenario we have the
(pmd|pte)_free_tlb() implementation.

What caching attributes in TTBR/TTBCR/VTCR mean is looking up the page
table in the L1 cache so that we don't need to do extra cache
flushing.

-- 
Catalin

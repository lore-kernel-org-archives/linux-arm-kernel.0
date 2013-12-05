From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Dec 2013 16:53:53 +0000
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <CAC8NTUVvLgNPdsSPY6Ms_D3JoyJR8AEFRH0=M7-kQEUegNVhKg@mail.gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <5295D1A5.5090403@arm.com>
 <CAC8NTUXiMpjNh+GBTGcLDJ2hevskWnD6PE66ZaFxBAdUuy2nbg@mail.gmail.com>
 <5296330D.9010801@arm.com>
 <CAC8NTUVvLgNPdsSPY6Ms_D3JoyJR8AEFRH0=M7-kQEUegNVhKg@mail.gmail.com>
Message-ID: <20131205165353.GC1495@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 02:14:30AM +0000, Radha Mohan wrote:
> On Wed, Nov 27, 2013 at 11:29 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > So should the 4-level page table cost be unconditionally forced onto all
> > implementations?

Definitely not.

> We can have a kernel compile-time config option so that platforms having
> a 48-bit PA can select that option. But having it will create the code something
> like below
> 
> #ifndef CONFIG_ARM64_64KB_PAGES
> #ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
> ...
> ..
> #else
> ..
> ..
> #endif
> #else /* !CONFIG_ARM64_64KB_PAGES */
> #ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
> ..
> ..
> #else
> ..
> ..
> #endif
> #endif /* CONFIG_ARM64_64KB_PAGES */
> 
> And we might need to do this at lot of places. Is this ok?

We have to figure a way to avoid this. I haven't looked in detail at the
patches (BTW, please cc the arm64 maintainers on the next version) but I
think we could restrict the #ifdef's to much fewer headers (primarily
asm/page.h and asm/pgtable-hwdef.h). What I'm thinking is to have:

pgtable-2level-*.h	64K pages only
pgtable-3level-*.h	4K and 64K pages support
pgtable-4level-*.h	4K pages only

You can move the PTRS_PER_* and PMD_SHIFT etc. macros to some common
header as these depend on the page size. The other definitions like pmd_t
depend on the number of page table levels. With some care you could
define PMD_SHIFT for 64K into a single file with some #ifdef's around
__PAGETABLE_PMD_FOLDED. Same for PUD_SHIFT with 4K pages.

-- 
Catalin

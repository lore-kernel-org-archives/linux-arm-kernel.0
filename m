From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Feb 2015 16:29:00 +0000
Subject: [RFC PATCH 3/3] arm64: KVM: use ID map with increased VA range
 if required
In-Reply-To: <20150226161146.GA17949@e104818-lin.cambridge.arm.com>
References: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
 <1424964547-2118-4-git-send-email-ard.biesheuvel@linaro.org>
 <20150226161146.GA17949@e104818-lin.cambridge.arm.com>
Message-ID: <20150226162900.GB17949@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 04:11:47PM +0000, Catalin Marinas wrote:
> On Thu, Feb 26, 2015 at 03:29:07PM +0000, Ard Biesheuvel wrote:
> > +	/*
> > +	 * If we are running with VA_BITS < 48, we may be running with an extra
> > +	 * level of translation in the ID map. This is only the case if system
> > +	 * RAM is out of range for the currently configured page size and number
> > +	 * of translation levels, in which case we will also need the extra
> > +	 * level for the HYP ID map, or we won't be able to enable the EL2 MMU.
> > +	 *
> > +	 * However, at EL2, there is only one TTBR register, and we can't switch
> > +	 * between translation tables *and* update TCR_EL2.T0SZ at the same
> > +	 * time. Bottom line: we need the extra level in *both* our translation
> > +	 * tables.
> 
> It doesn't sound too nice but I'm not sure we can do much about it.
> 
> > +	 *
> > +	 * Fortunately, there is an easy way out: the existing ID map, with the
> > +	 * extra level, can be reused for both. The kernel image is already
> > +	 * identity mapped at a high virtual offset, which leaves VA_BITS of
> > +	 * address space at the low end to put our runtime HYP mappings.
> > +	 */
> 
> Another aspect here is that the Hyp VA starts at HYP_PAGE_OFFSET which
> is 1 << (VA_BITS - 1). On some platforms we may get an overlap with the
> physical memory (and the original idmap). Could we switch to the
> dedicated hyp TTBR at this point, with the extra level? Functions like
> __create_hyp_mapping() don't need to know about this extra level as
> hyp_pgd only knows about 4 levels but TTBR0_EL2 would point to the extra
> level.

I meant "hyp_pgd only knows about 3 levels (or 2, depending on the
configuration; same as the host kernel TTBR1_EL1)"

-- 
Catalin

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 05 May 2010 17:23:52 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the
	ARMv6 DMA cache ops
In-Reply-To: <o2md91d07041005041004v50aba49bydacf4971a59d413c@mail.gmail.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<o2md91d07041005041004v50aba49bydacf4971a59d413c@mail.gmail.com>
Message-ID: <1273076632.27058.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-04 at 18:04 +0100, Jason McMullan wrote:
> On Tue, May 4, 2010 at 12:44 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > The Snoop Control Unit on the ARM11MPCore hardware does not detect the
> > cache operations and the dma_cache_maint*() functions may leave stale
> > cache entries on other CPUs. The solution implemented in this patch
> > performs a Read or Write For Ownership in the ARMv6 DMA cache
> > maintenance functions. These LDR/STR instructions change the cache line
> > state to shared or exclusive so that the cache maintenance operation has
> > the desired effect.
> 
> Is latter portion of this patch required only for SMP MPCore systems, or is
> it also required for uniprocessor MPCore configurations?

It's required for MPCore to work correctly but it's harmless for UP.
It's actually a performance improvement since we don't invalidate the
D-cache twice in map and unmap (and we don't have speculative fetches
into the D-cache on v6).

-- 
Catalin

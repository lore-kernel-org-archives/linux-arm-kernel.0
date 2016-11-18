From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Nov 2016 16:46:02 +0000
Subject: [PATCHv3 5/6] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <20161118143543.GC1197@leverpostej>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
 <1479431816-5028-6-git-send-email-labbott@redhat.com>
 <20161118143543.GC1197@leverpostej>
Message-ID: <20161118164602.GD1197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 02:35:44PM +0000, Mark Rutland wrote:
> Hi Laura,
> 
> On Thu, Nov 17, 2016 at 05:16:55PM -0800, Laura Abbott wrote:
> > 
> > __pa_symbol is technically the marco that should be used for kernel
> > symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL which
> > will do bounds checking.
> > 
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > v3: Conversion of more sites besides just _end. Addition of __lm_sym_addr
> > macro to take care of the _va(__pa_symbol(..)) idiom.
> > 
> > Note that a copy of __pa_symbol was added to avoid a mess of headers
> > since the #ifndef __pa_symbol case is defined in linux/mm.h
> 
> I think we also need to fix up virt_to_phys(__cpu_soft_restart) in
> arch/arm64/kernel/cpu-reset.h. Otherwise, this looks complete for uses
> falling under arch/arm64/.

I think I spoke too soon. :(

In the kasan code, use of tmp_pg_dir, kasan_zero_{page,pte,pmd,pud} all
need to be vetted, as those are in the image, but get passed directly to
functions which will end up doing a virt_to_phys behind the scenes (e.g.
cpu_replace_ttbr1(), pmd_populate_kernel()).

There's also some virt_to_pfn(<symbol>) usage that needs to be fixed up
in arch/arm64/kernel/hibernate.c.

... there's also more of that in common kernel code. :(

Thanks,
Mark.

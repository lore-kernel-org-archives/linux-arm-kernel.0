From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 May 2010 15:08:51 +0100
Subject: [PATCH v2] ARMv7: Use the Inner Shareable I-cache on MP
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C566661F@dbde02.ent.ti.com>
References: <1274271062-30807-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTim03PQYiNGNzxNfs-MkyFSZgc2DKMxVMoJzxSnR@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C566661F@dbde02.ent.ti.com>
Message-ID: <1274278131.3196.35.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-19 at 13:39 +0100, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of S, Venkatraman
> > Sent: Wednesday, May 19, 2010 6:06 PM
> > To: Shilimkar, Santosh
> > Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; Catalin Marinas
> > Subject: Re: [PATCH v2] ARMv7: Use the Inner Shareable I-cache on MP
> >
> > Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> > > This patch fixes the flush_cache_all for ARMv7 SMP. It was
> > > missing from commit b8349b569aae661dea9d59d7d2ee587ccea3336c
> > >
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > > Updated version after removing the not necessary second hunk
> > >
> > > arch/arm/mm/cache-v7.S |    4 ++++
> > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> > > index 06a90dc..5009635 100644
> > > --- a/arch/arm/mm/cache-v7.S
> > > +++ b/arch/arm/mm/cache-v7.S
> > > @@ -91,7 +91,11 @@ ENTRY(v7_flush_kern_cache_all)
> > >  THUMB(        stmfd   sp!, {r4-r7, r9-r11, lr}        )
> > >        bl      v7_flush_dcache_all
> > >        mov     r0, #0
> > > +#ifdef CONFIG_SMP
> > > +       mcr     p15, 0, r0, c7, c1, 0           @ invalidate I-cache inner shareable
> > > +#elese
> >
> > s/elese/else
> >
> oops ... Will correct this while submitting to the patch
> system

With the typo fixed:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

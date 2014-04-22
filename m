From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 14:26:24 +0100
Subject: [PATCH v3] arm64: enable EDAC on arm64
In-Reply-To: <CAL_JsqKS_NZbxq_nFBnsQvj51TtraEeFm0aY=j=N3DwJ+bTL6g@mail.gmail.com>
References: <1398096556-26799-1-git-send-email-robherring2@gmail.com>
 <20140422102455.GD7484@arm.com>
 <CAL_JsqKS_NZbxq_nFBnsQvj51TtraEeFm0aY=j=N3DwJ+bTL6g@mail.gmail.com>
Message-ID: <20140422132624.GC9820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 01:54:12PM +0100, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 5:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Apr 21, 2014 at 05:09:16PM +0100, Rob Herring wrote:
> >> +#ifndef ASM_EDAC_H
> >> +#define ASM_EDAC_H
> >> +/*
> >> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
> >
> > What do you mean by `DMA safe'? For coherent (cacheable) DMA buffers, this
> > should work fine, but for non-coherent (and potentially non-cacheable)
> > buffers, I think we'll have problems both due to the lack of guaranteed
> > exclusive monitor support and also eviction of dirty lines.
> 
> That's just copied from other implementations. I agree you could have
> a problem here although I don't see why dirty line eviction would be.

I was thinking of the case where you have an ongoing, non-coherent DMA
transfer from a device and then the atomic_scrub routine runs in parallel
on the CPU, targetting the same buffer. In this case, the stxr could store
stale data back to the buffer, leading to corruption (since the monitor
won't help). This differs from the case where the monitor could always
report failure for non-cacheable regions, causing atomic_scrub to livelock.

> There's not really a solution other than not doing s/w scrubbing or
> doing it in h/w. So it is up to individual drivers to decide what to
> do, but we have to provide this function just to enable EDAC.

I think we need to avoid s/w scrubbing of non-cacheable memory altogether.

Will

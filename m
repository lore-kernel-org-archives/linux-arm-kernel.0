From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Mar 2016 14:03:35 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <56E95A4E.4050709@codeaurora.org>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
Message-ID: <20160316140334.GA17680@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 08:06:22AM -0500, Timur Tabi wrote:
> Will Deacon wrote:
> >Unfortunately, the original patch is required to support the 128-byte L1
> >cache lines of Cavium ThunderX, so we can't simply revert it like this.
> >Similarly, the desire for a single, multiplatform kernel image prevents
> >us from reasonably fixing this at compile time to anything other than
> >the expected maximum value.
> >
> >Furthermore, Timur previously said that the change is also required
> >"on our [Qualcomm] silicon", but I'm not sure if this is msm9886 or not:
> >
> >http://lkml.kernel.org/r/CAOZdJXUiRMAguDV+HEJqPg57MyBNqEcTyaH+ya=U93NHb-pdJA at mail.gmail.com
> 
> I was talking about our server part, the QDF2432.  At the time, I
> wasn't allowed to mention it by name.
> 
> >You could look into making ARCH_DMA_MINALIGN a runtime value, but that
> >looks like an uphill struggle to me. Alternatively, we could only warn
> >if the CWG is bigger than L1_CACHE_BYTES *and* we have a non-coherent
> >DMA master, but that doesn't solve any performance issues from having
> >things like locks sharing cachelines, not that I think we ever got any
> >data on that (afaik, we don't pad locks to cacheline boundaries anyway).
> >I'm also not sure what it would mean for PCI NoSnoop transactions.
> 
> Our internal version of this patch made it a Kconfig option.
> Perhaps that would at least be an improvement over just reverting
> it?  We already have to have our own defconfig for the QDF2432.

While having an option for producing a less-portable, performance tuned kernel
might not be the end of the world, the defconfig is intended to function
correctly on all platforms (assuming LE and 4K page support).

Even if we were to add the option, the default would have to be the maximum
size known to be implemented.

If I understand correctly, the main reason that we need this for correctness is
non-coherent DMA to/from SLAB caches.

A more general approach (and more invasive, but perhaps less so than making
ARCH_DMA_MINALIGN usage completely dynamic) would be to determine at runtime
whether the CWG is larger than the configured ARCH_DMA_MINALIGN, and if so,
force the use of bounce buffers (which could be padded to the architectural
maximum of 2K) for non-coherent DMA. That nicely degrades to not mattering for
the case of coherent DMA.

I would consider NoSnoop a separate case. It's closer to "negatively coherent",
and always required page-aligned buffer anyway due to MMU behaviour.

Thanks,
Mark.

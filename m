From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Mar 2016 14:54:43 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160316143534.GI18387@arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316140334.GA17680@svinekod> <20160316143534.GI18387@arm.com>
Message-ID: <20160316145406.GA19170@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 02:35:35PM +0000, Will Deacon wrote:
> On Wed, Mar 16, 2016 at 02:03:35PM +0000, Mark Rutland wrote:
> > If I understand correctly, the main reason that we need this for correctness is
> > non-coherent DMA to/from SLAB caches.
> > 
> > A more general approach (and more invasive, but perhaps less so than making
> > ARCH_DMA_MINALIGN usage completely dynamic) would be to determine at runtime
> > whether the CWG is larger than the configured ARCH_DMA_MINALIGN, and if so,
> > force the use of bounce buffers (which could be padded to the architectural
> > maximum of 2K) for non-coherent DMA. That nicely degrades to not mattering for
> > the case of coherent DMA.
> >
> > I would consider NoSnoop a separate case. It's closer to "negatively coherent",
> > and always required page-aligned buffer anyway due to MMU behaviour.
> 
> What makes you say that? There are no such alignment requirements for
> buffers that may be accessed with a NoSnoop transaction. On ARM, we'll
> have a mismatched alias, but we'd need to solve that with explicit
> cache maintenance (and my understanding is that's what things like GPU
> drivers already do on x86).

I was under the impression that NoSnoop transactions were permitted to be
Cacheable, even if non-snooping (e.g. allowing them to allocate and hit in a
system cache).

If that is permitted, then data corruption could potentially occur in the
presence of another cacheable alias due to things like line migration (e.g. a
CPU making a speculative fetch and taking ownership of a line that was in the
system cache). To avoid that, you'd have to remove any cachable alias, for
which we only have page-granular control.

If that is not permitted, then no-snoop is effectively non-cacheable and
non-coherent, and my comment doesn't hold.

Thanks,
Mark.

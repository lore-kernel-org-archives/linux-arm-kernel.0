From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Mar 2016 14:35:35 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160316140334.GA17680@svinekod>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316140334.GA17680@svinekod>
Message-ID: <20160316143534.GI18387@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 02:03:35PM +0000, Mark Rutland wrote:
> If I understand correctly, the main reason that we need this for correctness is
> non-coherent DMA to/from SLAB caches.
> 
> A more general approach (and more invasive, but perhaps less so than making
> ARCH_DMA_MINALIGN usage completely dynamic) would be to determine at runtime
> whether the CWG is larger than the configured ARCH_DMA_MINALIGN, and if so,
> force the use of bounce buffers (which could be padded to the architectural
> maximum of 2K) for non-coherent DMA. That nicely degrades to not mattering for
> the case of coherent DMA.
>
> I would consider NoSnoop a separate case. It's closer to "negatively coherent",
> and always required page-aligned buffer anyway due to MMU behaviour.

What makes you say that? There are no such alignment requirements for
buffers that may be accessed with a NoSnoop transaction. On ARM, we'll
have a mismatched alias, but we'd need to solve that with explicit
cache maintenance (and my understanding is that's what things like GPU
drivers already do on x86).

Will

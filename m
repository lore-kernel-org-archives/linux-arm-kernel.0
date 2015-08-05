From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Aug 2015 10:16:08 +0100
Subject: [PATCH] arm64: mm: ensure patched kernel text is fetched from PoC
In-Reply-To: <20150804214522.GA14625@leverpostej>
References: <1438715013-4625-1-git-send-email-will.deacon@arm.com>
 <20150804214522.GA14625@leverpostej>
Message-ID: <20150805091607.GA6092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 10:45:23PM +0100, Mark Rutland wrote:
> I assume that you meant PoU rather than PoC in the subject.

Oops, well spotted!

> On Tue, Aug 04, 2015 at 08:03:33PM +0100, Will Deacon wrote:
> > The arm64 booting document requires that the bootloader has cleaned the
> > kernel image to the PoC. However, when a CPU re-enters the kernel due to
> > either a CPU hotplug "on" event or resuming from a low-power state (e.g.
> > cpuidle), the kernel text may in-fact be dirty at the PoU due to things
> > like alternative patching or even module loading.
> > 
> > Thanks to I-cache speculation with the MMU off, stale instructions could
> > be fetched prior to enabling the MMU, potentially leading to crashes
> > when executing regions of code that have been modified at runtime.
> > 
> > This patch addresses the issue by ensuring that the local I-cache is
> > invalidated immediately after a CPU has enabled its MMU but before
> > jumping out of the identity mapping. Any stale instructions fetched from
> > the PoC will then be discarded and refetched correctly from the PoU.
> 
> It may be worth mentioning that none of the instructions executed up to
> this point will have been patched, so we know that they have remained
> clean to the PoC. Otherwise we'd need to flush those to the PoC
> explicitly.

I'll add something to the log.

> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Cheers,

Will

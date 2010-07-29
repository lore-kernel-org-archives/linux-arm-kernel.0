From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 22:21:17 +0100
Subject: [PATCH] [ARM] highmem: fix SMP preemption bug in kmap_high_l1_vipt
In-Reply-To: <alpine.LFD.2.00.1007291058140.20337@xanadu.home>
References: <1280366705-21334-1-git-send-email-gking@nvidia.com>
	<alpine.LFD.2.00.1007291058140.20337@xanadu.home>
Message-ID: <20100729212117.GB28330@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 10:59:52AM -0400, Nicolas Pitre wrote:
> On Wed, 28 Jul 2010, gking at nvidia.com wrote:
> 
> > From: Andrew Howe <ahowe@nvidia.com>
> > 
> > smp_processor_id() must not be called from a preemptible context (this
> > is checked by CONFIG_DEBUG_PREEMPT).  kmap_high_l1_vipt() was doing so.
> > This lead to a problem where the wrong per_cpu kmap_high_l1_vipt_depth
> > could be incremented, causing a BUG_ON(*depth <= 0); in
> > kunmap_high_l1_vipt().
> > 
> > The solution is to move the call to smp_processor_id() after the call
> > to preempt_disable().
> > 
> > Signed-off-by: Gary King <gking@nvidia.com>
> 
> Acked-by: Nicolas Pitre <nico.as.pitre@linaro.org>
> 
> Please forward to RMK's patch system.

Unfortunately, I suspect that none of the remaining stuff in my master
branch will make 2.6.35 (which is due this evening) especially as I've
put the fixes for the Versatile/Realview/Versatile Express MMC card
detection in there today, and we still don't know what's right for its
GPIO-based card detection.  (The change to fix the status method may
have broken the GPIO-based method.)

So I'm not sending a pull request this evening.  Hopefully people can
work out what's right for the GPIO based card detection while I'm out
tomorrow, and report back so it can be fixed in the evening if
necessary.

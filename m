From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 May 2012 17:30:16 +0100
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <1331876668-32492-3-git-send-email-nico@fluxnic.net>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
 <1331876668-32492-3-git-send-email-nico@fluxnic.net>
Message-ID: <20120506163016.GA7412@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 01:44:28AM -0400, Nicolas Pitre wrote:
> More code is getting involved through devicemaps_init() these days,
> including calls to printk() or BUG().  Not being able to access any
> device to print out debugging information and only being presented with
> a silent kernel crash in that case has become a major inconvenience
> lately.
> 
> By having the active page table separate from the one being initialized,
> it is possible to preserve the initial debug mapping that was set in
> head.S until the final page table is ready.  Because there exists some
> code that installs a partial mapping in order to probe the hardware
> before installing additional mappings, it is necessary to set up the
> vector mapping early which enables the fault handler to copy some of
> the newly created mappings into our page table copy as needed.
> 
> This patch implements such a temporary page table copy only for
> non LPAE configurations at the moment.

I've been thinking about this on and off since you posted it, and I'm now
convinced this will cause regressions.  You've probably forgotten about
those CPUs which need to read data in order to clear unwanted cache lines
from their cache.

This patch would cause all such CPUs to freeze when switching to or from
the temporary mapping, because neither page table will contain the necessary
mappings to allow those accesses to succeed.

So I don't think this approach can work.

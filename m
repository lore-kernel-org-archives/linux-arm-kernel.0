From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 01:42:11 +0200
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <20130507230445.GC9105@kroah.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <20130507230445.GC9105@kroah.com>
Message-ID: <201305080142.12025.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Greg Kroah-Hartman wrote:
> On Tue, May 07, 2013 at 04:53:52PM -0600, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>

> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> So this needs to go in for 3.10, right?  Any older kernels as well?  If
> so, which ones?

The fix should definitely go into 3.10, but I'd suggest waiting with
the backport for a couple of -rc releases to avoid possible regressions.
We know that the current code is broken, but few people fully understand
what is going on with coherent_dma_mask, so it might cause new problems
in combination with some other unknown bug, and I don't see this as
urgent: none of the ARM defconfigs build this driver as a loadable
module and there is no bug in the built-in case. For some reason, only
the ARM back-end drivers are broken.

The first occurence was apparently in 3.3, but only in ehci-tegra.c,
while the other drivers subsequently copied the bug.

	Arnd

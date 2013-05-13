From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 15:38:59 -0400
Subject: [PATCH] ARM: Orion: Remove redundent init_dma_coherent_pool_size()
In-Reply-To: <516F0AF1.2090905@free-electrons.com>
References: <1352356737-14413-1-git-send-email-m.szyprowski@samsung.com>
 <1352655079-1005-1-git-send-email-andrew@lunn.ch>
 <20130417203806.GE27197@titan.lakedaemon.net>
 <516F0AF1.2090905@free-electrons.com>
Message-ID: <20130513193859.GW31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 10:49:53PM +0200, Gregory CLEMENT wrote:
> On 04/17/2013 10:38 PM, Jason Cooper wrote:
> > Andrew,
> > 
> > Now that we finally have Soren Moch's (sp? sorry) cache exhaustion
> > solved, can we respin this for v3.11?  I'd like to include mvebu as well
> > if possible.
> 
> For mvebu, I can do a follow-up patch, or Andrew can directly add it to his
> patch.

Applied to mvebu/cleanup with a few minor typo corrections and I added
the hunk for mach-mvebu/.

thx,

Jason.


> > On Sun, Nov 11, 2012 at 06:31:19PM +0100, Andrew Lunn wrote:
> >> The patch:
> >>
> >> mm: dmapool: use provided gfp flags for all dma_alloc_coherent() calls
> >>
> >> makes these calls on Kirkword and Orion5x redundent. The drivers are
> >> not making atomic requests for coherent memory and hence the default
> >> pool size is now sufficient.
> >>
> >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >> ---
> >>  arch/arm/mach-kirkwood/common.c |    7 -------
> >>  arch/arm/mach-orion5x/common.c  |    7 -------
> >>  2 files changed, 14 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> >> index 2c6c218..8080ceb 100644
> >> --- a/arch/arm/mach-kirkwood/common.c
> >> +++ b/arch/arm/mach-kirkwood/common.c
> >> @@ -505,13 +505,6 @@ void __init kirkwood_wdt_init(void)
> >>  void __init kirkwood_init_early(void)
> >>  {
> >>  	orion_time_set_base(TIMER_VIRT_BASE);
> >> -
> >> -	/*
> >> -	 * Some Kirkwood devices allocate their coherent buffers from atomic
> >> -	 * context. Increase size of atomic coherent pool to make sure such
> >> -	 * the allocations won't fail.
> >> -	 */
> >> -	init_dma_coherent_pool_size(SZ_1M);
> >>  }
> >>  
> >>  int kirkwood_tclk;
> >> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> >> index b3eb3da..3e07f52 100644
> >> --- a/arch/arm/mach-orion5x/common.c
> >> +++ b/arch/arm/mach-orion5x/common.c
> >> @@ -194,13 +194,6 @@ void __init orion5x_wdt_init(void)
> >>  void __init orion5x_init_early(void)
> >>  {
> >>  	orion_time_set_base(TIMER_VIRT_BASE);
> >> -
> >> -	/*
> >> -	 * Some Orion5x devices allocate their coherent buffers from atomic
> >> -	 * context. Increase size of atomic coherent pool to make sure such
> >> -	 * the allocations won't fail.
> >> -	 */
> >> -	init_dma_coherent_pool_size(SZ_1M);
> >>  }
> >>  
> >>  int orion5x_tclk;
> >> -- 
> >> 1.7.10.4
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

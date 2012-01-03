From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 02 Jan 2012 22:34:15 -0500 (EST)
Subject: [PATCH 01/20] ARM: clean up idle handlers
In-Reply-To: <20111225014842.GB8240@S2100-06.ap.freescale.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-2-git-send-email-nico@fluxnic.net>
 <20111225014227.GA8240@S2100-06.ap.freescale.net>
 <20111225014842.GB8240@S2100-06.ap.freescale.net>
Message-ID: <alpine.LFD.2.02.1201022232370.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Dec 2011, Shawn Guo wrote:

> On Sun, Dec 25, 2011 at 09:42:28AM +0800, Shawn Guo wrote:
> > On Mon, Dec 19, 2011 at 04:47:30AM -0500, Nicolas Pitre wrote:
> > > Let's factor out the need_resched() check instead of having it duplicated
> > > in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
> > > was missing it already).
> > > 
> > > The forceful re-enablement of IRQs after pm_idle has returned can go.
> > > The warning certainly doesn't trigger for existing users.  Similar for
> > > the redundant local_irq_disable() call in the OMAP implementations.
> > > 
> > > To get rid of the pm_idle calling convention oddity, let's introduce
> > > arm_pm_idle() allowing for the local_irq_enable() to be factored out
> > > from SOC specific implementations. The default pm_idle function becomes
> > > a wrapper for arm_pm_idle and it takes care of enabling IRQs closer to
> > > where they are initially disabled.
> > > 
> > > And finally move the comment explaining the reason for that turning off
> > > of IRQs to a more proper location.
> > > 
> > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > ---
> > >  arch/arm/include/asm/system.h |    1 +
> > >  arch/arm/kernel/process.c     |   23 +++++++++++++++--------
> > >  arch/arm/mach-omap1/pm.c      |   19 ++++++-------------
> > >  arch/arm/mach-omap2/pm24xx.c  |    5 ++---
> > >  arch/arm/mach-omap2/pm34xx.c  |    7 +++----
> > >  arch/arm/mach-omap2/pm44xx.c  |    2 ++
> > >  arch/arm/mach-s5p64x0/cpu.c   |   16 +++++++---------
> > >  7 files changed, 36 insertions(+), 37 deletions(-)
> > > 
> > There is one more since v3.2-rc4, imx5_idle() in arch/arm/mach-mx5/mm.c
> > 
> And imx3_idle() in arch/arm/mach-imx/mm-imx3.c

OK.  Again, Ill see to them when I rebase.


Nicolas

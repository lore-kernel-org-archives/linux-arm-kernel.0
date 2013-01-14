From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Jan 2013 17:53:46 +0000
Subject: [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of
 a dying CPU is disabled
In-Reply-To: <alpine.LFD.2.02.1301121134390.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-9-git-send-email-nicolas.pitre@linaro.org>
 <50F054E7.9000004@ti.com>
 <alpine.LFD.2.02.1301111405590.6300@xanadu.home>
 <50F10799.3000501@ti.com>
 <alpine.LFD.2.02.1301121134390.6300@xanadu.home>
Message-ID: <20130114175345.GG21142@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 12, 2013 at 04:47:19PM +0000, Nicolas Pitre wrote:
> On Sat, 12 Jan 2013, Santosh Shilimkar wrote:
> 
> > On Saturday 12 January 2013 12:37 AM, Nicolas Pitre wrote:
> > > On Fri, 11 Jan 2013, Santosh Shilimkar wrote:
> > > 
> > > > On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> > > > > Otherwise there might be some interrupts or IPIs becoming pending and
> > > > > the
> > > > > CPU will not enter low power mode when doing a WFI.  The effect of this
> > > > > is a CPU that loops back into the kernel, go through the first man
> > > > > election, signals itself as alive,  and prevent the cluster from being
> > > > > shut down.
> > > > > 
> > > > > This could benefit from a better solution.
> > > > > 
> > > > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > > > ---
> > > > >    arch/arm/common/bL_platsmp.c        | 1 +
> > > > >    arch/arm/common/gic.c               | 6 ++++++
> > > > >    arch/arm/include/asm/hardware/gic.h | 2 ++
> > > > >    3 files changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
> > > > > index 0ae44123bf..6a3b251b97 100644
> > > > > --- a/arch/arm/common/bL_platsmp.c
> > > > > +++ b/arch/arm/common/bL_platsmp.c
> > > > > @@ -68,6 +68,7 @@ static void __ref bL_cpu_die(unsigned int cpu)
> > > > >    	pcpu = mpidr & 0xff;
> > > > >    	pcluster = (mpidr >> 8) & 0xff;
> > > > >    	bL_set_entry_vector(pcpu, pcluster, NULL);
> > > > > +	gic_cpu_if_down();
> > > > 
> > > > So for a case where CPU still don't power down for some reason even
> > > > after CPU interface is disabled, can not listen to and SGI or PPI.
> > > > Not sure if this happens on big.LITTLE but i have seen one such issue
> > > > on Cortex-A9 based SOC.
> > > 
> > > Here the problem was the reverse i.e. a CPU wouldn't go down because
> > > some pending SGIs prevented that.
> > > 
> > I understood that part. What I was saying is, with CPU IF disabled and
> > if CPU doesn't enter into the intended low power state and if the wakeup
> > mechanism on that CPU is SGI/SPI, CPU may never wakeup and can lead to
> > dead lock. I have seen this scenario on OMAP especially in CPUidle path.
> 
> Obviously, on the CPU idle path, you should not turn off the GIC 
> interface as this might lose the ability to wake the CPU up with a 
> pending interrupt, if your system is so configured.

That's platform specific. On TC2 turning GIC CPU IF off is pivotal otherwise
the CPU receiving an IRQ can complete wfi and be reset by firmware when
executing in the middle of nowhere, leading to a system lock-up.

Disabling the GIC CPU IF must not be added to the gic_cpu_save() code,
but we do need a helper function to disable the CPU IF for platforms
that need this to happen to function properly (eg TC2).

Lorenzo

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Jun 2013 14:41:08 +0100
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <alpine.LFD.2.03.1306101833450.18597@syhkavp.arg>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130607142645.GD3111@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1306080118440.18597@syhkavp.arg>
 <20130610175357.GD1310@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1306101833450.18597@syhkavp.arg>
Message-ID: <20130611134108.GB25664@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:39:11PM +0100, Nicolas Pitre wrote:
> On Mon, 10 Jun 2013, Lorenzo Pieralisi wrote:
> 
> > > +               /*
> > > +                * We need to disable and flush the whole (L1 and L2) cache.
> > > +                * Let's do it in the safest possible way i.e. with
> > > +                * no memory access within the following sequence,
> > > +                * including the stack.
> > > +                */
> > > +               asm volatile(
> > > +               "mrc    p15, 0, r0, c1, c0, 0   @ get CR \n\t"
> > > +               "bic    r0, r0, #"__stringify(CR_C)" \n\t"
> > > +               "mcr    p15, 0, r0, c1, c0, 0   @ set CR \n\t"
> > > +               "isb    \n\t"
> > > +               "bl     v7_flush_dcache_all \n\t"
> > > +               "clrex  \n\t"
> > > +               "mrc    p15, 0, r0, c1, c0, 1   @ get AUXCR \n\t"
> > > +               "bic    r0, r0, #(1 << 6)       @ disable local coherency \n\t"
> > > +               "mcr    p15, 0, r0, c1, c0, 1   @ set AUXCR \n\t"
> > > +               "isb    "
> > 
> > We need a dsb here, I know there is one before returning from the flush
> > routine though. Maybe add it as a comment please.
> 
> Is the dsb in v7_flush_dcache_all sufficient (hence a comment) or it 
> needs to be located after a particular operation?

Well I wanted to avoid too many dsb. But I think that a dsb after
exiting coherency is mandatory to avoid issues (after isb), hence it should
be added (I know as I said there is one just before returning from the

v7_flush_dcache_all/louis

functions), but we should not be playing with fire either, it boils down
to CPU microarchitectural details.

We cannot remove the dsb from the cache functions since they are meant
to be self-contained.

Lorenzo

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 10 Jun 2013 18:39:11 -0400 (EDT)
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <20130610175357.GD1310@e102568-lin.cambridge.arm.com>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130607142645.GD3111@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1306080118440.18597@syhkavp.arg>
 <20130610175357.GD1310@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306101833450.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Lorenzo Pieralisi wrote:

> > +               /*
> > +                * We need to disable and flush the whole (L1 and L2) cache.
> > +                * Let's do it in the safest possible way i.e. with
> > +                * no memory access within the following sequence,
> > +                * including the stack.
> > +                */
> > +               asm volatile(
> > +               "mrc    p15, 0, r0, c1, c0, 0   @ get CR \n\t"
> > +               "bic    r0, r0, #"__stringify(CR_C)" \n\t"
> > +               "mcr    p15, 0, r0, c1, c0, 0   @ set CR \n\t"
> > +               "isb    \n\t"
> > +               "bl     v7_flush_dcache_all \n\t"
> > +               "clrex  \n\t"
> > +               "mrc    p15, 0, r0, c1, c0, 1   @ get AUXCR \n\t"
> > +               "bic    r0, r0, #(1 << 6)       @ disable local coherency \n\t"
> > +               "mcr    p15, 0, r0, c1, c0, 1   @ set AUXCR \n\t"
> > +               "isb    "
> 
> We need a dsb here, I know there is one before returning from the flush
> routine though. Maybe add it as a comment please.

Is the dsb in v7_flush_dcache_all sufficient (hence a comment) or it 
needs to be located after a particular operation?

> Other than that, FWIW:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks!


Nicolas

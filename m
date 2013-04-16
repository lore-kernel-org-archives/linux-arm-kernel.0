From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Apr 2013 23:11:32 +0800
Subject: [PATCH 1/2] ARM: add diagnostic register access helpers
In-Reply-To: <20130416144853.GB3770@mudshark.cambridge.arm.com>
References: <1366122643-1961-1-git-send-email-shawn.guo@linaro.org>
 <20130416144853.GB3770@mudshark.cambridge.arm.com>
Message-ID: <20130416151130.GE11245@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 03:48:53PM +0100, Will Deacon wrote:
> > +static inline unsigned int get_diag_reg(void)
> > +{
> > +	unsigned int val;
> > +	asm("mrc p15, 0, %0, c15, c0, 1" : "=r" (val) : : "cc");
> > +	return val;
> > +}
> > +
> > +static inline void set_diag_reg(unsigned int val)
> > +{
> > +	asm volatile("mcr p15, 0, %0, c15, c0, 1" : : "r" (val) : "cc");
> > +	isb();
> > +}
> > +
> 
> You don't want to poke this register with the MMU on, so I don't think this
> patch is a very good idea.

If you are worrying about that the helpers could be abused by people, I
can certainly make them local in arch/arm/mach-imx/platsmp.c.  But I do
not understand why diagnostic register shouldn't be accessed when MMU is
on.  I'm doing that in patch #2 to get my problem fixed, and not seeing
anything broken there.

Shawn

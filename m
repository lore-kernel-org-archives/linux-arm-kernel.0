From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Nov 2012 13:55:10 +0000
Subject: [PATCH] ARM: cti: fix manipulation of debug lock registers
In-Reply-To: <50AA78AE.5050609@ti.com>
References: <1353015653-23711-1-git-send-email-will.deacon@arm.com>
 <50AA78AE.5050609@ti.com>
Message-ID: <20121120135510.GA26475@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 06:21:34PM +0000, Jon Hunter wrote:
> On 11/15/2012 03:40 PM, Will Deacon wrote:
> > diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
> > index a0ada3e..f2e5cad 100644
> > --- a/arch/arm/include/asm/cti.h
> > +++ b/arch/arm/include/asm/cti.h
> > @@ -146,15 +146,7 @@ static inline void cti_irq_ack(struct cti *cti)
> >   */
> >  static inline void cti_unlock(struct cti *cti)
> >  {
> > -	void __iomem *base = cti->base;
> > -	unsigned long val;
> > -
> > -	val = __raw_readl(base + LOCKSTATUS);
> > -
> > -	if (val & 1) {
> > -		val = LOCKCODE;
> > -		__raw_writel(val, base + LOCKACCESS);
> > -	}
> > +	__raw_writel(LOCKCODE, cti->base + LOCKACCESS);
> >  }
> >  
> >  /**
> > @@ -166,14 +158,6 @@ static inline void cti_unlock(struct cti *cti)
> >   */
> >  static inline void cti_lock(struct cti *cti)
> >  {
> > -	void __iomem *base = cti->base;
> > -	unsigned long val;
> > -
> > -	val = __raw_readl(base + LOCKSTATUS);
> > -
> > -	if (!(val & 1)) {
> > -		val = ~LOCKCODE;
> > -		__raw_writel(val, base + LOCKACCESS);
> > -	}
> > +	__raw_writel(~LOCKCODE, cti->base + LOCKACCESS);
> >  }
> >  #endif
> 
> I gave this a whirl on omap4430 and PMU is working fine with this, so ...
> 
> Tested-by: Jon Hunter <jon-hunter@ti.com>

Cheers Jon,

Will

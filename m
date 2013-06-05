From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 5 Jun 2013 10:18:50 -0400 (EDT)
Subject: [RFC PATCH 2/2] ARM: kernel: implement stack pointer save array
 through MPIDR hashing
In-Reply-To: <20130604175509.GA21719@e102568-lin.cambridge.arm.com>
References: <1370338453-8749-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370338453-8749-3-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1306041235290.1200@syhkavp.arg>
 <20130604175509.GA21719@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306051016340.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013, Lorenzo Pieralisi wrote:

> On Tue, Jun 04, 2013 at 06:30:30PM +0100, Nicolas Pitre wrote:
> > On Tue, 4 Jun 2013, Lorenzo Pieralisi wrote:
> > 
> > > index 987dcf3..da1b65f 100644
> > > --- a/arch/arm/kernel/sleep.S
> > > +++ b/arch/arm/kernel/sleep.S
> > > @@ -7,6 +7,48 @@
> > >  	.text
> > >  
> > >  /*
> > > + * Implementation of MPIDR hash algorithm through shifting
> > > + * and OR'ing.
> > > + *
> > > + * @dst: register containing hash result
> > > + * @rtemp0: scratch register 0
> > > + * @rtemp1: scratch register 1
> > > + * @rtemp2: scratch register 2
> > > + * @rs0: register containing affinity level 0 bit shift
> > > + * @rs1: register containing affinity level 1 bit shift
> > > + * @rs2: register containing affinity level 2 bit shift
> > > + * @mpidr: register containing MPIDR value
> > > + * @mask: register containing MPIDR mask
> > > + *
> > > + * Pseudo C-code:
> > > + *
> > > + *u32 dst;
> > > + *
> > > + *compute_mpidr_hash(u32 rs0, u32 rs1, u32 rs2, u32 mpidr, u32 mask) {
> > > + *	u32 rtemp0, rtemp1, rtemp2;
> > > + *	u32 mpidr_masked = mpidr & mask;
> > > + *	rtemp0 = mpidr_masked & 0xff;
> > > + *	rtemp1 = mpidr_masked & 0xff00;
> > > + *	rtemp2 = mpidr_masked & 0xff0000;
> > > + *	dst = (rtemp0 >> rs0 | rtemp1 >> rs1 | rtemp2 >> rs2);
> > > + *}
> > > + */
> > > +.macro compute_mpidr_hash dst, rtemp0, rtemp1, rtemp2, rs0, rs1, 
> > rs2, mpidr, mask
> > > +	and	\mpidr, \mpidr, \mask		@ mask out unused MPIDR bits
> > > +	and	\rtemp0, \mpidr, #0xff		@ extracts aff0
> > > +	and	\rtemp1, \mpidr, #0xff00	@ extracts aff1
> > > +	and	\rtemp2, \mpidr, #0xff0000	@ extracts aff2
> > > +  ARM(	mov	\dst, \rtemp0, lsr \rs0)	@ dst=aff0>>rs0
> > > +  ARM(	orr	\dst, \dst, \rtemp1, lsr \rs1)	@ dst|=(aff1>>rs1)
> > > +  ARM(	orr	\dst, \dst, \rtemp2, lsr \rs2)		@ dst|=(aff2>>rs2)
> > > +THUMB(	mov	\rtemp0, \rtemp0, lsr \rs0)		@ aff0>>=rs0
> > > +THUMB(	mov	\rtemp1, \rtemp1, lsr \rs1)		@ aff1>>=rs1
> > > +THUMB(	mov	\rtemp2, \rtemp2, lsr \rs2)		@ aff2>>=rs2
> > > +THUMB(	orr	\dst, \rtemp0, \rtemp1)			@ dst = aff0 | aff1
> > > +THUMB(	orr	\dst, \dst, \rtemp2)			@ dts |= aff2
> > > +.endm
> > 
> > This would be much nicer by useing fewer registers.  I'd suggest this 
> > instead of guessing which registers can be duplicated in the 
> > macro invokation:
> > 
> > .macro compute_mpidr_hash dst, rs0, rs1, rs2, mpidr, mask
> > 	and	\mpidr, \mpidr, \mask		@ mask out unused MPIDR bits
> > 	and	\dst, \mpidr, #0xff		@ extracts aff0
> >    ARM(	mov	\dst, \dst, lsr \rs0 )	@ dst = aff0 >> rs0
> >  THUMB(	lsr	\dst, \rs0 )
> > 	and	\mask, \mpidr, #0xff00	@ extracts aff1
> >    ARM(	orr	\dst, \dst, \mask, lsr \rs1 )	@ dst |= (aff1 >> rs1)
> >  THUMB(	lsr	\mask, \rs1 )
> >  THUMB(	orr	\dst, \mask )
> > 	and	\mask, \mpidr, #0xff0000	@ extracts aff2
> >    ARM(	orr	\dst, \dst, \mask, lsr \rs2 )	@ dst |= (aff2 >> rs1)
> >  THUMB(	lsr	\mask, \rs2 )
> >  THUMB(	orr	\dst, \mask )
> > .endm
> 
> It _is_ nicer and probably faster in the cpu_resume path. Consider it applied.

Good.  In that case ...

Reviewed-by: Nicolas Pitre <nico@linaro.org>

Could you please ask RMK if he's fine with merging those patches into 
his devel-stable branch soon?  This way I'll be able to post the IKS 
patches against it.


Nicolas

From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 8 Oct 2013 19:03:11 +0100
Subject: [PATCH 2/2] ARM: cci: driver need big endian fixes in asm code
In-Reply-To: <alpine.LFD.2.03.1310081356280.3023@syhkavp.arg>
References: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
 <1381207040-1623-3-git-send-email-victor.kamensky@linaro.org>
 <20131008175136.GA3866@localhost.localdomain>
 <alpine.LFD.2.03.1310081356280.3023@syhkavp.arg>
Message-ID: <20131008180305.GA3919@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 01:57:48PM -0400, Nicolas Pitre wrote:
> On Tue, 8 Oct 2013, Dave Martin wrote:
> 
> > On Mon, Oct 07, 2013 at 09:37:20PM -0700, Victor Kamensky wrote:
> > > cci_enable_port_for_self written in asm and it works with h/w
> > > registers that are in little endian format. When run in big
> > > endian mode it needs byte swap before/after it writes/reads
> > > to/from such registers
> > 
> > Lorenzo should comment on this if he's not already seen it.
> > 
> > > 
> > > Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> > > ---
> > >  drivers/bus/arm-cci.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > > index 2009266..6db173e 100644
> > > --- a/drivers/bus/arm-cci.c
> > > +++ b/drivers/bus/arm-cci.c
> > > @@ -281,6 +281,9 @@ asmlinkage void __naked cci_enable_port_for_self(void)
> > >  	/* Enable the CCI port */
> > >  "	ldr	r0, [r0, %[offsetof_port_phys]] \n"
> > >  "	mov	r3, #"__stringify(CCI_ENABLE_REQ)" \n"
> > > +#ifdef __ARMEB__
> > > +"	rev	r3, r3 \n"
> > > +#endif /* __ARMEB__ */
> > 
> > Hmmm, this is a bit ugly, but we can't easily use ARM_BE8() here.
> 
> In any case, it would be more efficient to swap the CCI_ENABLE_REQ 
> constant at compile time rather than doing it at run time with an extra 
> instruction.

Indeed, but we can't stringify that.

A different way of wedging it into the assembler would be needed...
We might need to use ldr= too, which doesn't pay nice with inline asm.

Cheers
---Dave

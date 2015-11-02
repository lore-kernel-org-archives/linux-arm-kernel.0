From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Nov 2015 14:03:13 +0000
Subject: [PATCH v6 1/6] arm/arm64: add smccc
In-Reply-To: <20151102135633.GA17559@ermac>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
 <1446106888-8983-2-git-send-email-jens.wiklander@linaro.org>
 <20151102115119.GB29657@arm.com> <20151102135633.GA17559@ermac>
Message-ID: <20151102140313.GG2684@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +/*
> > > + * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
> > > + *		  unsigned long a3, unsigned long a4, unsigned long a5,
> > > + *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
> > > + */
> > > +ENTRY(smccc_smc)
> > > +	smc	#0
> > > +	ldr	x4, [sp]
> > > +	stp	x0, x1, [x4, #SMC_RES_X0_OFFS]
> > > +	stp	x2, x3, [x4, #SMC_RES_X2_OFFS]
> > > +	ret
> > > +ENDPROC(smccc_smc)

> > > +/*
> > > + * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
> > > + *		  unsigned long a3, unsigned long a4, unsigned long a5,
> > > + *		  unsigned long a6, unsigned long a7, struct smccc_res *res)
> > > + */
> > > +ENTRY(smccc_hvc)
> > > +	hvc	#0
> > > +	ldr	x4, [sp]
> > > +	stp	x0, x1, [x4, #SMC_RES_X0_OFFS]
> > > +	stp	x2, x3, [x4, #SMC_RES_X2_OFFS]
> > > +	ret
> > > +ENDPROC(smccc_hvc)

> > > +/**
> > > + * struct smccc_res - Result from SMC/HVC call
> > > + * @a0-a3 result values from registers 0 to 3
> > > + */
> > > +struct smccc_res {
> > > +	unsigned long a0;
> > > +	unsigned long a1;
> > > +	unsigned long a2;
> > > +	unsigned long a3;
> > > +};
> > 
> > Are there any endianness considerations for this structure?
> 
> No, I can't find anything in the ARM SMC Calling Convention document
> indicating that.

The calling conventions have no bearing on the structure, which is our
invention.

We stash register values (which don't have endianness) returned by the
firmeware into the structure in the sequences above (which appear
endian-clean to me).

Thanks,
Mark.

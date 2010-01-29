From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 29 Jan 2010 10:38:06 +0530
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
In-Reply-To: <1264683782.7064.54.camel@pc1117.cambridge.arm.com>
References: <4B606D92.9020005@googlemail.com>
	<1264683782.7064.54.camel@pc1117.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C09C6448@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> Sent: Thursday, January 28, 2010 6:33 PM
> To: Dirk Behme
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
> 
> On Wed, 2010-01-27 at 16:45 +0000, Dirk Behme wrote:
> > On a 400MHz ARM11 MPCore system (NEC NaviEngine based) with kernel
> > 2.6.32 we found that BogoMIPS/loops per jiffies ~doubles (see below
> > [1]) by adding a nop to __delay():
> >
> > --- a/arch/arm/lib/delay.S
> > +++ b/arch/arm/lib/delay.S
> > @@ -41,6 +41,9 @@ ENTRY(__const_udelay)    @ 0 <= r0 <= 0x
> >   @ Delay routine
> >   ENTRY(__delay)
> > +#if defined(CONFIG_CPU_V6) && defined(CONFIG_SMP)
> > +        nop
> > +#endif
> >           subs    r0, r0, #1
> >   #if 0
> >           movls    pc, lr
> >
> > Any ideas what might happen here?
> 
> Branch (mis-)prediction? Alignment?
> 
> It doesn't really matter, bogomips should not be used as some form of
> performance checking.
> 
> BTW, local timers give a more accurate estimate of the CPU frequency
> (they are counting at half this frequency).

Last time I was experimenting with this, the data I got from for A9 was " the
loop prediction" makes this faster on the hw support fast loop mode .
It is a feature of the C-A9 pipeline that enables it to spot short loops like 
"BHI      {pc}-4 ; 0x100  **" nd just issue store them in the pipiline queue
to be dispatched from there rather than being fetched from the Icache all 
the time.

Regards,
Santosh

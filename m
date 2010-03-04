From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Mar 2010 18:28:43 -0000
Subject: [kGDB]Cannot compile KGDB on ARM SMP
In-Reply-To: <1267724191.6526.501.camel@e102109-lin.cambridge.arm.com>
References: <8cad0aa1003020107g3aae0875n1da8c442d9909f96@mail.gmail.com>	
	<4B8EF272.1090007@windriver.com>	
	<001e01cabbc0$109a67f0$31cf37d0$@deacon@arm.com>
	<1267724191.6526.501.camel@e102109-lin.cambridge.arm.com>
Message-ID: <001f01cabbc8$85680300$90380900$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

> On Thu, 2010-03-04 at 17:28 +0000, Will Deacon wrote:
> > I took a quick look at the code in kernel/kgdb.c and adding the following
> > memory barrier appears to resolve the issue:
> >
> > diff --git a/kernel/kgdb.c b/kernel/kgdb.c
> > index 761fdd2..1308381 100644
> > --- a/kernel/kgdb.c
> > +++ b/kernel/kgdb.c
> > @@ -1537,6 +1537,7 @@ acquirelock:
> >                  * Wait till all the CPUs have quit
> >                  * from the debugger.
> >                  */
> > +               smp_wmb();
> >                 for_each_online_cpu(i) {
> >                         while (atomic_read(&cpu_in_kgdb[i]))
> >                                 cpu_relax();
> 
> Shouldn't this be smp_rmb()?

Actually, I think that we need an smp_mb() because there is
another variable involved (passive_cpu_wait[i]) as well as
cpu_in_kgdb[i], both of which are being read from and written
to.

I think deadlock occurs because the store buffers don't drain
on the 11MPCore, so the CPUs happily cpu_relax() while polling
on variables that they will never see change. Perhaps cpu_relax()
should be defined to be something stronger than a compiler memory
barrier for ARM?

Will

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 14:57:55 +0100
Subject: imx6q restart is broken
In-Reply-To: <20120809122220.GB19617@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
 <20120809120144.GA19617@S2101-09.ap.freescale.net>
 <20120809122220.GB19617@S2101-09.ap.freescale.net>
Message-ID: <20120809135755.GR18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 08:22:22PM +0800, Shawn Guo wrote:
> On Thu, Aug 09, 2012 at 08:01:47PM +0800, Shawn Guo wrote:
> > diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> > index 99afa74..1282b61 100644
> > --- a/arch/arm/include/asm/processor.h
> > +++ b/arch/arm/include/asm/processor.h
> > @@ -80,11 +80,18 @@ extern void release_thread(struct task_struct *);
> >  unsigned long get_wchan(struct task_struct *p);
> > 
> >  #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
> > -#define cpu_relax()                    smp_mb()
> > +#define __cpu_relax()                  smp_mb()
> >  #else
> > -#define cpu_relax()                    barrier()
> > +#define __cpu_relax()                  barrier()
> >  #endif
> > 
> > +#define cpu_relax()                                                    \
> > +({                                                                     \
> > +       static int i;                                                   \
> > +       if (i++ % 100)                                                  \
> 
> This should be 
> 
> 	if (i++ % 100 == 0)
> 
> But either way it fixes the problem.

Right, so it does sound like issuing dmb instructions in a tight loop
can bring a system to its knees.

While we can address it in the above way in the kernel, it points to
a much bigger problem - userspace can issue dmb instructions itself,
which means any user program can effectively take a system down.  Can
you confirm this by building and running the following program:

int main()
{
	while (1)
		asm("dmb");
}

Then try running some other programs.  If I'm correct, this should
result in the system becoming rather unresponsive.

Thanks.

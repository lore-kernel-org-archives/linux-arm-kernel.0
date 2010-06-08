From: anfei.zhou@gmail.com (anfei)
Date: Tue, 8 Jun 2010 21:29:40 +0800
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <20100421131149.GB9408@desktop>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100421131149.GB9408@desktop>
Message-ID: <20100608132940.GA6874@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Apr 21, 2010 at 09:11:49PM +0800, anfei wrote:
> On Tue, Apr 20, 2010 at 08:28:14PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 20, 2010 at 06:09:44PM +0100, Ben Dooks wrote:
> > > On Tue, Apr 20, 2010 at 10:20:47PM +0800, anfei wrote:
> > > > On Tue, Apr 20, 2010 at 11:27:40AM +0100, Dave P. Martin wrote:
> > > > >  
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: linux-arm-kernel-bounces at lists.infradead.org 
> > > > > > [mailto:linux-arm-kernel-bounces at lists.infradead.org] On 
> > > > > > Behalf Of Ben Dooks
> > > > > > Sent: 20 April 2010 10:35
> > > > > > To: Sasha Sirotkin
> > > > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > > > Subject: Re: kernel virtual memory access (from app) does not 
> > > > > 
> > > > > [..]
> > > > > 
> > > > > > > For instance, this code generates a segfault allright
> > > > > > >
> > > > > > > int * aa;
> > > > > > > aa = 0xc0000000;
> > > > > > > *aa=42;
> > > > > > >
> > > > > > > However this code does not, instead the process simply 
> > > > > > hangs (and can 
> > > > > > > be
> > > > > > > killed)
> > > > > > >
> > > > > > > void (*func)(void);
> > > > > > > func = 0xc0000000;
> > > > > > > func();
> > > > > > 
> > > > > > Your first example writes to an area, your second is 
> > > > > > execution. IIRC, this version of the ARM architecture equates 
> > > > > > read and execute permission and so you may actually have 
> > > > > > permission to read this area and thus execute code in it.
> > 
> > User programs do not have permission to read kernel addresses.  Trying to
> > do so _should_ generate a permission fault.
> > 
> > > > > I tried reading that address (albeit on an old 2.6.28 kernel), and I get a
> > > > > segfault.
> > 
> > ... which is correct behaviour.
> > 
> > > > > Trying to execute in kernel space is the only thing that appears to hang.
> > > > > Attaching to the process in gdb, I observed that pc is always 0xc0000000
> > > > > when the process is stopped.
> > > > > 
> > > > > top accounts most of the CPU time as being consumed in the kernel.
> > > > > 
> > > > > I think what is going on here is that the kernel is catching the expected
> > > > > prefetch abort, but the handler fails to send SIGSEGV to the user process
> > > > > --- the process is resumed with the same pc and we end up in an endless
> > > > > spin.
> > 
> > Yes, that'd make sense.
> > 
> > > > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > > > index 9d40c34..cd4d15c 100644
> > > > --- a/arch/arm/mm/fault.c
> > > > +++ b/arch/arm/mm/fault.c
> > > > @@ -393,6 +393,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
> > > >  	if (addr < TASK_SIZE)
> > > >  		return do_page_fault(addr, fsr, regs);
> > > >  
> > > > +	if (user_mode(regs) && addr >= TASK_SIZE)
> > > > +		goto bad_area;
> > > > +
> > > 
> > > technically, addr >= TASK_SIZE was guaranteed by the previous test
> > > on addr. The user_mode(regs) may well be a good idea, although I'm
> > > not sure if we get entered here if the kernel is attempting to access
> > > user-mode memory by forcing unpriveldged accesses.
> > > 
> > > probably best to get Russell's opinion.
> > 
> > 	if (user_mode(regs))
> > 		goto bad_area;
> > 
> > should be sufficient, since userspace should not be accessing anything
> > above TASK_SIZE, except for the exception page, which will always be
> > mapped.
> 
> Patch updated, and with comment log.
> 
> ===
> ARM: Proper prefetch abort handling on pre-ARMv6
> 
> Instruction faults on pre-ARMv6 CPUs are interpreted as
> a 'translation fault', but do_translation_fault doesn't
> handle well if user mode trying to run instruction above
> TASK_SIZE, and result in the infinite retry of that
> instruction.
> 
> Signed-off-by: Anfei Zhou <anfei.zhou@gmail.com>
> ---
>  arch/arm/mm/fault.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 9d40c34..8ad75e9 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -393,6 +393,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
>  	if (addr < TASK_SIZE)
>  		return do_page_fault(addr, fsr, regs);
>  
> +	if (user_mode(regs))
> +		goto bad_area;
> +
>  	index = pgd_index(addr);
>  
>  	/*

This patch is still not into the mainline, will you plan to apply it?

Thanks,
Anfei.

> -- 
> 1.6.4.rc1
> 

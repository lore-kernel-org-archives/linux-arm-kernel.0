From: anfei.zhou@gmail.com (anfei)
Date: Tue, 20 Apr 2010 22:20:47 +0800
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <000001cae074$1b564ff0$4044010a@Emea.Arm.com>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
Message-ID: <20100420142047.GA7398@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 11:27:40AM +0100, Dave P. Martin wrote:
>  
> 
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org 
> > [mailto:linux-arm-kernel-bounces at lists.infradead.org] On 
> > Behalf Of Ben Dooks
> > Sent: 20 April 2010 10:35
> > To: Sasha Sirotkin
> > Cc: linux-arm-kernel at lists.infradead.org
> > Subject: Re: kernel virtual memory access (from app) does not 
> 
> [..]
> 
> > > For instance, this code generates a segfault allright
> > >
> > > int * aa;
> > > aa = 0xc0000000;
> > > *aa=42;
> > >
> > > However this code does not, instead the process simply 
> > hangs (and can 
> > > be
> > > killed)
> > >
> > > void (*func)(void);
> > > func = 0xc0000000;
> > > func();
> > 
> > Your first example writes to an area, your second is 
> > execution. IIRC, this version of the ARM architecture equates 
> > read and execute permission and so you may actually have 
> > permission to read this area and thus execute code in it.
> > 
> > > I stumbled across this by accident. Just curious to 
> > understand why it 
> > > happens. Isn't it a bug ?
> > 
> > Don't think so, other than you might not want that area to be 
> > readable by user space?
> 
> I tried reading that address (albeit on an old 2.6.28 kernel), and I get a
> segfault.
> 
> Trying to execute in kernel space is the only thing that appears to hang.
> Attaching to the process in gdb, I observed that pc is always 0xc0000000
> when the process is stopped.
> 
> top accounts most of the CPU time as being consumed in the kernel.
> 
> I think what is going on here is that the kernel is catching the expected
> prefetch abort, but the handler fails to send SIGSEGV to the user process
> --- the process is resumed with the same pc and we end up in an endless
> spin.
> 
> This only appears to apply to certain address ranges: substituting some
> other random unmapped address for 0xc0000000 (0x48000000 worked for me), we
> get the expected segfault.
> 
> Does the prefetch abort handler assume that lr >= 0xc0000000 implies the
> fault came from inside the kernel?  Should it?
> 
> arch/arm/mm/fault.c has:
> 
> /* 
> ...
>  * If the address is in kernel space (>= TASK_SIZE), then we are
>  * probably faulting in the vmalloc() area.
> ...
> */
> static int __kprobes
> do_translation_fault(unsigned long addr, unsigned int fsr,
>                      struct pt_regs *regs)
> {
> ...
>         if (addr < TASK_SIZE)
>                 return do_page_fault(addr, fsr, regs);
> 
> So the common case for userspace prefetch aborts is do_page_fault()
> 
> This suggests that the weirdness is caused by something in the remainder of
> do_translation_fault(), or something it calls.
> 
> 
> The comment preceding do_translation_fault() suggests a possible unsafe
> assumption which could lead to a security hole... but it really depends on
> what the handler code is trying to do.  Unfortunately, my understanding has
> broken down by this point.
> 
> Is someone else able to comment on how this code responds to a user fault >=
> TASK_SIZE?
> 
I think something like this is needed:

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 9d40c34..cd4d15c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -393,6 +393,9 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
 
+	if (user_mode(regs) && addr >= TASK_SIZE)
+		goto bad_area;
+
 	index = pgd_index(addr);
 
 	/*

Cheers,
Anfei.

> Cheers
> ---Dave
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

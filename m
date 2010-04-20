From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 20 Apr 2010 23:31:06 +0100
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <20100420192813.GA29831@n2100.arm.linux.org.uk>
References: <4BCD7076.9030802@browserseal.com>
	<20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
Message-ID: <20100420223106.GQ11723@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Apr 20, 2010 at 06:09:44PM +0100, Ben Dooks wrote:
> > On Tue, Apr 20, 2010 at 10:20:47PM +0800, anfei wrote:
> > > On Tue, Apr 20, 2010 at 11:27:40AM +0100, Dave P. Martin wrote:
> > > > > From: linux-arm-kernel-bounces at lists.infradead.org 
> > > > > [mailto:linux-arm-kernel-bounces at lists.infradead.org] On 
> > > > > Behalf Of Ben Dooks
> > > > > Your first example writes to an area, your second is 
> > > > > execution. IIRC, this version of the ARM architecture equates 
> > > > > read and execute permission and so you may actually have 
> > > > > permission to read this area and thus execute code in it.
> 
> User programs do not have permission to read kernel addresses.  Trying to
> do so _should_ generate a permission fault.
>
> > probably best to get Russell's opinion.
> 
> 	if (user_mode(regs))
> 		goto bad_area;
> 
> should be sufficient, since userspace should not be accessing anything
> above TASK_SIZE, except for the exception page, which will always be
> mapped.

Those two lines look good to me, or alternatively change

        if (addr < TASK_SIZE)
to 
        if (addr < TASK_SIZE || user_mode(regs))

which lead to the same SIGSEGV by a more complicated route.  That will
continue to work if user-accessible pages are ever mapped using the
vmalloc lazy method.  Currently not, and I'm sure if that's ever done
it will be noticed quickly :-)

But a possible NAK: What happens when the kernel does get/put_user()
on an address > TASK_SIZE with kernel-only mapping?  user_mode()
returns 0, so the LDRT will loop in the kernel, won't it?

Reviewed-by: Jamie Lokier <jamie@shareable.org>

-- Jamie

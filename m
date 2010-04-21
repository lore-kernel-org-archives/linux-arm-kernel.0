From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 21 Apr 2010 20:16:00 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <000101cae16c$b2d08cd0$4044010a@Emea.Arm.com>
References: <20100420093441.GD6684@trinity.fluff.org>
	<000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421124317.GA9408@desktop>
	<000101cae16c$b2d08cd0$4044010a@Emea.Arm.com>
Message-ID: <20100421191600.GO27575@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave P. Martin wrote:
>  
> 
> > -----Original Message-----
> > From: anfei [mailto:anfei.zhou at gmail.com] 
> > Sent: 21 April 2010 13:43
> > To: Dave P Martin
> > Cc: 'Russell King - ARM Linux'; Jamie Lokier; Ben Dooks; 
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: kernel virtual memory access (from app) does not 
> > generatesegfault
> 
> [...]
> 
> > > > The difference between instruction faults and data faults 
> > is that we 
> > > > always interpret instruction faults on pre-ARMv6 CPUs as a 
> > > > 'translation fault' rather than a permission fault since 
> > they can't 
> > > > tell us what the problem was.
> > > 
> > > Note that my observations were on an armv7 kernel.  Should we still 
> > > hit the same bit of code in this case, or have I 
> > misdiagnosed the problem?
> > > 
> > You said your kernel is .28, so it seems too old and this 
> > commit may fix
> > it: 
> > commit d25ef8b86e6a58f5476bf6e4a8da730b335f68fa
> > 	ARM: 5728/1: Proper prefetch abort handling on ARMv6 and ARMv7
> > 
> 
> Just to clarify, this problem was not specific to 2.6.28.  I also see the
> same issue on the 2.6.31 Ubuntu lucid kernel.
> 
> So I guess I did misdiagnose the problem, though the affected code did look
> worth tweaking anyway--- the suggested fixes looked sensible to me.
> 
> I see this patch didn't hit mainline before 2.6.32; I'll suggest to the
> Ubuntu folks that they merge this, but I guess it's not critical for them
> --- I don't think they've seen any real-life instances of this problem yet.

The two-liner proposed earlier should fix all ARMs doing userspace
execution > TASK_SIZE - the problem which started this thread.  But
not kernel space accidentally executing an NX page > TASK_SIZE due to
some bug, which can only occur on ARMv6/v7 due to NX.

The above patch addresses ARMv6/v7 with NX mappings - and probably
only those > TASK_SIZE; NX mappings < TASK_SIZE should have been
caught by the PROT_EXEC check already in fault.c.

If I'm right, the NX one is more serious if you can trip a kernel bug
into doing this, because it'll result in an unkillable process, stuck
in kernel mode and spinning.  But only if you trip a kernel bug.

So both patches look useful.

-- Jamie

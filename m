From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 18:47:36 +0100
Subject: v6 software reset fails on 1176
In-Reply-To: <20110823173410.GA2263@gallagher>
References: <20110823163247.GM2796@pulham.picochip.com>
	<20110823170955.GF10062@e102144-lin.cambridge.arm.com>
	<20110823173410.GA2263@gallagher>
Message-ID: <20110823174736.GG10062@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 06:34:10PM +0100, Jamie Iles wrote:
> On Tue, Aug 23, 2011 at 06:09:55PM +0100, Will Deacon wrote:
> > Ok. How are you calling cpu_v6_reset? If you call it via arch_reset from
> > arm_machine_restart then there should be an identity mapping in place, so
> > you need to ensure that the reset code is called via this mapping in your
> > implementation of arch_reset.
> 
> Yes, this is being called from the arch_reset hook.

Good, good.

> > Unfortunately, the current flat mapping only covers userspace, so it relies
> > on the physical address of the reset code not aliasing with the kernel virtual
> > addresses.
> 
> The reset code is in our bootrom (at physical address 0xffff0000).

Sorry, I was referring to cpu_reset rather than the code that it then jumps
to (which can be anywhere).

> > With modern CPUs, you can't rely on characteristics of the pipeline to play
> > tricks like this. Instead, you need to ensure that the reset code is
> > executed with a 1:1 mapping.
> 
> Hmm, I don't really understand this - the cpu_v6_reset code turns off 
> the MMU, then issues an ISB.  So for as long as cpu_v6_reset is 
> executing in the kernel virtual address space I don't see how it can 
> ever fetch the "mov pc, r0" instruction after the ISB without those 
> instructions living in the 1:1 mapping?

You need to make sure you call cpu_reset by jumping to its *physical*
address. If that happens to alias with the virtual address of the kernel, it
won't currently work but I have a solution to this in my kexec branch.

You can do something like:

	typedef void (*phys_reset_t)(unsigned long);

	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
	phys_reset(0xffff0000);

The problem with not having an ISB is that you can't guarantee at which point
the MMU is no longer active, so you're really walking on a tightrope in
that case.

Will

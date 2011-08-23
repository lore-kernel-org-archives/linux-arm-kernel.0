From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Aug 2011 18:34:10 +0100
Subject: v6 software reset fails on 1176
In-Reply-To: <20110823170955.GF10062@e102144-lin.cambridge.arm.com>
References: <20110823163247.GM2796@pulham.picochip.com>
	<20110823170955.GF10062@e102144-lin.cambridge.arm.com>
Message-ID: <20110823173410.GA2263@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 06:09:55PM +0100, Will Deacon wrote:
> On Tue, Aug 23, 2011 at 05:32:47PM +0100, Jamie Iles wrote:
> > Hi Will,
> 
> Hi Jamie,
> 
> > I'm trying to use the cpu_v6_reset that you added in "ARM: proc: add 
> > definition of cpu_reset for ARMv6 and ARMv7 cores", but I've found that 
> > on my 1176 platform, it never gets to the branch to the reset vector.  
> 
> Ok. How are you calling cpu_v6_reset? If you call it via arch_reset from
> arm_machine_restart then there should be an identity mapping in place, so
> you need to ensure that the reset code is called via this mapping in your
> implementation of arch_reset.

Yes, this is being called from the arch_reset hook.

> Unfortunately, the current flat mapping only covers userspace, so it relies
> on the physical address of the reset code not aliasing with the kernel virtual
> addresses.

The reset code is in our bootrom (at physical address 0xffff0000).

> I have some (experimental) patches to fix this in my kexec branch:
> 
> http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/kexec-mmu-off
> 
> > Removing the ISB allows the branch instruction to be in the pipeline by 
> > the time the MMU is disabled, but I'm not sure if this is the correct 
> > fix.  Having said that, I don't see how this can work with an ISB in 
> > there.
> 
> With modern CPUs, you can't rely on characteristics of the pipeline to play
> tricks like this. Instead, you need to ensure that the reset code is
> executed with a 1:1 mapping.

Hmm, I don't really understand this - the cpu_v6_reset code turns off 
the MMU, then issues an ISB.  So for as long as cpu_v6_reset is 
executing in the kernel virtual address space I don't see how it can 
ever fetch the "mov pc, r0" instruction after the ISB without those 
instructions living in the 1:1 mapping?

Jamie

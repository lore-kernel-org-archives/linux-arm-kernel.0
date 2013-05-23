From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 23 May 2013 11:23:25 -0400 (EDT)
Subject: [PATCH 2/2] ARM: move VFP init to an earlier boot stage
In-Reply-To: <20130523084126.GI18614@n2100.arm.linux.org.uk>
References: <1369294104-3849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1369294104-3849-2-git-send-email-ard.biesheuvel@linaro.org>
 <20130523084126.GI18614@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1305231108500.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 May 2013, Russell King - ARM Linux wrote:

> On Thu, May 23, 2013 at 09:28:24AM +0200, Ard Biesheuvel wrote:
> > In order to use the NEON/VFP unit in the kernel, we should
> > initialize it a bit earlier in the boot process so NEON users
> > that like to do a quick benchmark at load time (like the
> > xor_blocks or RAID-6 code) find the NEON/VFP unit already
> > enabled.
> 
> So what are the results of those benchmarks that the RAID-6 code does?
> 
> This isn't something which will get accepted without there being a very
> strong case for it; firstly, we've always said "no FP in the kernel".

That was my opinion as well.  However the numbers are compelling.

And X86 and PPC do use FP in the kernel already for very specific tasks 
because of that.

> Secondly, it makes it too easy for people to start thinking that FP is
> safe in the kernel.  It isn't - this will go horribly wrong if the VFP
> hardware bounces an instruction to the support code.

Hmmm. good point.  We probably should set a flag in kernel_vfp_begin() 
and BUG() if the support code is invoked while that flag is set.

> Lastly, what happens if you sleep between kernel_vfp_start() and
> kernel_vfp_end() ?  That's a context switch which will mess up your
> VFP state.  I think you need to take a spinlock (not _bh nor _irqsave
> versions) in here to ensure that people don't get the idea that they
> _can_ sleep between these two.

Isn't preemption off sufficient to flag that case?  The scheduler is 
very noisy when schedule() is called with preemption disabled.


Nicolas

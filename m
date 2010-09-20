From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Sep 2010 11:33:44 -0400 (EDT)
Subject: [PATCH] ARM: plug a race with the alignment trap handler
In-Reply-To: <20100920145138.GE30793@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1009142332070.19366@xanadu.home>
	<20100920145138.GE30793@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1009201112230.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Sep 2010, Russell King - ARM Linux wrote:

> On Tue, Sep 14, 2010 at 11:35:27PM -0400, Nicolas Pitre wrote:
> > There is however a small race window when a misaligned access in user
> > space is trapped and the alignment trap disabled, but the CPU didn't
> > return to user space just yet.  Any exception would be entered from kernel
> > space at that point and the kernel would then execute with the alignment
> > trap disabled.
> 
> This isn't good enough - you can't just disable interrupts and hope
> that they'll remain that way.
> 
> Consider what happens if the threads time slice has expired, and
> TIF_NEED_RESCHED is set - the result will be that we call schedule()
> and possibly switch to another thread with alignment faults disabled.

No. This is covered in my patch, which is essentially:

	raw_local_irq_disable();
	if (!(current_thread_info()->flags & _TIF_WORK_MASK))
		set_cr(cr_no_alignment);

So if we are going to schedule or whatever, then the alignment trap 
remains active, and the user misaligned access will trap again later.

> I keep on toying with an idea to use prctl() for alignment faults,
> and whether to revamp this code to interact with that - which means
> programs can on an individual basis decide how they want alignment
> faults to be dealt with.

Altough this looks nice, I doubt this would be useful in practice.  
Most of the universe is expecting misaligned accesses to be fixed up.  
So if the fixup has to be enabled on a per application basis that would 
make things really awkward, and a real PITA if that has to be 
accomplished in the form of source code modification.  That goes without 
saying that nothing compiled for EABI expects the non fixed up 
misaligned access behavior.

If, instead, the default is to have the fixup active by default and that 
applications that doesn't want it would have to disable it explicitly 
then I agree that this would be more useful.  However my understanding 
is that the only case where disabling the fixup is needed is for legacy 
binaries and that may prove difficult to recompile them to add this 
prctl() call.


Nicolas

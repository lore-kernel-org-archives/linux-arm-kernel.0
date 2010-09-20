From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Sep 2010 15:51:38 +0100
Subject: [PATCH] ARM: plug a race with the alignment trap handler
In-Reply-To: <alpine.LFD.2.00.1009142332070.19366@xanadu.home>
References: <alpine.LFD.2.00.1009142332070.19366@xanadu.home>
Message-ID: <20100920145138.GE30793@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 14, 2010 at 11:35:27PM -0400, Nicolas Pitre wrote:
> There is however a small race window when a misaligned access in user
> space is trapped and the alignment trap disabled, but the CPU didn't
> return to user space just yet.  Any exception would be entered from kernel
> space at that point and the kernel would then execute with the alignment
> trap disabled.

This isn't good enough - you can't just disable interrupts and hope
that they'll remain that way.

Consider what happens if the threads time slice has expired, and
TIF_NEED_RESCHED is set - the result will be that we call schedule()
and possibly switch to another thread with alignment faults disabled.

I keep on toying with an idea to use prctl() for alignment faults,
and whether to revamp this code to interact with that - which means
programs can on an individual basis decide how they want alignment
faults to be dealt with.

This would mean storing a per-thread copy of the control register,
which means that the entry*.S code can deal with updating the A bit.

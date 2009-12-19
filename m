From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 19 Dec 2009 17:18:42 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20091218182007.GF5527@n2100.arm.linux.org.uk>
References: <20091218182007.GF5527@n2100.arm.linux.org.uk>
Message-ID: <1261243122.4637.9.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-12-18 at 18:20 +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2009 at 06:04:06PM +0000, Leif Lindholm wrote:
> > +static int swp_handler(struct pt_regs *regs, unsigned int instr)
> > +{
> > +     unsigned int address, destreg, data;
> > +     unsigned int res = 0;
> > +     long current_pid = sys_getpid();
> 
> Kernel functions calling system calls like this is frowned upon.  We
> know what the current PID is - it's available from current->pid.  No
> function call required.

Actually, current->pid together with get_task_comm() would be even more
useful since the task may die by the time you check the running apps.

> > +       NOTE: when accessing uncached shared regions, LDREX/STREX rely
> > +       on an external transaction monitoring block called a global
> > +       monitor to maintain update atomicity. If your system does not
> > +       implement a global monitor, this option is not safe for programs
> > +       that are permitted to map uncached memory (CAP_SYS_RAWIO).
> 
> We can trap this case by looking at the L_PTE_MT_* bits in the pte
> for the page we're going to be accessing - that's probably a good
> idea to ensure that such accesses are trapped, rather than going
> head and possibly risking silent corruption.

I wonder if there could be an exploit with Leif's current
implementation. The LDREX/STREX pair to uncached or device memory may
never complete. This way a user SWP to something like the frame buffer
would lock the kernel.

There's also TI's issue with SWP to some memory shared with devices
outside the CPU coherency domain where SWP may still be needed. Is this
usage in user space or kernel device drivers?

The major issue I see with SWP is that it isn't guaranteed to always
work in an SMP shareability domain (bus locking not implemented), hence
the LDREX/STREX emulation.

But Leif is away for the rest of the year, so we won't see an updated
patch before January.

-- 
Catalin

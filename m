From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Dec 2009 17:28:33 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <1261243122.4637.9.camel@pc1117.cambridge.arm.com>
References: <20091218182007.GF5527@n2100.arm.linux.org.uk>
	<1261243122.4637.9.camel@pc1117.cambridge.arm.com>
Message-ID: <20091219172833.GA6187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2009 at 05:18:42PM +0000, Catalin Marinas wrote:
> On Fri, 2009-12-18 at 18:20 +0000, Russell King - ARM Linux wrote:
> > On Fri, Dec 18, 2009 at 06:04:06PM +0000, Leif Lindholm wrote:
> > > +static int swp_handler(struct pt_regs *regs, unsigned int instr)
> > > +{
> > > +     unsigned int address, destreg, data;
> > > +     unsigned int res = 0;
> > > +     long current_pid = sys_getpid();
> > 
> > Kernel functions calling system calls like this is frowned upon.  We
> > know what the current PID is - it's available from current->pid.  No
> > function call required.
> 
> Actually, current->pid together with get_task_comm() would be even more
> useful since the task may die by the time you check the running apps.

That's effectively what is being done - current->comm is effectively
get_task_comm() - get_task_comm() just copies the string out under a
lock.

For debugging of the 'current' task, the additional copy and lock are
mere overhead.

> > We can trap this case by looking at the L_PTE_MT_* bits in the pte
> > for the page we're going to be accessing - that's probably a good
> > idea to ensure that such accesses are trapped, rather than going
> > head and possibly risking silent corruption.
> 
> I wonder if there could be an exploit with Leif's current
> implementation. The LDREX/STREX pair to uncached or device memory may
> never complete. This way a user SWP to something like the frame buffer
> would lock the kernel.

That means we shouldn't consider applying it until that has been
investigated.

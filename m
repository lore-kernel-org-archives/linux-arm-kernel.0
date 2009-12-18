From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2009 20:01:28 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20091218194814.GB1205@shareable.org>
References: <20091218180406.32211.72790.stgit@e101986-lin>
	<20091218182007.GF5527@n2100.arm.linux.org.uk>
	<20091218194814.GB1205@shareable.org>
Message-ID: <20091218200128.GI5527@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 07:48:14PM +0000, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > On Fri, Dec 18, 2009 at 06:04:06PM +0000, Leif Lindholm wrote:
> > > +static int swp_handler(struct pt_regs *regs, unsigned int instr)
> > > +{
> > > +	unsigned int address, destreg, data;
> > > +	unsigned int res = 0;
> > > +	long current_pid = sys_getpid();
> > 
> > Kernel functions calling system calls like this is frowned upon.  We
> > know what the current PID is - it's available from current->pid.  No
> > function call required.
> 
> Quick nitpick in case Leif follows that advice :-)
> 
> sys_getpid returns task_tgid_vnr(current).
> 
> It is neither ->pid (gettid returns that), nor directly dereferenced
> because of the vnr part.  You'll have to decide whether current->tgid
> or task_tgid_vnr(current), or current->pid after all are the
> appropriate value in this situation.

task_tgid_vnr() returns the "thread group" (aka process) ID, and is
what 'ps' spits out for PID.  current->pid is effectively the thread
ID and is unique to every thread.

If you base this decision on the thread group (sys_getpid()), it can
miss threads within a process which may make use of swp - and the
use of swp may not be in the binary but a called library.

If the purpose of this is to find where the swp's are, then you want
to use current->pid, not sys_getpid().

That aside, the printk is a DoS attack waiting to happen.  It needs
rate limiting.

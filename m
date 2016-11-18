From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2016 14:11:23 +0000
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <alpine.DEB.2.20.1611181447100.3615@nanos>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <20161118120453.GI13470@arm.com>
 <alpine.DEB.2.20.1611181401180.3615@nanos>
 <20161118132912.GM13470@arm.com>
 <alpine.DEB.2.20.1611181430070.3615@nanos>
 <20161118134847.GO13470@arm.com>
 <alpine.DEB.2.20.1611181447100.3615@nanos>
Message-ID: <20161118141122.GP13470@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 02:59:04PM +0100, Thomas Gleixner wrote:
> On Fri, 18 Nov 2016, Will Deacon wrote:
> > On Fri, Nov 18, 2016 at 02:42:15PM +0100, Thomas Gleixner wrote:
> > > On Fri, 18 Nov 2016, Will Deacon wrote:
> > > > On Fri, Nov 18, 2016 at 02:11:58PM +0100, Thomas Gleixner wrote:
> > > > > But it's guaranteed that cpuhp_setup_state() will not return before the
> > > > > callback has been invoked on each online cpu.
> > > > 
> > > > Ok, that's good.
> > > > 
> > > > > If cpus are not yet online when that code is invoked, then it's the same
> > > > > behaviour as before. It will be invoked when the cpu comes online.
> > > > 
> > > > Just to check, but what stops a CPU from coming online between the call
> > > > to cpuhp_setup_state and the call to cpuhp_remove_state_nocalls in the
> > > > case of failure (debug_err_mask isn't empty)?
> > > 
> > > Indeed! I missed that part. So we still need a get/put_online_cpus()
> > > protection around all of this.
> > 
> > Yes, that should do it.
> > 
> > > Just for curiosity sake. Wouldn't it be simpler and less error prone to
> > > make the ARM_DBG_READ/WRITE macros use the exception table and handle that
> > > in the undefined instruction handler to avoid this hook dance?
> > 
> > That would be an option, but it's only the reset sequence that could
> > generate this fault so it's simpler to isolate it there. 
> 
> ARM_DBG_READ/WRITE_SAFE() then for reset_ctrl_regs()
> 
> > We'd also have to take into account SMP if we toggle the handler in the
> > READ/WRITE accessors, since the fault handler framework is system-wide as
> > opposed to per-cpu. The whole thing is grotty as hell.
> 
> The exception table is not toggling anything. It's just providing an entry
> in the exception tables, which is scanned by fixup_exception(), which then
> moves PC to the exception code. See __get_user_asm().

Oooh, now I see what you mean. I thought you were on about toggling
using register_undef_hook, but you're actually on about the extable stuff
that we already use for handling faults on user addresses in the kernel.

That's not a bad idea at all.

Will

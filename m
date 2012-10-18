From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Oct 2012 08:51:36 +0300
Subject: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
In-Reply-To: <87txtsitpt.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
Message-ID: <20121018055136.GF11137@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 04:06:54PM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > On Wed, Oct 17, 2012 at 05:00:02PM +0300, Felipe Balbi wrote:
> >> 
> >> On Tue, Oct 16, 2012 at 02:39:50PM -0700, Kevin Hilman wrote:
> >> > + peterz, tglx
> >> > 
> >> > Felipe Balbi <balbi@ti.com> writes:
> >> > 
> >> > [...]
> >> > 
> >> > > The problem I see is that even though we properly return IRQ_WAKE_THREAD
> >> > > and wake_up_process() manages to wakeup the IRQ thread (it returns 1),
> >> > > the thread is never scheduled. To make things even worse, ouw irq thread
> >> > > runs once, but doesn't run on a consecutive call. Here's some (rather
> >> > > nasty) debug prints showing the problem:
> >> > 
> >> > [...]
> >> > 
> >> > >> [   88.721923] try_to_wake_up 1411
> >> > >> [   88.725189] ===> irq_wake_thread 139: IRQ 72 wake_up_process 0
> >> > >> [   88.731292] [sched_delayed] sched: RT throttling activated
> >> > 
> >> > This throttling message is the key one.
> >> > 
> >> > With RT throttling activated, the IRQ thread will not be run (it
> >> > eventually will be allowed much later on, but by then, the I2C xfers
> >> > have timed out.)
> >> > 
> >> > As a quick hack, the throttling can be disabled by seeting the
> >> > sched_rt_runtime to RUNTIME_INF:
> >> > 
> >> >         # sysctl -w kernel.sched_rt_runtime_us=-1
> >> > 
> >> > and a quick test shows that things go back to working as expected.  But
> >> > we still need to figure out why the throttling is hapenning...
> >> > 
> >> > So I started digging into why the RT runtime was so high, and noticed
> >> > that time spent in suspend was being counted as RT runtime!
> >> > 
> >> > So spending time in suspend anywhere near sched_rt_runtime (0.95s) will
> >> > cause the RT throttling to always be triggered, and thus prevent IRQ
> >> > threads from running in the resume path.  Ouch.
> >> > 
> >> > I think I'm already in over my head in the RT runtime stuff, but
> >> > counting the time spent in suspend as RT runtime smells like a bug to
> >> > me. no?
> >> > 
> >> > Peter? Thomas?
> >> 
> >> it looks like removing console output completely (echo 0 >
> >> /proc/sysrq-trigger) I don't see the issue anymore. Let me just run for
> >> a few more iterations to make sure what I'm saying is correct.
> >
> > Yeah, really looks like removing console output makes the problem go
> > away. Ran a few iterations and it always worked fine. Full logs attached
> 
> Removing console output during resume is going to significantly change
> the timing of what is happening during suspend/resume, so I suspect that
> combined with all your other debug prints is somehow masking the
> problem.  How log are you letting the system stay in suspend?

about 2 minutes

> That being said, I can still easily reproduce the problem, even with
> console output disabled.
> 
> With vanilla v3.7-rc1 + the debug patch below[1], with and without
> console output, I see RT throttling kicking in on resume, and the RT
> runtime on resume corresponds to the time spent in suspend.  Here's an
> example of debug output of my patch below after ~3 sec in suspend:
> 
> [   43.198028] sched_rt_runtime_exceeded: rt_time 2671752930 > runtime 950000000
> [   43.198028] update_curr_rt: RT runtime exceeded: irq/72-omap_i2c
> [   43.198059] update_curr_rt: RT runtime exceeded: irq/72-omap_i2c
> [   43.203704] [sched_delayed] sched: RT throttling activated
> 
> I see this rather consistently, and the rt_time value is always roughly the
> time I spent in suspend.
> 
> So the primary question remains: is RT runtime supposed to include the
> time spent suspended?  I suspect not. 

you might be right there, though we need Thomas or Peter to answer :-s

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121018/033fbaef/attachment.sig>

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Jul 2013 21:21:48 +0100
Subject: [PATCH] ARM: Fix deadlock scenario with smp_send_stop()
In-Reply-To: <20130724185618.GD27761@codeaurora.org>
References: <1373384217-26307-1-git-send-email-sboyd@codeaurora.org>
 <20130724185618.GD27761@codeaurora.org>
Message-ID: <20130724202148.GA24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:56:18AM -0700, Stephen Boyd wrote:
> On 07/09, Stephen Boyd wrote:
> > If one process calls sys_reboot and that process then stops other
> > CPUs while those CPUs are within a spin_lock() region we can
> > potentially encounter a deadlock scenario like below.
> > 
> > CPU 0                   CPU 1
> > -----                   -----
> >                         spin_lock(my_lock)
> > smp_send_stop()
> >  <send IPI>             handle_IPI()
> >                          disable_preemption/irqs
> >                           while(1);
> >  <PREEMPT>
> > spin_lock(my_lock) <--- Waits forever
> > 
> > We shouldn't attempt to run any other tasks after we send a stop
> > IPI to a CPU so disable preemption so that this task runs to
> > completion.
> > 
> > Reported-by: Sundarajan Srinivasan <sundaraj@codeaurora.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > Resending this patch now that the context has changed.
> 
> Ping? Shall I put this in the patch tracker?

Well, looking at x86, they use local_irq_disable() before sending the
stop, so I think we should do the same for cross-arch consistency.

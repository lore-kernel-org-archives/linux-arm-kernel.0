From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 28 Aug 2014 08:43:09 -0700
Subject: [PATCH v10 03/19] arm: fiq: Replace default FIQ handler
In-Reply-To: <20140828150112.GD30401@n2100.arm.linux.org.uk>
References: <1408369264-14242-1-git-send-email-daniel.thompson@linaro.org>
 <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1408466769-20004-4-git-send-email-daniel.thompson@linaro.org>
 <20140819173742.GG30401@n2100.arm.linux.org.uk>
 <53F39377.1070308@linaro.org>
 <20140828150112.GD30401@n2100.arm.linux.org.uk>
Message-ID: <20140828154309.GA5001@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 04:01:12PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 19, 2014 at 07:12:07PM +0100, Daniel Thompson wrote:
> > On 19/08/14 18:37, Russell King - ARM Linux wrote:
> > > On Tue, Aug 19, 2014 at 05:45:53PM +0100, Daniel Thompson wrote:
> > >> +int register_fiq_nmi_notifier(struct notifier_block *nb)
> > >> +{
> > >> +	return atomic_notifier_chain_register(&fiq_nmi_chain, nb);
> > >> +}
> > >> +
> > >> +asmlinkage void __exception_irq_entry fiq_nmi_handler(struct pt_regs *regs)
> > >> +{
> > >> +	struct pt_regs *old_regs = set_irq_regs(regs);
> > >> +
> > >> +	nmi_enter();
> > >> +	atomic_notifier_call_chain(&fiq_nmi_chain, (unsigned long)regs, NULL);
> > >> +	nmi_exit();
> > >> +	set_irq_regs(old_regs);
> > >> +}
> > > 
> > > Really not happy with this.  What happens if a FIQ occurs while we're
> > > inside register_fiq_nmi_notifier() - more specifically inside
> > > atomic_notifier_chain_register() ?
> > 
> > Should depend on which side of the rcu update we're on.
> 
> I just asked Paul McKenney, our RCU expert... essentially, yes, RCU
> stuff itself is safe in this context.  However, RCU stuff can call into
> lockdep if lockdep is configured, and there are questions over lockdep.
> 
> There's some things which can be done to reduce the lockdep exposure
> to it, such as ensuring that rcu_read_lock() is first called outside
> of FIQ context.
> 
> There's concerns with whether either printk() in check_flags() could
> be reached too (flags there should always indicate that IRQs were
> disabled, so that reduces down to a question about just the first
> printk() there.)
> 
> There's also the very_verbose() stuff for RCU lockdep classes which
> Paul says must not be enabled.
> 
> Lastly, Paul isn't a lockdep expert, but he sees nothing that prevents
> lockdep doing the deadlock checking as a result of the above call.
> 
> So... this coupled with my feeling that notifiers make it too easy for
> unreviewed code to be hooked into this path, I'm fairly sure that we
> don't want to be calling atomic notifier chains from FIQ context.

In the worst case, it would be possible to create a parallel notifier
that was intended for use from NMI.  There would be no need for
rcu_read_lock() in that case, we would instead be using RCU-sched,
for which NMI handlers are automatically RCU-sched read-side critical
sections.  Instead of synchronize_rcu(), this NMI version would use
synchronize_sched().

But if lockdep works from NMI, then the current notifiers would work
just fine.

							Thanx, Paul

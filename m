From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 24 Feb 2015 08:27:19 +0100
Subject: [PATCH 1/7] Add die_spin_lock_{irqsave,irqrestore}
In-Reply-To: <20150224064107.GB15387@gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <1424748634-9153-2-git-send-email-anton@samba.org>
 <20150224064107.GB15387@gmail.com>
Message-ID: <20150224072719.GB15894@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Anton Blanchard <anton@samba.org> wrote:
> 
> > +static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> > +static int die_owner = -1;
> > +static unsigned int die_nest_count;
> > +
> > +unsigned long __die_spin_lock_irqsave(void)
> > +{
> > +	unsigned long flags;
> > +	int cpu;
> > +
> > +	/* racy, but better than risking deadlock. */
> > +	raw_local_irq_save(flags);
> > +
> > +	cpu = smp_processor_id();
> > +	if (!arch_spin_trylock(&die_lock)) {
> > +		if (cpu != die_owner)
> > +			arch_spin_lock(&die_lock);
> 
> So why not trylock and time out here after a few seconds, 
> instead of indefinitely supressing some potentially vital 
> output due to some other CPU crashing/locking with the lock 
> held?

[...]

> If we fix the deadlock potential, and get a true global 
> ordering of various oopses/warnings as they triggered (or 
> at least timestamping them), [...]

If we had a global 'trouble counter' we could use that to 
refine the spin-looping timeout: instead of using a pure 
timeout of a few seconds, we could say 'a timeout of a few 
seconds while the counter does not increase'.

I.e. only override the locking/ordering if the owner CPU 
does not seem to be able to make progress with printing the 
oops/warning.

Thanks,

	Ingo

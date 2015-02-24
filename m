From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 24 Feb 2015 07:41:07 +0100
Subject: [PATCH 1/7] Add die_spin_lock_{irqsave,irqrestore}
In-Reply-To: <1424748634-9153-2-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <1424748634-9153-2-git-send-email-anton@samba.org>
Message-ID: <20150224064107.GB15387@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Anton Blanchard <anton@samba.org> wrote:

> +static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +static int die_owner = -1;
> +static unsigned int die_nest_count;
> +
> +unsigned long __die_spin_lock_irqsave(void)
> +{
> +	unsigned long flags;
> +	int cpu;
> +
> +	/* racy, but better than risking deadlock. */
> +	raw_local_irq_save(flags);
> +
> +	cpu = smp_processor_id();
> +	if (!arch_spin_trylock(&die_lock)) {
> +		if (cpu != die_owner)
> +			arch_spin_lock(&die_lock);

So why not trylock and time out here after a few seconds, 
instead of indefinitely supressing some potentially vital 
output due to some other CPU crashing/locking with the lock 
held?

> +	}
> +	die_nest_count++;
> +	die_owner = cpu;
> +
> +	return flags;

I suspect this would work in most cases.

If we fix the deadlock potential, and get a true global 
ordering of various oopses/warnings as they triggered (or 
at least timestamping them), then I'm sold on this I guess, 
it will likely improve things.

Thanks,

	Ingo

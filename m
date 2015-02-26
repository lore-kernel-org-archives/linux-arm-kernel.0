From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 26 Feb 2015 21:05:40 +0000
Subject: [PATCH 3.19-rc6 v16 1/6] irqchip: gic: Optimize locking in
 gic_raise_softirq
In-Reply-To: <alpine.LFD.2.11.1502261449380.25484@knanqh.ubzr>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1422990417-1783-1-git-send-email-daniel.thompson@linaro.org>
 <1422990417-1783-2-git-send-email-daniel.thompson@linaro.org>
 <alpine.LFD.2.11.1502261449380.25484@knanqh.ubzr>
Message-ID: <1424984740.21020.11.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-02-26 at 15:31 -0500, Nicolas Pitre wrote:
> On Tue, 3 Feb 2015, Daniel Thompson wrote:
> 
> > Currently gic_raise_softirq() is locked using upon irq_controller_lock.
> > This lock is primarily used to make register read-modify-write sequences
> > atomic but gic_raise_softirq() uses it instead to ensure that the
> > big.LITTLE migration logic can figure out when it is safe to migrate
> > interrupts between physical cores.
> > 
> > This is sub-optimal in closely related ways:
> > 
> > 1. No locking at all is required on systems where the b.L switcher is
> >    not configured.
> 
> ACK
> 
> > 2. Finer grain locking can be used on systems where the b.L switcher is
> >    present.
> 
> NAK
> 
> Consider this sequence:
> 
> 	CPU 1				CPU 2
> 	-----				-----
> 	gic_raise_softirq()		gic_migrate_target()
> 	bl_migration_lock() [OK]
> 	[...]				[...]
> 	map |= gic_cpu_map[cpu];	bl_migration_lock() [contended]
> 	bl_migration_unlock(flags);	bl_migration_lock() [OK]
> 					gic_cpu_map[cpu] = 1 << new_cpu_id;
> 					bl_migration_unlock(flags);
> 					[...]
> 					(migrate pending IPI from old CPU)
> 	writel_relaxed(map to GIC_DIST_SOFTINT);

Isn't this solved inside gic_raise_softirq? How can the writel_relaxed()
escape from the critical section and happen at the end of the sequence?


> 	[this IPI is now lost]
> 
> Granted, this race is apparently aready possible today.  We probably get 
> away with it because the locked sequence in gic_migrate_target() include 
> the retargetting of peripheral interrupts which gives plenti of time for 
> code execution in gic_raise_softirq() to post its IPI before the IPI 
> migration code is executed.  So in that sense it could be argued that 
> the reduced lock coverage from your patch doesn't make things any worse.  
> If anything it might even help by letting gic_migrate_target() complete 
> sooner.  But removing cpu_map_migration_lock altogether would improve 
> things even further by that logic.  I however don't think we should live 
> so dangerously.
> 
> Therefore, for the lock to be effective, it has to encompass the 
> changing of the CPU map _and_ migration of pending IPIs before new IPIs 
> are allowed again.  That means the locked area has to grow not shrink.
> 
> Oh, and a minor nit:
> 
> > + * This lock is used by the big.LITTLE migration code to ensure no IPIs
> > + * can be pended on the old core after the map has been updated.
> > + */
> > +#ifdef CONFIG_BL_SWITCHER
> > +static DEFINE_RAW_SPINLOCK(cpu_map_migration_lock);
> > +
> > +static inline void bl_migration_lock(unsigned long *flags)
> 
> Please name it gic_migration_lock. "bl_migration_lock" is a bit too 
> generic in this context.

I'll change this.

Daniel.

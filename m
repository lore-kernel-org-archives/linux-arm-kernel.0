From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 27 Apr 2017 12:01:57 +0200 (CEST)
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <20170427095744.GB31337@leverpostej>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
 <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
 <20170426103236.GI27156@leverpostej>
 <20170427082719.3wyru4bk67kdmflb@linutronix.de>
 <20170427095744.GB31337@leverpostej>
Message-ID: <alpine.DEB.2.20.1704271200420.4607@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Apr 2017, Mark Rutland wrote:

> On Thu, Apr 27, 2017 at 10:27:20AM +0200, Sebastian Siewior wrote:
> > On 2017-04-26 11:32:36 [+0100], Mark Rutland wrote:
> > > > So we could end up calling static_branch_enable_cpuslocked()
> > > > without actually holding the lock. Should we do a cpu_hotplug_begin/done in
> > > > setup_cpu_feature_capabilities ? I agree it doesn't look that nice. Thoughts ?
> > > 
> > > I agree that's hideous, but it looks like the only choice given the
> > > hotplug rwsem cahnges. :/
> > 
> > would work for you to provide a locked and unlocked version?
> 
> Maybe. Today we have:
> 
> // rwsem unlocked
> start_kernel()
> ->smp_prepare_boot_cpu()
> -->update_cpu_errata_workarounds()
> --->update_cpu_capabilities()
> 
> // rwsem locked (by other CPU)
> secondary_start_kernel()
> ->check_local_cpu_capabilities()
> -->update_cpu_errata_workarounds()
> --->update_cpu_capabilities() 
> 
> With the common chain:
> 
> update_cpu_capabilities()
> ->cpus_set_cap()
> -->static_branch_enable()
> 
> ... so we could add a update_cpu_capabilities{,_cpuslocked}(), and say
> that cpus_set_cap() expects the hotplug rswem to be locked, as per the
> below diff.

You just can take the rwsen in smp_prepare_boot_cpu(), so you don't need
that conditional thingy at all. Hmm?

Thanks,

	tglx

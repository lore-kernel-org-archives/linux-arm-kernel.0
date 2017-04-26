From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Apr 2017 11:32:36 +0100
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
 <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
Message-ID: <20170426103236.GI27156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 10:40:47AM +0100, Suzuki K Poulose wrote:
> On 26/04/17 09:59, Mark Rutland wrote:

> >We only call cpus_set_cap() in the secondary boot path, where we know
> >that the rwsem is held by the thread orchestrating the onlining. Thus,
> >we can use the new static_branch_enable_cpuslocked() in cpus_set_cap(),
> >avoiding the above.
> 
> Correction, we could call cpus_set_cap() from setup_cpu_features()
> for updating the system global capabilities, where we may not hold the
> cpu_hotplug_lock. 

Argh, yes, I missed that when scanning.

> So we could end up calling static_branch_enable_cpuslocked()
> without actually holding the lock. Should we do a cpu_hotplug_begin/done in
> setup_cpu_feature_capabilities ? I agree it doesn't look that nice. Thoughts ?

I agree that's hideous, but it looks like the only choice given the
hotplug rwsem cahnges. :/

I can spin a v2 with that and the typo fixes.

Thanks,
Mark.

> 
> Suzuki
> 
> >		
> >Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> >Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Suzuki Poulose <suzuki,poulose@arm.com>
> >---
> > arch/arm64/include/asm/cpufeature.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >index f31c48d..349b5cd 100644
> >--- a/arch/arm64/include/asm/cpufeature.h
> >+++ b/arch/arm64/include/asm/cpufeature.h
> >@@ -145,7 +145,7 @@ static inline void cpus_set_cap(unsigned int num)
> > 			num, ARM64_NCAPS);
> > 	} else {
> > 		__set_bit(num, cpu_hwcaps);
> >-		static_branch_enable(&cpu_hwcap_keys[num]);
> >+		static_branch_enable_cpuslocked(&cpu_hwcap_keys[num]);
> > 	}
> > }
> >
> >
> 

From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Apr 2017 10:57:44 +0100
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <20170427082719.3wyru4bk67kdmflb@linutronix.de>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
 <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
 <20170426103236.GI27156@leverpostej>
 <20170427082719.3wyru4bk67kdmflb@linutronix.de>
Message-ID: <20170427095744.GB31337@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 10:27:20AM +0200, Sebastian Siewior wrote:
> On 2017-04-26 11:32:36 [+0100], Mark Rutland wrote:
> > > So we could end up calling static_branch_enable_cpuslocked()
> > > without actually holding the lock. Should we do a cpu_hotplug_begin/done in
> > > setup_cpu_feature_capabilities ? I agree it doesn't look that nice. Thoughts ?
> > 
> > I agree that's hideous, but it looks like the only choice given the
> > hotplug rwsem cahnges. :/
> 
> would work for you to provide a locked and unlocked version?

Maybe. Today we have:

// rwsem unlocked
start_kernel()
->smp_prepare_boot_cpu()
-->update_cpu_errata_workarounds()
--->update_cpu_capabilities()

// rwsem locked (by other CPU)
secondary_start_kernel()
->check_local_cpu_capabilities()
-->update_cpu_errata_workarounds()
--->update_cpu_capabilities() 

With the common chain:

update_cpu_capabilities()
->cpus_set_cap()
-->static_branch_enable()

... so we could add a update_cpu_capabilities{,_cpuslocked}(), and say
that cpus_set_cap() expects the hotplug rswem to be locked, as per the
below diff.

Thoughts?

Mark.

---->8----

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f31c48d..7341579 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -145,7 +145,7 @@ static inline void cpus_set_cap(unsigned int num)
 			num, ARM64_NCAPS);
 	} else {
 		__set_bit(num, cpu_hwcaps);
-		static_branch_enable(&cpu_hwcap_keys[num]);
+		static_branch_enable_cpuslocked(&cpu_hwcap_keys[num]);
 	}
 }
 
@@ -217,8 +217,22 @@ static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
 
 void __init setup_cpu_features(void);
 
-void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info);
+void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+			       const char *info, bool cpuslocked);
+static inline void
+update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+			  const char *info)
+{
+	__update_cpu_capabilities(caps, info, false);
+}
+
+static inline void
+update_cpu_capabilities_cpuslocked(const struct arm64_cpu_capabilities *caps,
+			  const char *info)
+{
+	__update_cpu_capabilities(caps, info, true);
+}
+
 void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
 void check_local_cpu_capabilities(void);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e8..ae8ddc1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -956,8 +956,8 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info)
+void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+			       const char *info, bool cpuslocked)
 {
 	for (; caps->matches; caps++) {
 		if (!caps->matches(caps, caps->def_scope))
@@ -965,7 +965,14 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
 			pr_info("%s %s\n", info, caps->desc);
-		cpus_set_cap(caps->capability);
+
+		if (cpuslocked) {
+			cpus_set_cap(caps->capability);
+		} else {
+			get_online_cpus();
+			cpus_set_cap(caps->capability);
+			put_online_cpus();
+		}
 	}
 }
 

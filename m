From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Apr 2017 16:48:06 +0100
Subject: [PATCH] arm64: cpufeature: use static_branch_enable_cpuslocked()
 (was: Re: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem)
In-Reply-To: <20170427123056.GD31337@leverpostej>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
 <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
 <20170426103236.GI27156@leverpostej>
 <20170427082719.3wyru4bk67kdmflb@linutronix.de>
 <20170427095744.GB31337@leverpostej>
 <alpine.DEB.2.20.1704271200420.4607@nanos>
 <20170427123056.GD31337@leverpostej>
Message-ID: <20170427154806.GA6646@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin/Will,

The below addresses a boot failure Catalin spotted in next-20170424,
based on Sebastian's patch [1]. I've given it a spin on Juno R1, where I
can reproduce the issue prior to applying this patch.

I believe this would need to go via tip, as the issue is a result of
change in the tip smp/hotplug branch, and the fix depends on
infrastructure introduced there.

Are you happy with the fix, and for it to go via the tip tree?

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20170425172838.mr3kyccsdteyjso5 at linutronix.de
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=smp/hotplug

---->8----
>From 6cdb503b060f74743769c9f601c35f985d3c58eb Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 26 Apr 2017 09:46:47 +0100
Subject: [PATCH] arm64: cpufeature: use static_branch_enable_cpuslocked()

Recently, the hotplug locking was conveted to use a percpu rwsem. Unlike
the existing {get,put}_online_cpus() logic, this can't nest.
Unfortunately, in arm64's secondary boot path we can end up nesting via
static_branch_enable() in cpus_set_cap() when we detect an erratum.

This leads to a stream of messages as below, where the secondary
attempts to schedule before it has been fully onlined. As the CPU
orchestrating the onlining holds the rswem, this hangs the system.

[    0.250334] BUG: scheduling while atomic: swapper/1/0/0x00000002
[    0.250337] Modules linked in:
[    0.250346] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.11.0-rc7-next-20170424 #2
[    0.250349] Hardware name: ARM Juno development board (r1) (DT)
[    0.250353] Call trace:
[    0.250365] [<ffff000008088510>] dump_backtrace+0x0/0x238
[    0.250371] [<ffff00000808880c>] show_stack+0x14/0x20
[    0.250377] [<ffff00000839d854>] dump_stack+0x9c/0xc0
[    0.250384] [<ffff0000080e3540>] __schedule_bug+0x50/0x70
[    0.250391] [<ffff000008932ecc>] __schedule+0x52c/0x5a8
[    0.250395] [<ffff000008932f80>] schedule+0x38/0xa0
[    0.250400] [<ffff000008935e8c>] rwsem_down_read_failed+0xc4/0x108
[    0.250407] [<ffff0000080fe8e0>] __percpu_down_read+0x100/0x118
[    0.250414] [<ffff0000080c0b60>] get_online_cpus+0x70/0x78
[    0.250420] [<ffff0000081749e8>] static_key_enable+0x28/0x48
[    0.250425] [<ffff00000808de90>] update_cpu_capabilities+0x78/0xf8
[    0.250430] [<ffff00000808d14c>] update_cpu_errata_workarounds+0x1c/0x28
[    0.250435] [<ffff00000808e004>] check_local_cpu_capabilities+0xf4/0x128
[    0.250440] [<ffff00000808e894>] secondary_start_kernel+0x8c/0x118
[    0.250444] [<000000008093d1b4>] 0x8093d1b4

We call cpus_set_cap() from update_cpu_capabilities(), which is called
from the secondary boot path (where the CPU orchestrating the onlining
holds the hotplug rwsem), and in the primary boot path, where this is
not held.

This patch makes cpus_set_cap() use static_branch_enable_cpuslocked(),
and updates the primary CPU boot path to hold the rwsem so as to keep
the *_cpuslocked() code happy.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki Poulose <suzuki,poulose@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/kernel/smp.c             | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f31c48d..349b5cd 100644
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
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9b10365..c2ce9aa 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -447,11 +447,13 @@ void __init smp_prepare_boot_cpu(void)
 	cpuinfo_store_boot_cpu();
 	save_boot_cpu_run_el();
 	/*
-	 * Run the errata work around checks on the boot CPU, once we have
-	 * initialised the cpu feature infrastructure from
-	 * cpuinfo_store_boot_cpu() above.
+	 * Run the errata work around checks on the boot CPU, now that
+	 * cpuinfo_store_boot_cpu() has set things up. We hold the percpu rwsem
+	 * to keep the workaround setup code happy.
 	 */
+	get_online_cpus();
 	update_cpu_errata_workarounds();
+	put_online_cpus();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
-- 
1.9.1

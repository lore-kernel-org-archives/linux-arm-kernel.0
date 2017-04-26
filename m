From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Apr 2017 09:59:59 +0100
Subject: [patch V2 00/24] cpu/hotplug: Convert get_online_cpus() to a
 percpu_rwsem
In-Reply-To: <20170425172838.mr3kyccsdteyjso5@linutronix.de>
References: <20170418170442.665445272@linutronix.de>
 <20170425161037.GA27156@leverpostej>
 <20170425172838.mr3kyccsdteyjso5@linutronix.de>
Message-ID: <20170426085958.GC27156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 07:28:38PM +0200, Sebastian Siewior wrote:
> On 2017-04-25 17:10:37 [+0100], Mark Rutland wrote:
> > When we bring the secondary CPU online, we detect an erratum that wasn't
> > present on the boot CPU, and try to enable a static branch we use to
> > track the erratum. The call to static_branch_enable() blows up as above.
> 
> this (cpus_set_cap()) seems only to be used used in CPU up part.
> 
> > I see that we now have static_branch_disable_cpuslocked(), but we don't
> > have an equivalent for enable. I'm not sure what we should be doing
> > here.
> 
> We should introduce static_branch_enable_cpuslocked(). Does this work
> for you (after s/static_branch_enable/static_branch_enable_cpuslocked/
> in cpus_set_cap()) ?:

The patch you linked worked for me, given the below patch for arm64 to
make use of static_branch_enable_cpuslocked().

Catalin/Will, are you happy for this to go via the tip tree with the
other hotplug locking changes?

Thanks,
Mark.

---->8----
>From 03c98baf0a9fcdfb87145bfb3f108d49a721dad6 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 26 Apr 2017 09:46:47 +0100
Subject: [PATCH] arm64: cpufeature: use static_branch_enable_cpuslocked()

Recently, the hotplug locking was conveted to use a percpu rwsem. Unlike
the existing {get,put}_online_cpus() logic, this can't nest.
Unfortunately, in arm64's secondary boot path we can end up nesting via
static_branch_enable() in cpus_set_cap() when we detect an erratum.

This leads to a stream of messages as below, where the secondary
attempts to schedule befroe it has been fully onlined. As the CPU
orchsetrating the onlining holds the rswem, this hangs the system.

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

We only call cpus_set_cap() in the secondary boot path, where we know
that the rwsem is held by the thread orchestrating the onlining. Thus,
we can use the new static_branch_enable_cpuslocked() in cpus_set_cap(),
avoiding the above.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki Poulose <suzuki,poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
1.9.1

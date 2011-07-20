From: mturquette@ti.com (Mike Turquette)
Date: Wed, 20 Jul 2011 16:32:25 -0700
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
Message-ID: <1311204745-6276-1-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A quick poll of the ARM platforms that implement CPU Hotplug support
shows that every platform treats CPU 0 as a special case that cannot be
hotplugged.  In fact every platform has identical code for
platform_cpu_die which returns -EPERM in the case of CPU 0.

The user-facing sysfs interfaces should reflect this by not populating
an 'online' entry for CPU 0 at all.  This better reflects reality by
making it clear to users that CPU 0 cannot be hotplugged.

This patch prevents CPU 0 from being marked as hotpluggable on all ARM
platforms during CPU registration.  This in turn prevents the creation
of an 'online' sysfs interface for that CPU.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/kernel/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ed11fb0..a5fc969 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -940,7 +940,8 @@ static int __init topology_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
-		cpuinfo->cpu.hotpluggable = 1;
+		if (cpu)
+			cpuinfo->cpu.hotpluggable = 1;
 		register_cpu(&cpuinfo->cpu, cpu);
 	}
 
-- 
1.7.4.1

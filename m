From: mturquette@ti.com (Mike Turquette)
Date: Mon, 18 Jul 2011 17:33:22 -0700
Subject: [PATCH 1/2] ARM: conditionally allow master CPU hotplugging
Message-ID: <mailman.26.1311286727.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently all CPUs are marked as hotpluggable in topology_init().  This
is not true for all ARM SMP platforms including OMAP4.  In the OMAP4
case, CPU0 is considered as privileged due to TrustZone software and
other considerations.

This patch introduces a new config option, HOTPLUG_CPU_MASTER, which
prevents the first CPU in possible_cpu_mask from being marked
hotpluggable if set.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/Kconfig        |    8 ++++++++
 arch/arm/kernel/setup.c |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..a6e34f5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1393,6 +1393,14 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.

+config HOTPLUG_CPU_MASTER
+	bool "Prevent first CPU (master) from hotplugging"
+	depends on HOTPLUG_CPU
+	help
+	  Say Y here if your platform treats the first CPU as a special
+	  "master" CPU and cannot allow it to hotplug.  This prevents the
+	  "online" entry in sysfs for that CPU.
+
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ed11fb0..3785420 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -940,7 +940,12 @@ static int __init topology_init(void)

 	for_each_possible_cpu(cpu) {
 		struct cpuinfo_arm *cpuinfo =3D &per_cpu(cpu_data, cpu);
+#ifdef CONFIG_HOTPLUG_CPU_MASTER
+		if (cpu)
+			cpuinfo->cpu.hotpluggable =3D 1;
+#else
 		cpuinfo->cpu.hotpluggable =3D 1;
+#endif
 		register_cpu(&cpuinfo->cpu, cpu);
 	}

--=20
1.7.4.1



and,

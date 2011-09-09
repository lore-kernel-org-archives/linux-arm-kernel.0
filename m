From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri,  9 Sep 2011 11:26:50 -0400
Subject: [PATCH 3/5] ARM: shmobile: Use wfi macro in platform_cpu_die.
In-Reply-To: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <1315582012-23507-4-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current Shmobile CPU hotplug code includes a hardcoded WFI instruction,
in ARM encoding.  The hardcoded instruction is both hard to understand
and doomed to failure when building the kernel in Thumb-2 mode.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
Compile tested in both ARM and Thumb-2 mode, and the resulting hotplug.o
contains the correct instruction sequence, but the final kernel failed
to link for apparently unrelated reasons:

In ARM mode:

    LD      .tmp_vmlinux1
  arch/arm/kernel/built-in.o: In function `twd_timer_setup':
  io.c:(.cpuinit.text+0x600): undefined reference to `gic_enable_ppi'
  arch/arm/mach-shmobile/built-in.o: In function `smp_init_cpus':
  pfc-sh7372.c:(.init.text+0xbb0): undefined reference to `gic_raise_softirq'

In Thumb-2 mode:

    LD      .tmp_vmlinux1
  arch/arm/kernel/built-in.o: In function `get_wchan':
  io.c:(.text+0x1542): undefined reference to `unwind_frame'
  arch/arm/kernel/built-in.o: In function `walk_stackframe':
  io.c:(.text+0x27f0): undefined reference to `unwind_frame'
  arch/arm/kernel/built-in.o: In function `profile_pc':
  io.c:(.text+0x2828): undefined reference to `unwind_frame'
  arch/arm/kernel/built-in.o: In function `twd_timer_setup':
  io.c:(.cpuinit.text+0x42e): undefined reference to `gic_enable_ppi'
  arch/arm/mach-shmobile/built-in.o: In function `smp_init_cpus':
  pfc-sh7372.c:(.init.text+0x8e8): undefined reference to `gic_raise_softirq'
---
 arch/arm/mach-shmobile/hotplug.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index 238a0d9..1e83087 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -13,6 +13,8 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
+#include <asm/system.h>
+
 int platform_cpu_kill(unsigned int cpu)
 {
 	return 1;
@@ -21,13 +23,7 @@ int platform_cpu_kill(unsigned int cpu)
 void platform_cpu_die(unsigned int cpu)
 {
 	while (1) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
+		wfi();
 	}
 }
 
-- 
1.7.3.4

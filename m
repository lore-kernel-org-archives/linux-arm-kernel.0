From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:25 +0100
Subject: [PATCH 09/11] ARM: mvebu: allow selecting mvebu without Armada XP
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
Message-ID: <1360849767-1463135-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting only CONFIG_ARCH_MVEBU but not the respective
options for Armada 370 or Armada XP results in these
link errors:

arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
arch/arm/mach-mvebu/platsmp.c:91: undefined reference to `coherency_get_cpu_count'
arch/arm/mach-mvebu/platsmp.c:104: undefined reference to `armada_mpic_send_doorbell'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
arch/arm/mach-mvebu/platsmp.c:111: undefined reference to `set_cpu_coherent'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
arch/arm/mach-mvebu/platsmp.c:83: undefined reference to `armada_xp_boot_cpu'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
arch/arm/mach-mvebu/platsmp.c:75: undefined reference to `armada_xp_mpic_smp_cpu_init'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
arch/arm/mach-mvebu/headsmp.S:46: undefined reference to `ll_set_cpu_coherent'

We can solve this by enabling all common MVEBU files that are
referenced by the SMP files. This means we enable code that
is not going to be used without a machine descriptor referencing
it, but only if the kernel is configured specifically for this
case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 99df4df..da93bcb 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,7 +3,8 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y += system-controller.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
+obj-y				 += system-controller.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
+obj-$(CONFIG_ARCH_MVEBU)	 += addr-map.o coherency.o coherency_ll.o pmsu.o irq-armada-370-xp.o 
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
-- 
1.8.1.2

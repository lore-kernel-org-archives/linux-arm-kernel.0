From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:18 +0200
Subject: [PATCH 01/11] ARM: topology: mark init_cpu_topology as __init
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_cpu_topology function can be put into the __init section
and discarded after boot, because it is only called from
smp_prepare_cpus, which is also marked __init. This was reported
by gcc after Vincent Guittot added the parse_dt_topology function
in 339ca09d7ada "ARM: 7463/1: topology: Update cpu_power according to DT
information".

Without this patch, building kzm9g_defconfig results in:

WARNING: vmlinux.o(.text+0xb5a0): Section mismatch in reference from the function init_cpu_topology() to the function .init.text:parse_dt_topology()
The function init_cpu_topology() references
the function __init parse_dt_topology().
This is often because init_cpu_topology lacks a __init
annotation or the annotation of parse_dt_topology is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 198b084..26c12c6 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -321,7 +321,7 @@ void store_cpu_topology(unsigned int cpuid)
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
  */
-void init_cpu_topology(void)
+void __init init_cpu_topology(void)
 {
 	unsigned int cpu;
 
-- 
1.7.10

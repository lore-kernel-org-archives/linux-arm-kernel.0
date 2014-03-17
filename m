From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:35 +0000
Subject: [PATCH 36/44] ARM: l2c: move errata configuration options to
 arch/arm/mm/Kconfig
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEJ-0002eH-7H@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the L2C-310 errata configuration options to arch/arm/mm/Kconfig
along side the option which enables support for this device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig    | 51 ---------------------------------------------------
 arch/arm/mm/Kconfig | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 50ccc1fdb0cb..3a0b24e4ffe9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1230,19 +1230,6 @@ config ARM_ERRATA_742231
 	  register of the Cortex-A9 which reduces the linefill issuing
 	  capabilities of the processor.
 
-config PL310_ERRATA_588369
-	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
-	depends on CACHE_L2X0
-	help
-	   The PL310 L2 cache controller implements three types of Clean &
-	   Invalidate maintenance operations: by Physical Address
-	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
-	   They are architecturally defined to behave as the execution of a
-	   clean operation followed immediately by an invalidate operation,
-	   both performing to the same memory location. This functionality
-	   is not correctly implemented in PL310 as clean lines are not
-	   invalidated as a result of these operations.
-
 config ARM_ERRATA_643719
 	bool "ARM errata: LoUIS bit field in CLIDR register is incorrect"
 	depends on CPU_V7 && SMP
@@ -1265,17 +1252,6 @@ config ARM_ERRATA_720789
 	  tables. The workaround changes the TLB flushing routines to invalidate
 	  entries regardless of the ASID.
 
-config PL310_ERRATA_727915
-	bool "PL310 errata: Background Clean & Invalidate by Way operation can cause data corruption"
-	depends on CACHE_L2X0
-	help
-	  PL310 implements the Clean & Invalidate by Way L2 cache maintenance
-	  operation (offset 0x7FC). This operation runs in background so that
-	  PL310 can handle normal accesses while it is in progress. Under very
-	  rare circumstances, due to this erratum, write data can be lost when
-	  PL310 treats a cacheable write transaction during a Clean &
-	  Invalidate by Way operation.
-
 config ARM_ERRATA_743622
 	bool "ARM errata: Faulty hazard checking in the Store Buffer may lead to data corruption"
 	depends on CPU_V7
@@ -1301,21 +1277,6 @@ config ARM_ERRATA_751472
 	  operation is received by a CPU before the ICIALLUIS has completed,
 	  potentially leading to corrupted entries in the cache or TLB.
 
-config PL310_ERRATA_753970
-	bool "PL310 errata: cache sync operation may be faulty"
-	depends on CACHE_PL310
-	help
-	  This option enables the workaround for the 753970 PL310 (r3p0) erratum.
-
-	  Under some condition the effect of cache sync operation on
-	  the store buffer still remains when the operation completes.
-	  This means that the store buffer is always asked to drain and
-	  this prevents it from merging any further writes. The workaround
-	  is to replace the normal offset of cache sync operation (0x730)
-	  by another offset targeting an unmapped PL310 register 0x740.
-	  This has the same effect as the cache sync operation: store buffer
-	  drain and waiting for all buffers empty.
-
 config ARM_ERRATA_754322
 	bool "ARM errata: possible faulty MMU translations following an ASID switch"
 	depends on CPU_V7
@@ -1364,18 +1325,6 @@ config ARM_ERRATA_764369
 	  relevant cache maintenance functions and sets a specific bit
 	  in the diagnostic control register of the SCU.
 
-config PL310_ERRATA_769419
-	bool "PL310 errata: no automatic Store Buffer drain"
-	depends on CACHE_L2X0
-	help
-	  On revisions of the PL310 prior to r3p2, the Store Buffer does
-	  not automatically drain. This can cause normal, non-cacheable
-	  writes to be retained when the memory system is idle, leading
-	  to suboptimal I/O performance for drivers using coherent DMA.
-	  This option adds a write barrier to the cpu_idle loop so that,
-	  on systems with an outer cache, the store buffer is drained
-	  explicitly.
-
 config ARM_ERRATA_775420
        bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
        depends on CPU_V7
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index ca8ecdee47d8..118d691e70f5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -897,6 +897,57 @@ config CACHE_PL310
 	  This option enables optimisations for the PL310 cache
 	  controller.
 
+config PL310_ERRATA_588369
+	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
+	depends on CACHE_L2X0
+	help
+	   The PL310 L2 cache controller implements three types of Clean &
+	   Invalidate maintenance operations: by Physical Address
+	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
+	   They are architecturally defined to behave as the execution of a
+	   clean operation followed immediately by an invalidate operation,
+	   both performing to the same memory location. This functionality
+	   is not correctly implemented in PL310 as clean lines are not
+	   invalidated as a result of these operations.
+
+config PL310_ERRATA_727915
+	bool "PL310 errata: Background Clean & Invalidate by Way operation can cause data corruption"
+	depends on CACHE_L2X0
+	help
+	  PL310 implements the Clean & Invalidate by Way L2 cache maintenance
+	  operation (offset 0x7FC). This operation runs in background so that
+	  PL310 can handle normal accesses while it is in progress. Under very
+	  rare circumstances, due to this erratum, write data can be lost when
+	  PL310 treats a cacheable write transaction during a Clean &
+	  Invalidate by Way operation.
+
+config PL310_ERRATA_753970
+	bool "PL310 errata: cache sync operation may be faulty"
+	depends on CACHE_PL310
+	help
+	  This option enables the workaround for the 753970 PL310 (r3p0) erratum.
+
+	  Under some condition the effect of cache sync operation on
+	  the store buffer still remains when the operation completes.
+	  This means that the store buffer is always asked to drain and
+	  this prevents it from merging any further writes. The workaround
+	  is to replace the normal offset of cache sync operation (0x730)
+	  by another offset targeting an unmapped PL310 register 0x740.
+	  This has the same effect as the cache sync operation: store buffer
+	  drain and waiting for all buffers empty.
+
+config PL310_ERRATA_769419
+	bool "PL310 errata: no automatic Store Buffer drain"
+	depends on CACHE_L2X0
+	help
+	  On revisions of the PL310 prior to r3p2, the Store Buffer does
+	  not automatically drain. This can cause normal, non-cacheable
+	  writes to be retained when the memory system is idle, leading
+	  to suboptimal I/O performance for drivers using coherent DMA.
+	  This option adds a write barrier to the cpu_idle loop so that,
+	  on systems with an outer cache, the store buffer is drained
+	  explicitly.
+
 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
 	depends on (ARCH_DOVE || ARCH_MMP || CPU_PJ4)
-- 
1.8.3.1

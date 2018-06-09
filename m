From: bernd.edlinger@hotmail.de (Bernd Edlinger)
Date: Sat, 9 Jun 2018 17:44:57 +0000
Subject: [PATCH] Add a configure option ARM_ERRATA_WFE_BROKEN
Message-ID: <AM5PR0701MB265786ADF69742D6B139378CE47A0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This works around problems with Altera Cyclone5 Devices. See
https://bugzilla.kernel.org/show_bug.cgi?id=111951

I just wanted to let you know that we use this patch since more than
two years now and the problem never repeated for us.

There is one possibly related observation with
CONFIG_PL310_ERRATA_769419 which was always enabled, although it
should be unnecessary according to the comment in
arch/arm/mm/cache-l2x0.c:
  * 769419: PL310 R0P0->R3P1, fixed R3P2.
  *      Affects: store buffer
  *      store buffer is not automatically drained.

This erratum should not be needed as we use R3P3, but when this
was disabled a kind of dead-lock happened after some time.

It might be connected to this problem since ERRATA_769419 injects
a wmb in the arch_cpu_idle_enter which is one of the last actions
before the wfi instruction which happens in the idle function.

So the current working theory is the cache might freeze before
all data is written out.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
  arch/arm/Kconfig                | 7 +++++++
  arch/arm/include/asm/spinlock.h | 7 +++++++
  2 files changed, 14 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f..f96af3b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1215,6 +1215,13 @@ config ARM_ERRATA_852423
  	  config option from the A12 erratum due to the way errata are checked
  	  for and handled.

+config ARM_ERRATA_WFE_BROKEN
+	bool "ARM errata: wfe broken"
+	depends on CPU_V7 && SMP
+	help
+	  This option disables the wfe instruction for raw_spin_locks.
+	  At least some CycloneV SoC devices wait much too long in wfe.
+
  endmenu

  source "arch/arm/common/Kconfig"
diff --git a/arch/arm/include/asm/spinlock.h 
b/arch/arm/include/asm/spinlock.h
index 099c78f..7efc431 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -10,6 +10,12 @@
  #include <asm/barrier.h>
  #include <asm/processor.h>

+#ifdef CONFIG_ARM_ERRATA_WFE_BROKEN
+#undef wfe
+#define wfe()
+#define WFE(x)
+#define dsb_sev()
+#else
  /*
   * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have 
the K
   * extensions, so when running on UP, we have to patch these 
instructions away.
@@ -44,6 +50,7 @@ static inline void dsb_sev(void)
  	dsb(ishst);
  	__asm__(SEV);
  }
+#endif

  /*
   * ARMv6 ticket-based spin-locking.
-- 
2.7.4

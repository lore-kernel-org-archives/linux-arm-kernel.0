From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 20 Jan 2017 17:32:30 +0100
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also on UP
Message-ID: <20170120163230.9357-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few systems have deeper idle states where the local timer tick
stops to fire, that rely on the GENERIC_CLOCKEVENTS_BROADCAST
infrastructure to switch to a global (non-stopping) clockevent device.
This is also true on UP systems, so select GENERIC_CLOCKEVENTS_BROADCAST
unconditionally.

Instead only select ARCH_HAS_TICK_BROADCAST if SMP is present, as this
is only implemented for SMP systems.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: Only select GENERIC_CLOCKEVENTS_BROADCAST if the architecture
    supports GENERIC_CLOCKEVENTS.
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5fab553fd03a..f4b7432554e2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,7 +4,7 @@ config ARM
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST && SMP
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
@@ -20,7 +20,7 @@ config ARM
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
-	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CLOCKEVENTS_BROADCAST if GENERIC_CLOCKEVENTS
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
-- 
2.11.0

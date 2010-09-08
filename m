From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 8 Sep 2010 11:22:12 +1000
Subject: [PATCH] arm: fix use of clock disable on idle for simple AT91 devices
Message-ID: <201009080122.o881MCXi015409@goober.internal.moreton.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Not all types of AT91 device have the PMC hardware unit. Don't do a
clock disable at idle on those family members that don't have it.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-at91/include/mach/system.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index c80e090..0bc497f 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -28,7 +28,7 @@
 
 static inline void arch_idle(void)
 {
-#ifndef CONFIG_DEBUG_KERNEL
+#if defined(AT91_PMC) && !defined(CONFIG_DEBUG_KERNEL)
 	/*
 	 * Disable the processor clock.  The processor will be automatically
 	 * re-enabled by an interrupt or by a reset.

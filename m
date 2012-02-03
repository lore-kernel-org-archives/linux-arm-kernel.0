From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:16:32 +0000
Subject: [PATCH 3/3] ARM: sa11x0: fix section mismatch warnings
In-Reply-To: <20120203191528.GE14129@n2100.arm.linux.org.uk>
References: <20120203191528.GE14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOca-0005gP-HG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neponset calls sa1110_mb_disable() from __devinit code, but
sa1110_mb_disable() is marked __init, and so causes a section
mismatch warning.

As sa1110_mb_enable() and sa1110_mb_disable() need to be callable
from suspend/resume paths as well, they must not be marked __init
or __devinit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c       |    2 +-
 arch/arm/mach-sa1100/generic.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 61691cd..bf508a7 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -87,7 +87,7 @@
 #define IRQ_S0_BVD1_STSCHG	(53)
 #define IRQ_S1_BVD1_STSCHG	(54)
 
-extern void __init sa1110_mb_enable(void);
+extern void sa1110_mb_enable(void);
 
 /*
  * We keep the following data for the overall SA1111.  Note that the
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index bb10ee2..0e356bb 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -428,7 +428,7 @@ void __init sa1100_map_io(void)
  * the MBGNT signal false to ensure the SA1111 doesn't own the
  * SDRAM bus.
  */
-void __init sa1110_mb_disable(void)
+void sa1110_mb_disable(void)
 {
 	unsigned long flags;
 
@@ -447,7 +447,7 @@ void __init sa1110_mb_disable(void)
  * If the system is going to use the SA-1111 DMA engines, set up
  * the memory bus request/grant pins.
  */
-void __devinit sa1110_mb_enable(void)
+void sa1110_mb_enable(void)
 {
 	unsigned long flags;
 
-- 
1.7.4.4

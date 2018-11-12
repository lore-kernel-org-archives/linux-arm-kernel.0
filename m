From: fthain@telegraphics.com.au (Finn Thain)
Date: Mon, 12 Nov 2018 15:12:39 +1100
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <cover.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
Message-ID: <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementations of arch_gettimeoffset are generally not re-entrant
and assume that interrupts have been disabled. Unfortunately this
pre-condition got broken in v2.6.32.

Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/arm/mach-ebsa110/core.c | 5 +++++
 arch/arm/mach-rpc/time.c     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index 688e5fed49a7..479f89a1accf 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -160,12 +160,17 @@ static void __init ebsa110_init_early(void)
  */
 static u32 ebsa110_gettimeoffset(void)
 {
+	unsigned long flags;
 	unsigned long offset, count;
 
+	local_irq_save(flags);
+
 	__raw_writeb(0x40, PIT_CTRL);
 	count = __raw_readb(PIT_T1);
 	count |= __raw_readb(PIT_T1) << 8;
 
+	local_irq_restore(flags);
+
 	/*
 	 * If count > COUNT, make the number negative.
 	 */
diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index 2689771c1d38..852bb3801638 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -29,9 +29,12 @@
 
 static u32 ioc_timer_gettimeoffset(void)
 {
+	unsigned long flags;
 	unsigned int count1, count2, status;
 	long offset;
 
+	local_irq_save(flags);
+
 	ioc_writeb (0, IOC_T0LATCH);
 	barrier ();
 	count1 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
@@ -42,6 +45,8 @@ static u32 ioc_timer_gettimeoffset(void)
 	barrier ();
 	count2 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
 
+	local_irq_restore(flags);
+
 	offset = count2;
 	if (count2 < count1) {
 		/*
-- 
2.18.1

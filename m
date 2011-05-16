From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:26:54 +0100
Subject: [PATCH 04/19] ARM: omap1: convert to using readl/writel instead of
	volatile struct
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/time.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index e2c29b4..e7ab616 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -68,49 +68,50 @@ typedef struct {
 } omap_mpu_timer_regs_t;
 
 #define omap_mpu_timer_base(n)							\
-((volatile omap_mpu_timer_regs_t*)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
+((omap_mpu_timer_regs_t __iomem *)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
 				 (n)*OMAP_MPU_TIMER_OFFSET))
 
 static inline unsigned long notrace omap_mpu_timer_read(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
-	return timer->read_tim;
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
+	return readl(&timer->read_tim);
 }
 
 static inline void omap_mpu_set_autoreset(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
 
-	timer->cntl = timer->cntl | MPU_TIMER_AR;
+	writel(readl(&timer->cntl) | MPU_TIMER_AR, &timer->cntl);
 }
 
 static inline void omap_mpu_remove_autoreset(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
 
-	timer->cntl = timer->cntl & ~MPU_TIMER_AR;
+	writel(readl(&timer->cntl) & ~MPU_TIMER_AR, &timer->cntl);
 }
 
 static inline void omap_mpu_timer_start(int nr, unsigned long load_val,
 					int autoreset)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
-	unsigned int timerflags = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_ST);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
+	unsigned int timerflags = MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_ST;
 
-	if (autoreset) timerflags |= MPU_TIMER_AR;
+	if (autoreset)
+		timerflags |= MPU_TIMER_AR;
 
-	timer->cntl = MPU_TIMER_CLOCK_ENABLE;
+	writel(MPU_TIMER_CLOCK_ENABLE, &timer->cntl);
 	udelay(1);
-	timer->load_tim = load_val;
+	writel(load_val, &timer->load_tim);
         udelay(1);
-	timer->cntl = timerflags;
+	writel(timerflags, &timer->cntl);
 }
 
 static inline void omap_mpu_timer_stop(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
 
-	timer->cntl &= ~MPU_TIMER_ST;
+	writel(readl(&timer->cntl) & ~MPU_TIMER_ST, &timer->cntl);
 }
 
 /*
-- 
1.7.4.4

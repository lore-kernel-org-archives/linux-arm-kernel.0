From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Wed, 18 May 2011 11:01:09 -0700
Subject: [PATCH] ARM: bcmring: Add clkdev table in init_early
In-Reply-To: <20110518154641.GK5913@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
	<4DD2FF02.1020508@broadcom.com>
	<20110517232015.GC5913@n2100.arm.linux.org.uk>
	<4DD307E2.7010302@broadcom.com>
	<20110518154641.GK5913@n2100.arm.linux.org.uk>
Message-ID: <4DD40965.9020202@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: bcmring: Move adding clkdev to init_early to make sure clkevent 
based on sp804 is initialized properly.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
  arch/arm/mach-bcmring/arch.c |    1 +
  arch/arm/mach-bcmring/core.c |    7 +++++--
  arch/arm/mach-bcmring/core.h |    1 +
  3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index 73eb066..a604b9e 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -169,6 +169,7 @@ MACHINE_START(BCMRING, "BCMRING")
  	/* Maintainer: Broadcom Corporation */
  	.fixup = bcmring_fixup,
  	.map_io = bcmring_map_io,
+	.init_early = bcmring_init_early,
  	.init_irq = bcmring_init_irq,
  	.timer = &bcmring_timer,
  	.init_machine = bcmring_init_machine
diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 299c275..430da12 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -230,8 +230,6 @@ void __init bcmring_init_timer(void)
  	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
  	writel(0, TIMER3_VA_BASE + TIMER_CTRL);

-        clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
  	/*
  	 * Make irqs happen for the system timer
  	 */
@@ -243,3 +241,8 @@ void __init bcmring_init_timer(void)
  struct sys_timer bcmring_timer = {
  	.init = bcmring_init_timer,
  };
+
+void __init bcmring_init_early(void)
+{
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+}
diff --git a/arch/arm/mach-bcmring/core.h b/arch/arm/mach-bcmring/core.h
index b197ba4..e0e02c4 100644
--- a/arch/arm/mach-bcmring/core.h
+++ b/arch/arm/mach-bcmring/core.h
@@ -25,6 +25,7 @@
  void __init bcmring_amba_init(void);
  void __init bcmring_map_io(void);
  void __init bcmring_init_irq(void);
+void __init bcmring_init_early(void);

  extern struct sys_timer bcmring_timer;
  #endif
-- 
1.7.4.1

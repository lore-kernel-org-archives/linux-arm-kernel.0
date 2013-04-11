From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Apr 2013 17:15:01 +0900
Subject: [PATCH 2/2] ARM: shmobile: force enable of r8a7790 arch timer
In-Reply-To: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
References: <1365668101-21723-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365668101-21723-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Implement a SoC-specific timer init function for
r8a7790 that makes sure the architected timer
is started regardless of boot loader setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx at renesas.com
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 9bd6f5c..2e919e6 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -4,5 +4,6 @@
 void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
+void r8a7790_timer_init(void);
 
 #endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index cfccf6c..49de2d5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -118,6 +118,18 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_irqc(0);
 }
 
+void __init r8a7790_timer_init(void)
+{
+	void __iomem *cntcr;
+
+	/* make sure arch timer is started by setting bit 0 of CNTCT */
+	cntcr = ioremap(0xe6080000, PAGE_SIZE);
+	iowrite32(1, cntcr);
+	iounmap(cntcr);
+
+	shmobile_timer_init();
+}
+
 #ifdef CONFIG_USE_OF
 void __init r8a7790_add_standard_devices_dt(void)
 {
@@ -132,7 +144,7 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a7790_add_standard_devices_dt,
-	.init_time	= shmobile_timer_init,
+	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.7.10.4

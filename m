From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 21 Oct 2009 20:29:43 +0200
Subject: [PATCH] ARM: NX3: do not reference mxc_iomux_v3_init() for
	!CONFIG_ARCH_MX35
Message-ID: <1256149783-16789-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent kernels for mx31 fail to link due to an undefined reference to
mxc_iomux_v3_init().

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mm.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index ad5a112..c8acd60 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -81,6 +81,12 @@ void __init mx31_map_io(void)
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
+void __init mx31_init_irq(void)
+{
+	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
+}
+
+#ifdef CONFIG_ARCH_MX35
 void __init mx35_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX35);
@@ -90,15 +96,11 @@ void __init mx35_map_io(void)
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
-void __init mx31_init_irq(void)
-{
-	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
-}
-
 void __init mx35_init_irq(void)
 {
 	mx31_init_irq();
 }
+#endif
 
 #ifdef CONFIG_CACHE_L2X0
 static int mxc_init_l2x0(void)
-- 
1.6.5

From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 5 Oct 2009 10:00:58 +0200 (CEST)
Subject: [PATCH] fix compilation of i.MX31 platforms
Message-ID: <Pine.LNX.4.64.0910050945480.4337@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxc_iomux_v3_init() is defined in arch/arm/plat-mxc/iomux-v3.c, which is 
not linked for i.MX31 and produces an undefined reference error. Fix this 
by building the offending code only for i.MX35.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

2.6.32-rc1 (and, AFAICS, all current trees) don't build for i.MX31. 
Disliking #ifdef's as much as you do, this is not the best fix. A nicer 
one would be defining a dummy mxc_iomux_v3_init() inline in 
arch/arm/plat-mxc/include/mach/iomux-v3.h, but this would waste a couple 
of bytes in arch/arm/mach-mx3/mm.o for the unneeded mx35_map_io(). Either 
way is fine with me, shoose whichever you prefer.

diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index ad5a112..bedf5b8 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -81,6 +81,7 @@ void __init mx31_map_io(void)
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
+#ifdef CONFIG_ARCH_MX35
 void __init mx35_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX35);
@@ -89,6 +90,7 @@ void __init mx35_map_io(void)
 
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
+#endif
 
 void __init mx31_init_irq(void)
 {

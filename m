From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:56 +0900
Subject: [PATCH 12/14] ARM: shmobile: r8a7778: split r8a7778_init_irq_extpin()
 for DT
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <2238577b2c91587daf5f87ce414ef5b3703f81af.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7778 INTC needs IRL pin mode settings to determine
behavior of IRQ0 - IRQ3, and r8a7778_init_irq_extpin()
is controlling it via irlm parameter.
But this function registers renesas_intc_irqpin driver
if irlm was set, and this value depends on platform.
This is not good for DT.
This patch splits r8a7778_init_irq_extpin() function
into "mode settings" and "funtion register" parts.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h | 1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 1d6fe97..dbe221a 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -41,6 +41,7 @@ extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
+extern void r8a7778_init_irq_extpin_dt(int irlm);
 extern void r8a7778_pinmux_init(void);
 
 extern int r8a7778_usb_phy_power(bool enable);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index fa1b7e4..16d49aa 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -476,7 +476,7 @@ static struct resource irqpin_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x3e)), /* IRQ3 */
 };
 
-void __init r8a7778_init_irq_extpin(int irlm)
+void __init r8a7778_init_irq_extpin_dt(int irlm)
 {
 	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
 	unsigned long tmp;
@@ -494,7 +494,11 @@ void __init r8a7778_init_irq_extpin(int irlm)
 	tmp |= (1 << 21); /* LVLMODE = 1 */
 	iowrite32(tmp, icr0);
 	iounmap(icr0);
+}
 
+void __init r8a7778_init_irq_extpin(int irlm)
+{
+	r8a7778_init_irq_extpin_dt(irlm);
 	if (irlm)
 		platform_device_register_resndata(
 			&platform_bus, "renesas_intc_irqpin", -1,
-- 
1.8.4

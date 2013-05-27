From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:30 +0900
Subject: [PATCH 6/9] ARM: shmobile: r8a7778: Register PFC device
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1a517e2..06da4d3 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -37,6 +37,7 @@ config ARCH_R8A7740
 
 config ARCH_R8A7778
 	bool "R-Car M1 (R8A77780)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 951149e..68053fc 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -28,5 +28,6 @@ extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
+extern void r8a7778_pinmux_init(void);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 45f0e45..d82954b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -102,6 +102,19 @@ void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
 					  pdata, sizeof(*pdata));
 }
 
+/* PFC */
+static struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xfffc0000, 0x118),
+};
+
+void __init r8a7778_pinmux_init(void)
+{
+	platform_device_register_simple(
+		"pfc-r8a7778", -1,
+		pfc_resources,
+		ARRAY_SIZE(pfc_resources));
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.10.4

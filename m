From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:32 +0900
Subject: [PATCH 8/9] ARM: shmobile: r8a7778: Register SDHI device
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds SDHI register function which needs id number (= 0/1/2)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 68053fc..ae65b45 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -18,6 +18,7 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 
 extern void r8a7778_add_standard_devices(void);
@@ -29,5 +30,6 @@ extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
+extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d82954b..4c32784 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -115,6 +115,30 @@ void __init r8a7778_pinmux_init(void)
 		ARRAY_SIZE(pfc_resources));
 }
 
+/* SDHI */
+static struct resource sdhi_resources[] = {
+	/* SDHI0 */
+	DEFINE_RES_MEM(0xFFE4C000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x77)),
+	/* SDHI1 */
+	DEFINE_RES_MEM(0xFFE4D000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x78)),
+	/* SDHI2 */
+	DEFINE_RES_MEM(0xFFE4F000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x76)),
+};
+
+void __init r8a7778_sdhi_init(int id,
+			      struct sh_mobile_sdhi_info *info)
+{
+	BUG_ON(id < 0 || id > 2);
+
+	platform_device_register_resndata(
+		&platform_bus, "sh_mobile_sdhi", id,
+		sdhi_resources + (2 * id), 2,
+		info, sizeof(*info));
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.10.4

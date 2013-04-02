From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 01 Apr 2013 21:19:17 -0700 (PDT)
Subject: [PATCH 1/5 v3] ARM: shmobile: r8a7778: remove pointless
 PLATFORM_INFO()
In-Reply-To: <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87r4it5zum.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove pointless PLATFORM_INFO() macro from setup-r8a7778,
and, used original platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 arch/arm/mach-shmobile/setup-r8a7778.c |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 01c62be..57d6b0e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -78,21 +78,13 @@ static struct sh_timer_config sh_tmu1_platform_data = {
 	.clocksource_rating	= 200,
 };
 
-#define PLATFORM_INFO(n, i)					\
-{								\
-	.parent		= &platform_bus,			\
-	.name		= #n,					\
-	.id		= i,					\
-	.res		= n ## i ## _resources,			\
-	.num_res	= ARRAY_SIZE(n ## i ##_resources),	\
-	.data		= &n ## i ##_platform_data,		\
-	.size_data	= sizeof(n ## i ## _platform_data),	\
-}
-
-struct platform_device_info platform_devinfo[] = {
-	PLATFORM_INFO(sh_tmu, 0),
-	PLATFORM_INFO(sh_tmu, 1),
-};
+#define r8a7778_register_tmu(idx)			\
+	platform_device_register_resndata(		\
+		&platform_bus, "sh_tmu", idx,		\
+		sh_tmu##idx##_resources,		\
+		ARRAY_SIZE(sh_tmu##idx##_resources),	\
+		&sh_tmu##idx##_platform_data,		\
+		sizeof(sh_tmu##idx##_platform_data))
 
 void __init r8a7778_add_standard_devices(void)
 {
@@ -114,8 +106,8 @@ void __init r8a7778_add_standard_devices(void)
 					      &scif_platform_data[i],
 					      sizeof(struct plat_sci_port));
 
-	for (i = 0; i < ARRAY_SIZE(platform_devinfo); i++)
-		platform_device_register_full(&platform_devinfo[i]);
+	r8a7778_register_tmu(0);
+	r8a7778_register_tmu(1);
 }
 
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
-- 
1.7.9.5

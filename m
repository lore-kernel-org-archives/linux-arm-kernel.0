From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 22 Mar 2013 00:14:42 -0700 (PDT)
Subject: [RFC][PATCH 1/3] ARM: shmobile: define PLATFORM_xxx_INFO()
In-Reply-To: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87y5dfewip.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_device_register_xxx() are needed until
DT supports of all drivers are completed.
This PLATFORM_xxx_INFO() macro is useful for it
and is possible to reduce code.
This patch put it ot common.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |   20 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7778.c       |   48 +++++++++++---------------
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 03f73de..6a066a3 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -94,4 +94,24 @@ static inline void __init shmobile_init_late(void)
 	shmobile_cpuidle_init();
 }
 
+#define PLATFORM_FULL_INFO(n, i, m)			\
+{							\
+	.parent		= &platform_bus,		\
+	.name		= n,				\
+	.id		= i,				\
+	.res		= m ## _resources,		\
+	.num_res	= ARRAY_SIZE(m ##_resources),	\
+	.data		= &m ##_platform_data,		\
+	.size_data	= sizeof(m ## _platform_data),	\
+}
+
+#define PLATFORM_DATA_INFO(n, i, m)			\
+{							\
+	.parent		= &platform_bus,		\
+	.name		= n,				\
+	.id		= i,				\
+	.data		= &m ##_platform_data,		\
+	.size_data	= sizeof(m ## _platform_data),	\
+}
+
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 01c62be..45a1a53 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -44,14 +44,18 @@
 	.irqs		= SCIx_IRQ_MUXED(irq),			\
 }
 
-static struct plat_sci_port scif_platform_data[] = {
-	SCIF_INFO(0xffe40000, gic_iid(0x66)),
-	SCIF_INFO(0xffe41000, gic_iid(0x67)),
-	SCIF_INFO(0xffe42000, gic_iid(0x68)),
-	SCIF_INFO(0xffe43000, gic_iid(0x69)),
-	SCIF_INFO(0xffe44000, gic_iid(0x6a)),
-	SCIF_INFO(0xffe45000, gic_iid(0x6b)),
-};
+static struct plat_sci_port scif0_platform_data =
+	SCIF_INFO(0xffe40000, gic_iid(0x66));
+static struct plat_sci_port scif1_platform_data =
+	SCIF_INFO(0xffe41000, gic_iid(0x67));
+static struct plat_sci_port scif2_platform_data =
+	SCIF_INFO(0xffe42000, gic_iid(0x68));
+static struct plat_sci_port scif3_platform_data =
+	SCIF_INFO(0xffe43000, gic_iid(0x69));
+static struct plat_sci_port scif4_platform_data =
+	SCIF_INFO(0xffe44000, gic_iid(0x6a));
+static struct plat_sci_port scif5_platform_data =
+	SCIF_INFO(0xffe45000, gic_iid(0x6b));
 
 /* TMU */
 static struct resource sh_tmu0_resources[] = {
@@ -78,20 +82,15 @@ static struct sh_timer_config sh_tmu1_platform_data = {
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
+static struct platform_device_info platform_devinfo[] = {
+	PLATFORM_DATA_INFO("sh-sci", 0, scif0),
+	PLATFORM_DATA_INFO("sh-sci", 1, scif1),
+	PLATFORM_DATA_INFO("sh-sci", 2, scif2),
+	PLATFORM_DATA_INFO("sh-sci", 3, scif3),
+	PLATFORM_DATA_INFO("sh-sci", 4, scif4),
+	PLATFORM_DATA_INFO("sh-sci", 5, scif5),
+	PLATFORM_FULL_INFO("sh_tmu", 0, sh_tmu0),
+	PLATFORM_FULL_INFO("sh_tmu", 1, sh_tmu1),
 };
 
 void __init r8a7778_add_standard_devices(void)
@@ -109,11 +108,6 @@ void __init r8a7778_add_standard_devices(void)
 	}
 #endif
 
-	for (i = 0; i < ARRAY_SIZE(scif_platform_data); i++)
-		platform_device_register_data(&platform_bus, "sh-sci", i,
-					      &scif_platform_data[i],
-					      sizeof(struct plat_sci_port));
-
 	for (i = 0; i < ARRAY_SIZE(platform_devinfo); i++)
 		platform_device_register_full(&platform_devinfo[i]);
 }
-- 
1.7.9.5

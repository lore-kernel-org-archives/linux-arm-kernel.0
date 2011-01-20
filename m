From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:22 +0530
Subject: [PATCH V5 44/63] SPEAr1310: Adding Static Mapping for RAS Area
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <b35308e67a282c612aec29937908b25519a4ff0e.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds static mapping for RAS area in SPEAr1310.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1310.c            |   17 +++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c        |    2 +-
 3 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 6b249b5..20a7fb4 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -68,6 +68,7 @@ extern struct platform_device spear1310_can1_device;
 
 /* Add spear1310 machine function declarations here */
 void __init spear1310_init(void);
+void __init spear1310_map_io(void);
 
 #endif /* CONFIG_MACH_SPEAR1310 */
 
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 561f68b..9e2036d 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -55,6 +55,23 @@ struct platform_device spear1310_can1_device = {
 	.resource = can1_resources,
 };
 
+/* Following will create 1310 specific static virtual/physical mappings */
+struct map_desc spear1310_io_desc[] __initdata = {
+	{
+		.virtual	= IO_ADDRESS(SPEAR1310_RAS_BASE),
+		.pfn		= __phys_to_pfn(SPEAR1310_RAS_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear1310_map_io(void)
+{
+	spear13xx_map_io();
+	iotable_init(spear1310_io_desc, ARRAY_SIZE(spear1310_io_desc));
+}
+
 void __init spear1310_init(void)
 {
 	/* call spear13xx family common init function */
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 0f861c5..933e869 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -126,7 +126,7 @@ static void __init spear1310_evb_init(void)
 
 MACHINE_START(SPEAR1310, "ST-SPEAR1310-EVB")
 	.boot_params	=	0x00000100,
-	.map_io		=	spear13xx_map_io,
+	.map_io		=	spear1310_map_io,
 	.init_irq	=	spear13xx_init_irq,
 	.timer		=	&spear13xx_timer,
 	.init_machine	=	spear1310_evb_init,
-- 
1.7.3.4

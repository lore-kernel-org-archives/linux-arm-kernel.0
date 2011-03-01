From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:35 +0530
Subject: [PATCH V6 02/11] ST SPEAr clock: Define common clk_init routine in
	plat/clock.c
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <03e1caef6dfeea7448165f7845a9d7111baf86f7.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define common clk_init routine in plat/clock.c for calling recalc_root_clocks.
This routine will be used for any common code across all machine families.
Whereas family specific spear*xx_clk_init routines will be used for family
specific code.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c                |    4 ++--
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c             |    2 +-
 arch/arm/mach-spear6xx/clock.c                |    4 ++--
 arch/arm/mach-spear6xx/include/mach/generic.h |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c             |    2 +-
 arch/arm/plat-spear/clock.c                   |    5 +++++
 arch/arm/plat-spear/include/plat/clock.h      |    1 +
 8 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 98bc7ed..5707772 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -732,12 +732,12 @@ static struct clk_lookup spear_clk_lookups[] = {
 #endif
 };
 
-void __init clk_init(void)
+void __init spear3xx_clk_init(void)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
 		clk_register(&spear_clk_lookups[i]);
 
-	recalc_root_clocks();
+	clk_init();
 }
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 33e04fe..4772507 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -36,7 +36,7 @@ extern struct amba_device uart_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
-void __init clk_init(void);
+void __init spear3xx_clk_init(void);
 void __init spear_setup_timer(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_init_irq(void);
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index b7a83b2..9a9e92b 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -97,7 +97,7 @@ void __init spear3xx_map_io(void)
 	iotable_init(spear3xx_io_desc, ARRAY_SIZE(spear3xx_io_desc));
 
 	/* This will initialize clock framework */
-	clk_init();
+	spear3xx_clk_init();
 }
 
 /* pad multiplexing support */
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 88b748b..ac70e0d 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -671,12 +671,12 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "gpio2",		.clk = &gpio2_clk},
 };
 
-void __init clk_init(void)
+void __init spear6xx_clk_init(void)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
 		clk_register(&spear_clk_lookups[i]);
 
-	recalc_root_clocks();
+	clk_init();
 }
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 94cf4a6..183f023 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -39,7 +39,7 @@ void __init spear6xx_map_io(void);
 void __init spear6xx_init_irq(void);
 void __init spear6xx_init(void);
 void __init spear600_init(void);
-void __init clk_init(void);
+void __init spear6xx_clk_init(void);
 
 /* Add spear600 machine device structure declarations here */
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 9818129..e0f6628 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -148,7 +148,7 @@ void __init spear6xx_map_io(void)
 	iotable_init(spear6xx_io_desc, ARRAY_SIZE(spear6xx_io_desc));
 
 	/* This will initialize clock framework */
-	clk_init();
+	spear6xx_clk_init();
 }
 
 static void __init spear6xx_timer_init(void)
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index bdbd7ec..6fa474c 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -903,6 +903,11 @@ void recalc_root_clocks(void)
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
+void __init clk_init(void)
+{
+	recalc_root_clocks();
+}
+
 #ifdef CONFIG_DEBUG_FS
 /*
  *	debugfs support to trace clock tree hierarchy and attributes
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 2ae6606..e4cc787 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -224,6 +224,7 @@ struct clcd_rate_tbl {
 };
 
 /* platform specific clock functions */
+void __init clk_init(void);
 void clk_register(struct clk_lookup *cl);
 void recalc_root_clocks(void);
 
-- 
1.7.2.2

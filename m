From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:42:20 +0530
Subject: [PATCH V4 53/62] SPEAr3xx: Rework KConfig to allow all boards to be
	compiled in
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <96f8d82b86df788b627c5248b250e5c413487ed4.1295333959.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Now that all three SPEAr3xx platforms can be built into one kernel,
rework KConfig to allow this. Move everything into one KConfig file
while we are here.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/Kconfig                |   30 ++++++++++++++++--------
 arch/arm/mach-spear3xx/Kconfig300             |   17 --------------
 arch/arm/mach-spear3xx/Kconfig310             |   17 --------------
 arch/arm/mach-spear3xx/Kconfig320             |   17 --------------
 arch/arm/mach-spear3xx/include/mach/generic.h |    6 +++-
 5 files changed, 24 insertions(+), 63 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig300
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig310
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig320

diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
index 20d1317..2cee6b0 100644
--- a/arch/arm/mach-spear3xx/Kconfig
+++ b/arch/arm/mach-spear3xx/Kconfig
@@ -4,9 +4,26 @@
 
 if ARCH_SPEAR3XX
 
-choice
-	prompt "SPEAr3XX Family"
-	default MACH_SPEAR300
+menu "SPEAr3xx Implementations"
+config BOARD_SPEAR300_EVB
+	bool "SPEAr300 Evaluation Board"
+	select MACH_SPEAR300
+	help
+	  Supports ST SPEAr300 Evaluation Board
+
+config BOARD_SPEAR310_EVB
+	bool "SPEAr310 Evaluation Board"
+	select MACH_SPEAR310
+	help
+	  Supports ST SPEAr310 Evaluation Board
+
+config BOARD_SPEAR320_EVB
+	bool "SPEAr320 Evaluation Board"
+	select MACH_SPEAR320
+	help
+	  Supports ST SPEAr320 Evaluation Board
+
+endmenu
 
 config MACH_SPEAR300
 	bool "SPEAr300"
@@ -23,11 +40,4 @@ config MACH_SPEAR320
 	help
 	  Supports ST SPEAr320 Machine
 
-endchoice
-
-# Adding SPEAr3XX machine specific configuration files
-source "arch/arm/mach-spear3xx/Kconfig300"
-source "arch/arm/mach-spear3xx/Kconfig310"
-source "arch/arm/mach-spear3xx/Kconfig320"
-
 endif #ARCH_SPEAR3XX
diff --git a/arch/arm/mach-spear3xx/Kconfig300 b/arch/arm/mach-spear3xx/Kconfig300
deleted file mode 100644
index c519a05..0000000
--- a/arch/arm/mach-spear3xx/Kconfig300
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr300 machine configuration file
-#
-
-if MACH_SPEAR300
-
-choice
-	prompt "SPEAr300 Boards"
-	default BOARD_SPEAR300_EVB
-
-config BOARD_SPEAR300_EVB
-	bool "SPEAr300 Evaluation Board"
-	help
-	  Supports ST SPEAr300 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR300
diff --git a/arch/arm/mach-spear3xx/Kconfig310 b/arch/arm/mach-spear3xx/Kconfig310
deleted file mode 100644
index 60e7442..0000000
--- a/arch/arm/mach-spear3xx/Kconfig310
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr310 machine configuration file
-#
-
-if MACH_SPEAR310
-
-choice
-	prompt "SPEAr310 Boards"
-	default BOARD_SPEAR310_EVB
-
-config BOARD_SPEAR310_EVB
-	bool "SPEAr310 Evaluation Board"
-	help
-	  Supports ST SPEAr310 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR310
diff --git a/arch/arm/mach-spear3xx/Kconfig320 b/arch/arm/mach-spear3xx/Kconfig320
deleted file mode 100644
index 1c1d438..0000000
--- a/arch/arm/mach-spear3xx/Kconfig320
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr320 machine configuration file
-#
-
-if MACH_SPEAR320
-
-choice
-	prompt "SPEAr320 Boards"
-	default BOARD_SPEAR320_EVB
-
-config BOARD_SPEAR320_EVB
-	bool "SPEAr320 Evaluation Board"
-	help
-	  Supports ST SPEAr320 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR320
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index d250c96..3c2b189 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -160,9 +160,10 @@ void sdhci_i2s_mem_enable(u8 mask);
 
 /* Add misc structure declarations here */
 extern struct clcd_board clcd_plat_data;
+#endif
 
 /* spear310 declarations */
-#elif defined(CONFIG_MACH_SPEAR310)
+#if defined(CONFIG_MACH_SPEAR310)
 /* Add spear310 machine device structure declarations here */
 extern struct amba_device uart1_device;
 extern struct amba_device uart2_device;
@@ -187,9 +188,10 @@ extern struct pmx_dev spear310_pmx_tdm0;
 /* Add spear310 machine function declarations here */
 void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count);
+#endif
 
 /* spear320 declarations */
-#elif defined(CONFIG_MACH_SPEAR320)
+#if defined(CONFIG_MACH_SPEAR320)
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device ssp_device[];
-- 
1.7.2.2

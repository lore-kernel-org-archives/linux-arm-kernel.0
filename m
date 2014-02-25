From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 20:46:03 +0100
Subject: [PATCH RESEND] ARM: imx6: build pm-imx6q.c independently of
 CONFIG_PM
In-Reply-To: <1392690905-16839-1-git-send-email-shawn.guo@linaro.org>
References: <1392690905-16839-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201402252046.04144.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014, Shawn Guo wrote:
> When building a kernel image with only CONFIG_CPU_IDLE but no CONFIG_PM,
> we will get the following link error.
> 

I seem to need more changes on top of this, to allow building with neither
CPU_IDLE nor PM enabled. Can you verify that?

	Arnd

commit 6a434aea44d8a250f8ee2205be9bc429b140b663
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Feb 24 22:19:50 2014 +0100

    ARM: imx: more CONFIG_PM fixes
    
    This lets us build the imx code in more configurations.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index a3fcd9c..a367675 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -147,15 +147,13 @@ int imx_cpu_kill(unsigned int cpu);
 
 void imx6q_pm_init(void);
 void imx6q_pm_set_ccm_base(void __iomem *base);
-#ifdef CONFIG_PM
-void imx6_suspend(void __iomem *ocram_vbase);
 void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
+#ifdef CONFIG_PM
+void imx6_suspend(void __iomem *ocram_vbase);
 void imx5_pm_init(void);
 #else
 static inline void imx6_suspend(void __iomem *ocram_vbase) {}
-static inline void imx6dl_pm_init(void) {}
-static inline void imx6sl_pm_init(void) {}
 static inline void imx5_pm_init(void) {}
 #endif
 
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index bb69943..5fea999 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -521,10 +521,12 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 
 	WARN_ON(!ccm_base);
 
-	ret = imx6q_ocram_suspend_init(socdata);
-	if (ret)
-		pr_warn("%s: failed to initialize ocram suspend %d!\n",
-			__func__, ret);
+	if (IS_ENABLED(CONFIG_ARM_CPU_SUSPEND)) {
+		ret = imx6q_ocram_suspend_init(socdata);
+		if (ret)
+			pr_warn("%s: failed to initialize ocram suspend %d!\n",
+				__func__, ret);
+	}
 
 	/*
 	 * This is for SW workaround step #1 of ERR007265, see comments

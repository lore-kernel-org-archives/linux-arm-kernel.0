From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 09 Jun 2014 16:58:19 +0530
Subject: [PATCH] ARM: dts: remove display power domain for exynos5420
Message-ID: <1402313299-18885-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Display domain is removed due to instability issues. Explaining
the problem below:

exynos_init_late triggers the pm_genpd_poweroff_unused which
powers off the unused power domains. This call hits before
the trigger to deferred probes.

DRM DP Panel defers the probe due to supply get failure. By the
time, deferred probe is scheduled again, Display Power Domain is
powered off by pm_genpd_poweroff_unused.

FIMD and DP drivers are accessing registers during Probe and Bind
callbacks. If display domain is enabled/disabled around register
accesses, display domain gets unstable and we are getting Power
Domain Disable fail notification. Increasing the Timeout also
didn't help.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
based on Kukjin's for-next branch.

 arch/arm/boot/dts/exynos5420.dtsi |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e385322..3d528cf 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -262,11 +262,6 @@
 		reg = <0x10044060 0x20>;
 	};
 
-	disp_pd: power-domain at 100440C0 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x100440C0 0x20>;
-	};
-
 	msc_pd: power-domain at 10044120 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044120 0x20>;
@@ -518,7 +513,6 @@
 	};
 
 	fimd: fimd at 14400000 {
-		samsung,power-domain = <&disp_pd>;
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
-- 
1.7.9.5

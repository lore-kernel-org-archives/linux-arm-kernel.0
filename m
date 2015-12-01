From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 17:25:21 -0800
Subject: [PATCH v3 1/3] ARM: qcom: Make an option for qcom 'a-family' platforms
In-Reply-To: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
References: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448933123-9843-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
because they are proxy configs for selecting the right
clocksource driver and adjusting the text offset and there is no
difference between ARCH_MSM8X60 and ARCH_MSM8960 anymore.
Furthermore, there aren't configs for all the SoCs supported by
the mainline kernel, leading to confusion about which SoCs are
supported.

So, add a new config that covers all the platforms that use the
qcom clocksource driver and need the 2MB text offset adjustment
and make it def_bool y so that the defconfigs keep working
properly.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Makefile          |  3 +--
 arch/arm/mach-qcom/Kconfig | 13 +++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2c2b28ee4811..dd5799dbcf26 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -148,8 +148,7 @@ textofs-$(CONFIG_PM_H1940)      := 0x00108000
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
 endif
-textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_ARCH_QCOM_A_FAMILY) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 2256cd1e25d1..230c7e8a32fb 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -10,6 +10,19 @@ menuconfig ARCH_QCOM
 
 if ARCH_QCOM
 
+config ARCH_QCOM_A_FAMILY
+	bool "Support a-family chipsets (msm8660, msm8960, apq8064)"
+	default y
+	select CLKSRC_QCOM
+	help
+	  Select this option if you want to support a-family platforms.
+
+	  A-family includes all Snapdragon S1/S2/S3/S4 chips before 2013,
+	  up to the MSM8x60 and APQ8064 SoCs.
+
+	  B-family includes all Snapdragon 2xx/4xx/6xx/8xx models starting
+	  in 2013 with the MSM8x74 SoC.
+
 config ARCH_MSM8X60
 	bool "Enable support for MSM8X60"
 	select CLKSRC_QCOM
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

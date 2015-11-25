From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 13:04:36 -0800
Subject: [PATCH v2 1/3] ARM: qcom: Make an option for qcom clocksource
 platforms
In-Reply-To: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
References: <1448485478-21699-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448485478-21699-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
because they are mostly proxy configs for selecting the right
clocksource driver. Therefore, make a new config for platforms
that use the qcom clocksource driver. We'll also make this the
determining factor for if we should adjust the text offset by
2MB or not, because the two go hand in hand.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Makefile          | 3 +--
 arch/arm/mach-qcom/Kconfig | 8 ++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2c2b28ee4811..999d523ac09f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -148,8 +148,7 @@ textofs-$(CONFIG_PM_H1940)      := 0x00108000
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
 endif
-textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_HAVE_CLKSRC_QCOM) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 2256cd1e25d1..35a03967d9c2 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -10,6 +10,14 @@ menuconfig ARCH_QCOM
 
 if ARCH_QCOM
 
+config HAVE_CLKSRC_QCOM
+	bool "Support platforms with qcom clocksource"
+	default y
+	select CLKSRC_QCOM
+	help
+	  Select this option if you want to support platforms
+	  with the qcom clocksource such as MSM8660 and MSM8960.
+
 config ARCH_MSM8X60
 	bool "Enable support for MSM8X60"
 	select CLKSRC_QCOM
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Jan 2017 15:27:24 -0800
Subject: [PATCH 3/5] ARM: qcom: Remove SoC specific configs
In-Reply-To: <20170118232726.22876-1-sboyd@codeaurora.org>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
Message-ID: <20170118232726.22876-4-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
because they are proxy configs for selecting the right
clocksource driver and adjusting the text offset and there is no
difference between ARCH_MSM8X60 and ARCH_MSM8960 anymore.
Furthermore, there aren't configs for all the SoCs supported by
the mainline kernel, leading to confusion about which SoCs are
supported.

So just select the qcom clocksource driver all the time and rely
on users selecting HAVE_ARM_ARCH_TIMER in their defconfig for
SoCs that use the architected timer. This should simplify things.

Finally, since we're here alphabetize the select list under
ARCH_QCOM.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-qcom/Kconfig | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 46ed10a807f0..16fc13246926 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -2,29 +2,10 @@ menuconfig ARCH_QCOM
 	bool "Qualcomm Support"
 	depends on ARCH_MULTI_V7
 	select ARCH_SUPPORTS_BIG_ENDIAN
-	select ARM_GIC
 	select ARM_AMBA
+	select ARM_GIC
+	select CLKSRC_QCOM
 	select PINCTRL
 	select QCOM_SCM if SMP
 	help
 	  Support for Qualcomm's devicetree based systems.
-
-if ARCH_QCOM
-
-config ARCH_MSM8X60
-	bool "Enable support for MSM8X60"
-	select CLKSRC_QCOM
-
-config ARCH_MSM8960
-	bool "Enable support for MSM8960"
-	select CLKSRC_QCOM
-
-config ARCH_MSM8974
-	bool "Enable support for MSM8974"
-	select HAVE_ARM_ARCH_TIMER
-
-config ARCH_MDM9615
-	bool "Enable support for MDM9615"
-	select CLKSRC_QCOM
-
-endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Nov 2015 23:13:09 +0100
Subject: [PATCH] ARM: qcom: select ARM_CPU_SUSPEND for power management
Message-ID: <5497046.7sx8fEMiNf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qcom spm driver uses cpu_resume_arm(), which is not included
in the kernel in all configurations:

drivers/built-in.o: In function `qcom_cpu_spc':
:(.text+0xbc022): undefined reference to `cpu_suspend'
drivers/built-in.o: In function `qcom_cpuidle_init':
:(.init.text+0x610c): undefined reference to `cpu_resume_arm'

This adds a 'select' Kconfig statement to ensure it's always
enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This has been broken for a while but not even shown up in many thousands of
randconfig builds until today. Please queue it up for 4.5 unless you think
it should really go into 4.4 as well.

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3c6e3893b76c..461b387d03cc 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -13,6 +13,7 @@ config QCOM_GSBI
 config QCOM_PM
 	bool "Qualcomm Power Management"
 	depends on ARCH_QCOM && !ARM64
+	select ARM_CPU_SUSPEND
 	select QCOM_SCM
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power

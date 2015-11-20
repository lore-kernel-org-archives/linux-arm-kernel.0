From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 11:32:21 +0100
Subject: [PATCH v2] soc: qcom: enable smsm/smp2p modular build
Message-ID: <4169906.YsYnNqcaru@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added smp2p and smsm drivers cannot be loadable modules
but depend on smem, which can be, and that causes a link error:

drivers/built-in.o: In function `qcom_smp2p_intr':
:(.text+0xa6e68): undefined reference to `qcom_smem_get'
drivers/built-in.o: In function `qcom_smp2p_probe':
:(.text+0xa7320): undefined reference to `qcom_smem_alloc'
:(.text+0xa736c): undefined reference to `qcom_smem_get'
drivers/built-in.o: In function `qcom_smsm_probe':
:(.text+0xa7b34): undefined reference to `qcom_smem_get'

This marks all the drivers as 'tristate' to make the Kconfig
dependency resolution work properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: dbb04bd7122f ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Fixes: d7387fc6add4 ("soc: qcom: smsm: Add driver for Qualcomm SMSM")
---
v2: fixed subject line

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index b57be7ab50b6..57b7145358e7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -54,7 +54,7 @@ config QCOM_SMEM_STATE
 	bool
 
 config QCOM_SMP2P
-	bool "Qualcomm Shared Memory Point to Point support"
+	tristate "Qualcomm Shared Memory Point to Point support"
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
 	help
@@ -62,7 +62,7 @@ config QCOM_SMP2P
 	  protocol.
 
 config QCOM_SMSM
-	bool "Qualcomm Shared Memory State Machine"
+	tristate "Qualcomm Shared Memory State Machine"
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
 	help

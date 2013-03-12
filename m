From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:49 -0700
Subject: [PATCH v2 04/11] ssbi: Allow compilation as a module
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-5-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ssbi driver's read/write entry points are protected with wrappers
in the case when the driver isn't enabled.  These wrappers don't make
any sense, since a client of the SSBI bus won't work without it.  Make
these just regular functions, so that the SSBI driver can be built as
a module.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/ssbi/Kconfig     |  2 +-
 include/linux/msm_ssbi.h | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/ssbi/Kconfig b/drivers/ssbi/Kconfig
index b57c41b..c7bc534 100644
--- a/drivers/ssbi/Kconfig
+++ b/drivers/ssbi/Kconfig
@@ -5,7 +5,7 @@
 menu "Qualcomm MSM SSBI bus support"
 
 config MSM_SSBI
-	bool "Qualcomm Single-wire Serial Bus Interface (SSBI)"
+	tristate "Qualcomm Single-wire Serial Bus Interface (SSBI)"
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in SSBI interface on Qualcomm MSM family processors.
diff --git a/include/linux/msm_ssbi.h b/include/linux/msm_ssbi.h
index cfa47df..0fe245b 100644
--- a/include/linux/msm_ssbi.h
+++ b/include/linux/msm_ssbi.h
@@ -33,17 +33,6 @@ struct msm_ssbi_platform_data {
 	enum msm_ssbi_controller_type controller_type;
 };
 
-#ifdef CONFIG_MSM_SSBI
 int msm_ssbi_write(struct device *dev, u16 addr, u8 *buf, int len);
 int msm_ssbi_read(struct device *dev, u16 addr, u8 *buf, int len);
-#else
-static inline int msm_ssbi_write(struct device *dev, u16 addr, u8 *buf, int len)
-{
-	return -ENXIO;
-}
-static inline int msm_ssbi_read(struct device *dev, u16 addr, u8 *buf, int len)
-{
-	return -ENXIO;
-}
-#endif
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

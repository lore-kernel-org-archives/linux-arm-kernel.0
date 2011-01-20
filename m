From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 20 Jan 2011 12:32:45 -0800
Subject: [PATCH 7/7] msm: mahimahi: initialize mmc at start up
In-Reply-To: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1295555565-21563-8-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC should fully function at this point. This adds in the calls
to start the initialization.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/board-mahimahi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
index c1745c7..e7c70ca 100644
--- a/arch/arm/mach-msm/board-mahimahi.c
+++ b/arch/arm/mach-msm/board-mahimahi.c
@@ -38,6 +38,8 @@
 
 static uint debug_uart;
 
+int mahimahi_init_mmc(unsigned int sys_rev, unsigned debug_uart);
+
 module_param_named(debug_uart, debug_uart, uint, 0);
 
 static struct platform_device *devices[] __initdata = {
@@ -65,11 +67,17 @@ static struct msm_acpu_clock_platform_data mahimahi_cdma_clock_data = {
 
 static void __init mahimahi_init(void)
 {
+	int ret;
+
 	if (is_cdma_version(system_rev))
 		msm_acpu_clock_init(&mahimahi_cdma_clock_data);
 	else
 		msm_acpu_clock_init(&mahimahi_clock_data);
 
+	ret = mahimahi_init_mmc(system_rev, debug_uart);
+	if (ret != 0)
+		pr_crit("%s: Unable to initialize MMC\n", __func__);
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
-- 
1.7.0.4

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

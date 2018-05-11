From: yinbo.zhu@nxp.com (Yinbo Zhu)
Date: Fri, 11 May 2018 11:35:30 +0800
Subject: [PATCH 9/9] armv8: add psci 0.2 stardard support
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
Message-ID: <20180511033530.7931-9-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuantian Tang <andy.tang@nxp.com>

In current kernel, only psci v1.0 is supported. But our psci firmware
only support psci v0.2. So update psci driver to support psci v0.2.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/firmware/psci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 0bd795f..c9ed9fb 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -468,6 +468,8 @@ static void __init psci_init_system_suspend(void)
 	if (!IS_ENABLED(CONFIG_SUSPEND))
 		return;
 
+	suspend_set_ops(&psci_suspend_ops);
+
 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
 
 	if (ret != PSCI_RET_NOT_SUPPORTED)
@@ -573,6 +575,8 @@ static void __init psci_0_2_set_functions(void)
 
 	pm_power_off = psci_sys_poweroff;
 
+	psci_init_system_suspend();
+
 	suspend_set_ops(&psci_suspend_ops);
 }
 
-- 
1.7.1

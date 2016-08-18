From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Thu, 18 Aug 2016 16:52:18 +0800
Subject: [PATCH v2 1/4] nvmem: rockchip-efuse: Change initcall to subsys
In-Reply-To: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1471510341-63926-2-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

We will register a cpufreq notifier for adjusting opp's voltage, and it
need to fetch cpu's leakage from efuse in the notifier_call. so the efuse
driver should probe before cpufreq driver.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/nvmem/rockchip-efuse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 4d3f391..378993d 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -144,6 +144,13 @@ static struct platform_driver rockchip_efuse_driver = {
 	},
 };
 
-module_platform_driver(rockchip_efuse_driver);
+static int __init rockchip_efuse_module_init(void)
+{
+	return platform_driver_probe(&rockchip_efuse_driver,
+				     rockchip_efuse_probe);
+}
+
+subsys_initcall(rockchip_efuse_module_init);
+
 MODULE_DESCRIPTION("rockchip_efuse driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

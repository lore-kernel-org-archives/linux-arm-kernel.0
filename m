From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 24 Jan 2018 00:42:13 +0800
Subject: [PATCH 1/2] soc: imx: gpc: ARM power domain should be always-on
Message-ID: <1516725734-32745-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM power domain does NOT support runtime off, always-on
flag should be set to avoid incorrect power state in
pm_genpd_summary:

Before:

root at imx6qpdlsolox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
ARM                             off-0

After:

root at imx6qpdlsolox:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
ARM                             on

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 53f7275..6cafa9b 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -254,6 +254,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 	{
 		.base = {
 			.name = "ARM",
+			.flags = GENPD_FLAG_ALWAYS_ON,
 		},
 	}, {
 		.base = {
-- 
2.7.4

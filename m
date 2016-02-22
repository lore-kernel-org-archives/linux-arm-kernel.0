From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Feb 2016 09:01:53 -0300
Subject: [PATCH] bus: imx-weim: Take the 'status' property value into account 
Message-ID: <1456142513-12876-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently we have an incorrect behaviour when multiple devices
are present under the weim node. For example:

&weim {
	...
	status = "okay";
	
	sram at 0,0 {
		...
        	status = "okay";
	};

	mram at 0,0 {
		...
        	status = "disabled";
    	};
};

In this case only the 'sram' device should be probed and not 'mram'.

However what happens currently is that the status variable is ignored,
causing the 'sram' device to be disabled and 'mram' to be enabled.  

Change the weim_parse_dt() function to use
for_each_available_child_of_node()so that the devices marked with
'status = disabled' are not probed.

Cc: <stable@vger.kernel.org>
Suggested-by: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/bus/imx-weim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index e98d15e..1827fc4 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -150,7 +150,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 			return ret;
 	}
 
-	for_each_child_of_node(pdev->dev.of_node, child) {
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
 		if (!child->name)
 			continue;
 
-- 
1.9.1

From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 4 Jul 2016 17:27:01 +0800
Subject: [PATCH v2 1/1] bus: arm-cci: add missing of_node_put after calling
 of_parse_phandle
Message-ID: <1467624421-2541-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: arm at kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Changes for v2:
- Address suzuki's comments that calling of_node_put one time
  for both error and corrent code path.


 drivers/bus/arm-cci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index a49b283..648d130 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1913,9 +1913,10 @@ static int __cci_ace_get_port(struct device_node *dn, int type)
 	for (i = 0; i < nb_cci_ports; i++) {
 		ace_match = ports[i].type == type;
 		if (ace_match && cci_portn == ports[i].dn)
-			return i;
+			break;
 	}
-	return -ENODEV;
+	of_node_put(cci_portn);
+	return (i < nb_cci_ports) ? i : -ENODEV;
 }
 
 int cci_ace_get_port(struct device_node *dn)
-- 
1.9.1

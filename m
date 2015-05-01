From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  1 May 2015 18:36:26 +0100
Subject: [PATCH 1/5] bus: arm-ccn: Fix node->XP config conversion
In-Reply-To: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
References: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1430501790-26918-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Events defined as watchpoints on nodes must have their config values
converted so that they apply to the respective node's XP. The
function setting new values was using wrong mask for the "port" field,
resulting in corrupted value. Fixed now.

Cc: stable at vger.kernel.org # 3.17+
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index aaa0f2a..60397ec 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -212,7 +212,7 @@ static int arm_ccn_node_to_xp_port(int node)
 
 static void arm_ccn_pmu_config_set(u64 *config, u32 node_xp, u32 type, u32 port)
 {
-	*config &= ~((0xff << 0) | (0xff << 8) | (0xff << 24));
+	*config &= ~((0xff << 0) | (0xff << 8) | (0x3 << 24));
 	*config |= (node_xp << 0) | (type << 8) | (port << 24);
 }
 
-- 
2.1.0

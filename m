From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  1 May 2015 18:36:28 +0100
Subject: [PATCH 3/5] bus: arm-ccn: Provide required event arguments
In-Reply-To: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
References: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1430501790-26918-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 688d4dfcdd624192cbf03c08402e444d1d11f294 "perf tools: Support
parsing parameterized events" the perf userspace tools understands
"argument=?" syntax in the events file, making sure that required
arguments are provided by the user and not defaulting to 0, causing
confusion.

This patch adds the required arguments lists for CCN events.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/arm/CCN.txt |  2 +-
 drivers/bus/arm-ccn.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/CCN.txt b/Documentation/arm/CCN.txt
index 3a76048..ffca443 100644
--- a/Documentation/arm/CCN.txt
+++ b/Documentation/arm/CCN.txt
@@ -45,7 +45,7 @@ Example of perf tool use:
 / # perf list | grep ccn
   ccn/cycles/                                        [Kernel PMU event]
 <...>
-  ccn/xp_valid_flit/                                 [Kernel PMU event]
+  ccn/xp_valid_flit,xp=?,port=?,vc=?,dir=?/          [Kernel PMU event]
 <...>
 
 / # perf stat -a -e ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/ \
diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 3374dcb..572360f 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -340,6 +340,23 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
 	if (event->mask)
 		res += snprintf(buf + res, PAGE_SIZE - res, ",mask=0x%x",
 				event->mask);
+
+	/* Arguments required by an event */
+	switch (event->type) {
+	case CCN_TYPE_CYCLES:
+		break;
+	case CCN_TYPE_XP:
+		res += snprintf(buf + res, PAGE_SIZE - res,
+				",xp=?,port=?,vc=?,dir=?");
+		if (event->event == CCN_EVENT_WATCHPOINT)
+			res += snprintf(buf + res, PAGE_SIZE - res,
+					",cmp_l=?,cmp_h=?,mask=?");
+		break;
+	default:
+		res += snprintf(buf + res, PAGE_SIZE - res, ",node=?");
+		break;
+	}
+
 	res += snprintf(buf + res, PAGE_SIZE - res, "\n");
 
 	return res;
-- 
2.1.0

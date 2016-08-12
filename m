From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 12 Aug 2016 17:25:55 +0100
Subject: [PATCH 4/5] bus: arm-ccn: Correct required arguments for XP PMU events
In-Reply-To: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
References: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1471019156-5485-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

XP can provide events from two sources: watchpoints, observing traffic
on device ports and PMU looking at internal buses.

Unfortunately the sysfs definition of the PMU events was requiring
port number (instead of bus number) and direction (the buses are
unidirectional), as these fields were shared with the watchpoint event.

Although it does not introduce a major problem (port can be used as
bus alias and direction is simply ignored for XP PMU events), it's
better to fix it now, before external tools start depending on this
behaviour.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 647a27b..e7c2321 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -213,6 +213,7 @@ static int arm_ccn_node_to_xp_port(int node)
 #define CCN_CONFIG_TYPE(_config)	(((_config) >> 8) & 0xff)
 #define CCN_CONFIG_EVENT(_config)	(((_config) >> 16) & 0xff)
 #define CCN_CONFIG_PORT(_config)	(((_config) >> 24) & 0x3)
+#define CCN_CONFIG_BUS(_config)		(((_config) >> 24) & 0x3)
 #define CCN_CONFIG_VC(_config)		(((_config) >> 26) & 0x7)
 #define CCN_CONFIG_DIR(_config)		(((_config) >> 29) & 0x1)
 #define CCN_CONFIG_MASK(_config)	(((_config) >> 30) & 0xf)
@@ -242,6 +243,7 @@ static CCN_FORMAT_ATTR(xp, "config:0-7");
 static CCN_FORMAT_ATTR(type, "config:8-15");
 static CCN_FORMAT_ATTR(event, "config:16-23");
 static CCN_FORMAT_ATTR(port, "config:24-25");
+static CCN_FORMAT_ATTR(bus, "config:24-25");
 static CCN_FORMAT_ATTR(vc, "config:26-28");
 static CCN_FORMAT_ATTR(dir, "config:29-29");
 static CCN_FORMAT_ATTR(mask, "config:30-33");
@@ -351,10 +353,14 @@ static ssize_t arm_ccn_pmu_event_show(struct device *dev,
 		break;
 	case CCN_TYPE_XP:
 		res += snprintf(buf + res, PAGE_SIZE - res,
-				",xp=?,port=?,vc=?,dir=?");
+				",xp=?,vc=?");
 		if (event->event == CCN_EVENT_WATCHPOINT)
 			res += snprintf(buf + res, PAGE_SIZE - res,
-					",cmp_l=?,cmp_h=?,mask=?");
+					",port=?,dir=?,cmp_l=?,cmp_h=?,mask=?");
+		else
+			res += snprintf(buf + res, PAGE_SIZE - res,
+					",bus=?");
+
 		break;
 	case CCN_TYPE_MN:
 		res += snprintf(buf + res, PAGE_SIZE - res, ",node=%d", ccn->mn_id);
@@ -1029,7 +1035,7 @@ static void arm_ccn_pmu_xp_event_config(struct perf_event *event)
 	hw->event_base = CCN_XP_DT_CONFIG__DT_CFG__XP_PMU_EVENT(hw->config_base);
 
 	id = (CCN_CONFIG_VC(event->attr.config) << 4) |
-			(CCN_CONFIG_PORT(event->attr.config) << 3) |
+			(CCN_CONFIG_BUS(event->attr.config) << 3) |
 			(CCN_CONFIG_EVENT(event->attr.config) << 0);
 
 	val = readl(source->base + CCN_XP_PMU_EVENT_SEL);
-- 
2.7.4

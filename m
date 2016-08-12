From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 12 Aug 2016 17:25:56 +0100
Subject: [PATCH 5/5] bus: arm-ccn: Add missing event attribute exclusions for
 host/guest
In-Reply-To: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
References: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1471019156-5485-6-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCN PMUs have no knowledge into VM-related origins of the memory
traffic, therefore can't handle requests for host-only or guest-only
events. Add appropriate exclusions (they should have been there from
the beginning).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index e7c2321..f2e099b 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -744,7 +744,8 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 
 	if (has_branch_stack(event) || event->attr.exclude_user ||
 			event->attr.exclude_kernel || event->attr.exclude_hv ||
-			event->attr.exclude_idle) {
+			event->attr.exclude_idle || event->attr.exclude_host ||
+			event->attr.exclude_guest) {
 		dev_warn(ccn->dev, "Can't exclude execution levels!\n");
 		return -EOPNOTSUPP;
 	}
-- 
2.7.4

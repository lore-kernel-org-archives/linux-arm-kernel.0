From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 16 Nov 2018 10:24:06 +0000
Subject: [PATCH 03/10] arm: perf: add additional validation to set_event_filter
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542363853-13849-4-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armv7pmu driver doesn't support host/guest mode exclusion so
let's report this when set_event_filter is called with these
exclusion flags set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index a4fb0f8..c4c9fbb 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1074,6 +1074,8 @@ static int armv7pmu_set_event_filter(struct hw_perf_event *event,
 
 	if (attr->exclude_idle)
 		return -EPERM;
+	if (attr->exclude_host || attr->exclude_guest)
+		return -EPERM;
 	if (attr->exclude_user)
 		config_base |= ARMV7_EXCLUDE_USER;
 	if (attr->exclude_kernel)
-- 
2.7.4

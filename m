From: andrew.murray@arm.com (Andrew Murray)
Date: Fri, 16 Nov 2018 10:24:08 +0000
Subject: [PATCH 05/10] powerpc/pmu/fsl: add additional validation to event_init
In-Reply-To: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542363853-13849-6-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl PMU driver doesn't support host/guest mode exclusion so
let's report this when event_init is called with these exclusion
flags set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/powerpc/perf/core-fsl-emb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index ba48584..b1cc9d1 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -559,6 +559,8 @@ static int fsl_emb_pmu_event_init(struct perf_event *event)
 		event->hw.config_base |= PMLCA_FCS;
 	if (event->attr.exclude_idle)
 		return -ENOTSUPP;
+	if (event->attr.exclude_host || event->attr.exclude_guest)
+		return -ENOTSUPP;
 
 	event->hw.last_period = event->hw.sample_period;
 	local64_set(&event->hw.period_left, event->hw.last_period);
-- 
2.7.4

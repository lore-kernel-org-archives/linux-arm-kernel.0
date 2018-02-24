From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 23 Feb 2018 16:19:37 -0800
Subject: [PATCH v1 1/2] perf/core: Add API to look up PMU type by name
Message-ID: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the event numbers registered by multiple PMUs overlap, the
attr->type value passed to perf_event_create_kernel_counter() is used
to determine which PMU to use to create a perf_event.

However, when the PMU in question is not a standard PMU (defined in
perf_type_id), there is no way for a kernel client to look up the PMU
type for the PMU of interest and set the attr->type appropriately.

So, add an API to look up the PMU type by name. That way, the kernel
APIs can function in a fashion similar to the user space interface.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 kernel/events/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96db9ae..5d3df58 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10310,6 +10310,29 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 	return err;
 }
 
+int perf_find_pmu_type_by_name(const char *name)
+{
+	struct pmu *pmu;
+	int ret = -1;
+
+	mutex_lock(&pmus_lock);
+
+	list_for_each_entry(pmu, &pmus, entry) {
+		if (!pmu->name || pmu->type < 0)
+			continue;
+
+		if (!strcmp(name, pmu->name)) {
+			ret = pmu->type;
+			goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&pmus_lock);
+
+	return ret;
+}
+
 /**
  * perf_event_create_kernel_counter
  *
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

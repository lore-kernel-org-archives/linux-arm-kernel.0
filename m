From: nleeder@codeaurora.org (Neil Leeder)
Date: Fri,  3 Jun 2016 17:03:31 -0400
Subject: [PATCH 1/2] perf: allow add to change event state
In-Reply-To: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <1464987812-14360-2-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the platform-specific pmu->add function returns
an error, it may have also changed the event's state.
If so, do not override that new state.

Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c0ded24..95c4cf3d3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1952,7 +1952,8 @@ event_sched_in(struct perf_event *event,
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
-		event->state = PERF_EVENT_STATE_INACTIVE;
+		if (event->state == PERF_EVENT_STATE_ACTIVE)
+			event->state = PERF_EVENT_STATE_INACTIVE;
 		event->oncpu = -1;
 		ret = -EAGAIN;
 		goto out;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

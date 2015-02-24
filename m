From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 24 Feb 2015 13:17:43 +0000
Subject: [PATCH 4/4] arm-cci: Fix CCI PMU event validation
In-Reply-To: <1424783863-9894-1-git-send-email-suzuki.poulose@arm.com>
References: <1424783863-9894-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1424783863-9894-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

We mask the event with the CCI_PMU_EVENT_MASK, before passing
the config to pmu_validate_hw_event(), which causes extra bits
to be ignored and qualifies an invalid event code as valid.

e.g,
 $ perf stat -a -C 0 -e CCI_400/config=0x1ff,name=cycles/ sleep 1
   Performance counter stats for 'system wide':

         506951142      cycles

       1.013879626 seconds time elapsed

where, cycles has an event coding of 0xff. This patch also removes
the unnecessary 'event' mask in pmu_write_register, since the config_base
is set by the pmu code after the event is validated.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7e330fe..b0ee582 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -191,11 +191,14 @@ static int pmu_is_valid_master_event(u8 ev_code)
 		ev_code <= pmu->model->event_ranges[CCI_IF_MASTER].max;
 }
 
-static int pmu_validate_hw_event(u8 hw_event)
+static int pmu_validate_hw_event(u32 hw_event)
 {
 	u8 ev_source = CCI_PMU_EVENT_SOURCE(hw_event);
 	u8 ev_code = CCI_PMU_EVENT_CODE(hw_event);
 
+	if (hw_event & ~CCI_PMU_EVENT_MASK)
+		return -ENOENT;
+
 	switch (ev_source) {
 	case CCI_PORT_S0:
 	case CCI_PORT_S1:
@@ -265,7 +268,6 @@ static void pmu_enable_counter(int idx)
 
 static void pmu_set_event(int idx, unsigned long event)
 {
-	event &= CCI_PMU_EVENT_MASK;
 	pmu_write_register(event, idx, CCI_PMU_EVT_SEL);
 }
 
@@ -282,7 +284,7 @@ static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *ev
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
 	struct hw_perf_event *hw_event = &event->hw;
-	unsigned long cci_event = hw_event->config_base & CCI_PMU_EVENT_MASK;
+	unsigned long cci_event = hw_event->config_base;
 	int idx;
 
 	if (cci_event == CCI_PMU_CYCLES) {
@@ -303,7 +305,7 @@ static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *ev
 static int pmu_map_event(struct perf_event *event)
 {
 	int mapping;
-	u8 config = event->attr.config & CCI_PMU_EVENT_MASK;
+	u32 config = event->attr.config;
 
 	if (event->attr.type < PERF_TYPE_MAX)
 		return -ENOENT;
-- 
1.7.9.5

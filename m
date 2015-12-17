From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:12 +0000
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the transaction hooks for CCI PMU, which can be
later exploited to amortise the cost of writing the counters for
CCI-500 PMU.

We keep track of only the 'ADD' transactions. While we are in a
transaction, we keep track of the indices allocated for the events
and delay the following operations until the transaction is committed.
 1) Programming the event on the counter
 2) Enabling the counter
 3) Setting the period for the event.

Additionally to prevent pmu->del() from updating bogus values from
an event added in the transaction (since we haven't set the period
on the event before the transaction is committed), we mark the state
of the event as PERF_HES_STOPPED in pmu->start(). This will be cleared
once the transaction is committed.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: peterz at infradead.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index f00cbce..ec3d4fd 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -115,6 +115,8 @@ struct cci_pmu_hw_events {
 	struct perf_event **events;
 	unsigned long *used_mask;
 	raw_spinlock_t pmu_lock;
+	unsigned long txn_flags;
+	unsigned long *txn_mask;
 };
 
 struct cci_pmu;
@@ -965,12 +967,25 @@ static void cci_pmu_start(struct perf_event *event, int pmu_flags)
 
 	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
 
-	/* Configure the counter unless you are counting a fixed event */
-	if (!pmu_fixed_hw_idx(cci_pmu, idx))
-		pmu_set_event(cci_pmu, idx, hwc->config_base);
+	/*
+	 * If we got here from pmu->add(PERF_EF_START) while we are in a
+	 * transaction, we note down the index and write to the counters
+	 * in a batch when we commit the transaction. see cci_pmu_commit_txn().
+	 * Also, mark this one as STOPPED until we commit the transaction
+	 * to avoid reading bogus values in pmu->del() if the transaction
+	 * fails later.
+	 */
+	if ((pmu_flags & PERF_EF_START) && (hw_events->txn_flags == PERF_PMU_TXN_ADD)) {
+		hwc->state = PERF_HES_STOPPED;
+		set_bit(idx, hw_events->txn_mask);
+	} else {
+		/* Configure the counter unless you are counting a fixed event */
+		if (!pmu_fixed_hw_idx(cci_pmu, idx))
+			pmu_set_event(cci_pmu, idx, hwc->config_base);
 
-	pmu_event_set_period(event);
-	pmu_enable_counter(cci_pmu, idx);
+		pmu_event_set_period(event);
+		pmu_enable_counter(cci_pmu, idx);
+	}
 
 	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
 }
@@ -981,6 +996,10 @@ static void cci_pmu_stop(struct perf_event *event, int pmu_flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
+	/*
+	 * If the counter was never started, e.g a failed transaction
+	 * do nothing.
+	 */
 	if (hwc->state & PERF_HES_STOPPED)
 		return;
 
@@ -1200,6 +1219,87 @@ static int cci_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+static void cci_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+
+	WARN_ON_ONCE(hw_events->txn_flags);
+
+	hw_events->txn_flags = txn_flags;
+	memset(hw_events->txn_mask, 0,
+			BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
+}
+
+/*
+ * Completing the transaction involves :
+ *
+ * 1) Updating the period for each event in the transaction.
+ * 	- Updating the event->hw.prev_count for each event.
+ *	- Writing the period to all the counters allocated for
+ *	  the transaction.
+ * 2) Program the events to the counters
+ * 3) Changing the event->hw.state from PERF_HES_STOPPED, now that
+ *    we are committing the event.
+ * 4) Enable the counter
+ */
+static int cci_pmu_complete_txn(struct cci_pmu *cci_pmu)
+{
+	int i, rc = 0;
+	unsigned long flags;
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+
+	/* Set event period for all the counters in this txn */
+	pmu_write_counters(cci_pmu, hw_events->txn_mask, CCI_CNTR_PERIOD);
+
+	for_each_set_bit(i, hw_events->txn_mask, cci_pmu->num_cntrs) {
+		struct perf_event *event = hw_events->events[i];
+
+		if (!event) {
+			WARN_ON_ONCE(1);
+			rc = -EFAULT;
+			goto unlock;
+		}
+
+		local64_set(&event->hw.prev_count, CCI_CNTR_PERIOD);
+		if (!pmu_fixed_hw_idx(cci_pmu, i))
+			pmu_set_event(cci_pmu, i, event->hw.config_base);
+		event->hw.state = 0;
+		pmu_enable_counter(cci_pmu, i);
+	}
+
+unlock:
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
+
+	return rc;
+}
+
+static int cci_pmu_commit_txn(struct pmu *pmu)
+{
+	int rc = 0;
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+
+	WARN_ON_ONCE(!hw_events->txn_flags);
+
+	if (hw_events->txn_flags == PERF_PMU_TXN_ADD)
+		rc = cci_pmu_complete_txn(cci_pmu);
+
+	if (!rc)
+		hw_events->txn_flags = 0;
+	return rc;
+}
+
+static void cci_pmu_cancel_txn(struct pmu *pmu)
+{
+	struct cci_pmu_hw_events *hw_events = &to_cci_pmu(pmu)->hw_events;
+
+	WARN_ON_ONCE(!hw_events->txn_flags);
+	hw_events->txn_flags = 0;
+}
+
 static ssize_t pmu_cpumask_attr_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -1257,6 +1357,9 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 		.pmu_enable	= cci_pmu_enable,
 		.pmu_disable	= cci_pmu_disable,
 		.event_init	= cci_pmu_event_init,
+		.start_txn	= cci_pmu_start_txn,
+		.commit_txn	= cci_pmu_commit_txn,
+		.cancel_txn	= cci_pmu_cancel_txn,
 		.add		= cci_pmu_add,
 		.del		= cci_pmu_del,
 		.start		= cci_pmu_start,
@@ -1463,6 +1566,12 @@ static struct cci_pmu *cci_pmu_alloc(struct platform_device *pdev)
 	if (!cci_pmu->hw_events.used_mask)
 		return ERR_PTR(-ENOMEM);
 
+	cci_pmu->hw_events.txn_mask = devm_kcalloc(&pdev->dev,
+						BITS_TO_LONGS(CCI_PMU_MAX_HW_CNTRS(model)),
+						sizeof(*cci_pmu->hw_events.txn_mask),
+						GFP_KERNEL);
+	if (!cci_pmu->hw_events.txn_mask)
+		return ERR_PTR(-ENOMEM);
 	return cci_pmu;
 }
 
-- 
1.7.9.5

From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:44 -0600
Subject: [PATCH 03/11] coresight: etm4x: splitting struct etmv4_drvdata
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to what was done on etm3x, splitting driver structure
etmv4_drvdata in two.  One half is concerned with the HW
characteristics that are generally static in nature.  The other
half deals with user configuration and will change from one
trace session to another.

No gain/loss of functionality is incurred from this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 642 ++++++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.c      | 134 ++---
 drivers/hwtracing/coresight/coresight-etm4x.h      | 202 +++----
 3 files changed, 533 insertions(+), 445 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 39a8b077e0c2..a996db7ef2fc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -21,13 +21,16 @@
 
 static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 {
-	u8 idx = drvdata->addr_idx;
+	u8 idx;
+	struct etmv4_config *config = &drvdata->config;
+
+	idx = config->addr_idx;
 
 	/*
 	 * TRCACATRn.TYPE bit[1:0]: type of comparison
 	 * the trace unit performs
 	 */
-	if (BMVAL(drvdata->addr_acc[idx], 0, 1) == ETM_INSTR_ADDR) {
+	if (BMVAL(config->addr_acc[idx], 0, 1) == ETM_INSTR_ADDR) {
 		if (idx % 2 != 0)
 			return -EINVAL;
 
@@ -36,8 +39,8 @@ static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 		 * relevant bit of ViewInst Include/Exclude Control register
 		 * for corresponding address comparator pair.
 		 */
-		if (drvdata->addr_type[idx] != ETM_ADDR_TYPE_RANGE ||
-		    drvdata->addr_type[idx + 1] != ETM_ADDR_TYPE_RANGE)
+		if (config->addr_type[idx] != ETM_ADDR_TYPE_RANGE ||
+		    config->addr_type[idx + 1] != ETM_ADDR_TYPE_RANGE)
 			return -EINVAL;
 
 		if (exclude == true) {
@@ -45,15 +48,15 @@ static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 			 * Set exclude bit and unset the include bit
 			 * corresponding to comparator pair
 			 */
-			drvdata->viiectlr |= BIT(idx / 2 + 16);
-			drvdata->viiectlr &= ~BIT(idx / 2);
+			config->viiectlr |= BIT(idx / 2 + 16);
+			config->viiectlr &= ~BIT(idx / 2);
 		} else {
 			/*
 			 * Set include bit and unset exclude bit
 			 * corresponding to comparator pair
 			 */
-			drvdata->viiectlr |= BIT(idx / 2);
-			drvdata->viiectlr &= ~BIT(idx / 2 + 16);
+			config->viiectlr |= BIT(idx / 2);
+			config->viiectlr &= ~BIT(idx / 2 + 16);
 		}
 	}
 	return 0;
@@ -174,104 +177,107 @@ static ssize_t reset_store(struct device *dev,
 	int i;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	if (val)
-		drvdata->mode = 0x0;
+		config->mode = 0x0;
 
 	/* Disable data tracing: do not trace load and store data transfers */
-	drvdata->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
-	drvdata->cfg &= ~(BIT(1) | BIT(2));
+	config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
+	config->cfg &= ~(BIT(1) | BIT(2));
 
 	/* Disable data value and data address tracing */
-	drvdata->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
+	config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
 			   ETM_MODE_DATA_TRACE_VAL);
-	drvdata->cfg &= ~(BIT(16) | BIT(17));
+	config->cfg &= ~(BIT(16) | BIT(17));
 
 	/* Disable all events tracing */
-	drvdata->eventctrl0 = 0x0;
-	drvdata->eventctrl1 = 0x0;
+	config->eventctrl0 = 0x0;
+	config->eventctrl1 = 0x0;
 
 	/* Disable timestamp event */
-	drvdata->ts_ctrl = 0x0;
+	config->ts_ctrl = 0x0;
 
 	/* Disable stalling */
-	drvdata->stall_ctrl = 0x0;
+	config->stall_ctrl = 0x0;
 
 	/* Reset trace synchronization period  to 2^8 = 256 bytes*/
 	if (drvdata->syncpr == false)
-		drvdata->syncfreq = 0x8;
+		config->syncfreq = 0x8;
 
 	/*
 	 * Enable ViewInst to trace everything with start-stop logic in
 	 * started state. ARM recommends start-stop logic is set before
 	 * each trace run.
 	 */
-	drvdata->vinst_ctrl |= BIT(0);
+	config->vinst_ctrl |= BIT(0);
 	if (drvdata->nr_addr_cmp == true) {
-		drvdata->mode |= ETM_MODE_VIEWINST_STARTSTOP;
+		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 		/* SSSTATUS, bit[9] */
-		drvdata->vinst_ctrl |= BIT(9);
+		config->vinst_ctrl |= BIT(9);
 	}
 
 	/* No address range filtering for ViewInst */
-	drvdata->viiectlr = 0x0;
+	config->viiectlr = 0x0;
 
 	/* No start-stop filtering for ViewInst */
-	drvdata->vissctlr = 0x0;
+	config->vissctlr = 0x0;
 
 	/* Disable seq events */
 	for (i = 0; i < drvdata->nrseqstate-1; i++)
-		drvdata->seq_ctrl[i] = 0x0;
-	drvdata->seq_rst = 0x0;
-	drvdata->seq_state = 0x0;
+		config->seq_ctrl[i] = 0x0;
+	config->seq_rst = 0x0;
+	config->seq_state = 0x0;
 
 	/* Disable external input events */
-	drvdata->ext_inp = 0x0;
+	config->ext_inp = 0x0;
 
-	drvdata->cntr_idx = 0x0;
+	config->cntr_idx = 0x0;
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		drvdata->cntrldvr[i] = 0x0;
-		drvdata->cntr_ctrl[i] = 0x0;
-		drvdata->cntr_val[i] = 0x0;
+		config->cntrldvr[i] = 0x0;
+		config->cntr_ctrl[i] = 0x0;
+		config->cntr_val[i] = 0x0;
 	}
 
-	drvdata->res_idx = 0x0;
+	config->res_idx = 0x0;
 	for (i = 0; i < drvdata->nr_resource; i++)
-		drvdata->res_ctrl[i] = 0x0;
+		config->res_ctrl[i] = 0x0;
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-		drvdata->ss_ctrl[i] = 0x0;
-		drvdata->ss_pe_cmp[i] = 0x0;
+		config->ss_ctrl[i] = 0x0;
+		config->ss_pe_cmp[i] = 0x0;
 	}
 
-	drvdata->addr_idx = 0x0;
+	config->addr_idx = 0x0;
 	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
-		drvdata->addr_val[i] = 0x0;
-		drvdata->addr_acc[i] = 0x0;
-		drvdata->addr_type[i] = ETM_ADDR_TYPE_NONE;
+		config->addr_val[i] = 0x0;
+		config->addr_acc[i] = 0x0;
+		config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 	}
 
-	drvdata->ctxid_idx = 0x0;
+	config->ctxid_idx = 0x0;
 	for (i = 0; i < drvdata->numcidc; i++) {
-		drvdata->ctxid_pid[i] = 0x0;
-		drvdata->ctxid_vpid[i] = 0x0;
+		config->ctxid_pid[i] = 0x0;
+		config->ctxid_vpid[i] = 0x0;
 	}
 
-	drvdata->ctxid_mask0 = 0x0;
-	drvdata->ctxid_mask1 = 0x0;
+	config->ctxid_mask0 = 0x0;
+	config->ctxid_mask1 = 0x0;
 
-	drvdata->vmid_idx = 0x0;
+	config->vmid_idx = 0x0;
 	for (i = 0; i < drvdata->numvmidc; i++)
-		drvdata->vmid_val[i] = 0x0;
-	drvdata->vmid_mask0 = 0x0;
-	drvdata->vmid_mask1 = 0x0;
+		config->vmid_val[i] = 0x0;
+	config->vmid_mask0 = 0x0;
+	config->vmid_mask1 = 0x0;
 
 	drvdata->trcid = drvdata->cpu + 1;
+
 	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_WO(reset);
@@ -282,8 +288,9 @@ static ssize_t mode_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->mode;
+	val = config->mode;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -293,146 +300,148 @@ static ssize_t mode_store(struct device *dev,
 {
 	unsigned long val, mode;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->mode = val & ETMv4_MODE_ALL;
+	config->mode = val & ETMv4_MODE_ALL;
 
-	if (drvdata->mode & ETM_MODE_EXCLUDE)
+	if (config->mode & ETM_MODE_EXCLUDE)
 		etm4_set_mode_exclude(drvdata, true);
 	else
 		etm4_set_mode_exclude(drvdata, false);
 
 	if (drvdata->instrp0 == true) {
 		/* start by clearing instruction P0 field */
-		drvdata->cfg  &= ~(BIT(1) | BIT(2));
-		if (drvdata->mode & ETM_MODE_LOAD)
+		config->cfg  &= ~(BIT(1) | BIT(2));
+		if (config->mode & ETM_MODE_LOAD)
 			/* 0b01 Trace load instructions as P0 instructions */
-			drvdata->cfg  |= BIT(1);
-		if (drvdata->mode & ETM_MODE_STORE)
+			config->cfg  |= BIT(1);
+		if (config->mode & ETM_MODE_STORE)
 			/* 0b10 Trace store instructions as P0 instructions */
-			drvdata->cfg  |= BIT(2);
-		if (drvdata->mode & ETM_MODE_LOAD_STORE)
+			config->cfg  |= BIT(2);
+		if (config->mode & ETM_MODE_LOAD_STORE)
 			/*
 			 * 0b11 Trace load and store instructions
 			 * as P0 instructions
 			 */
-			drvdata->cfg  |= BIT(1) | BIT(2);
+			config->cfg  |= BIT(1) | BIT(2);
 	}
 
 	/* bit[3], Branch broadcast mode */
-	if ((drvdata->mode & ETM_MODE_BB) && (drvdata->trcbb == true))
-		drvdata->cfg |= BIT(3);
+	if ((config->mode & ETM_MODE_BB) && (drvdata->trcbb == true))
+		config->cfg |= BIT(3);
 	else
-		drvdata->cfg &= ~BIT(3);
+		config->cfg &= ~BIT(3);
 
 	/* bit[4], Cycle counting instruction trace bit */
-	if ((drvdata->mode & ETMv4_MODE_CYCACC) &&
+	if ((config->mode & ETMv4_MODE_CYCACC) &&
 		(drvdata->trccci == true))
-		drvdata->cfg |= BIT(4);
+		config->cfg |= BIT(4);
 	else
-		drvdata->cfg &= ~BIT(4);
+		config->cfg &= ~BIT(4);
 
 	/* bit[6], Context ID tracing bit */
-	if ((drvdata->mode & ETMv4_MODE_CTXID) && (drvdata->ctxid_size))
-		drvdata->cfg |= BIT(6);
+	if ((config->mode & ETMv4_MODE_CTXID) && (drvdata->ctxid_size))
+		config->cfg |= BIT(6);
 	else
-		drvdata->cfg &= ~BIT(6);
+		config->cfg &= ~BIT(6);
 
-	if ((drvdata->mode & ETM_MODE_VMID) && (drvdata->vmid_size))
-		drvdata->cfg |= BIT(7);
+	if ((config->mode & ETM_MODE_VMID) && (drvdata->vmid_size))
+		config->cfg |= BIT(7);
 	else
-		drvdata->cfg &= ~BIT(7);
+		config->cfg &= ~BIT(7);
 
 	/* bits[10:8], Conditional instruction tracing bit */
-	mode = ETM_MODE_COND(drvdata->mode);
+	mode = ETM_MODE_COND(config->mode);
 	if (drvdata->trccond == true) {
-		drvdata->cfg &= ~(BIT(8) | BIT(9) | BIT(10));
-		drvdata->cfg |= mode << 8;
+		config->cfg &= ~(BIT(8) | BIT(9) | BIT(10));
+		config->cfg |= mode << 8;
 	}
 
 	/* bit[11], Global timestamp tracing bit */
-	if ((drvdata->mode & ETMv4_MODE_TIMESTAMP) && (drvdata->ts_size))
-		drvdata->cfg |= BIT(11);
+	if ((config->mode & ETMv4_MODE_TIMESTAMP) && (drvdata->ts_size))
+		config->cfg |= BIT(11);
 	else
-		drvdata->cfg &= ~BIT(11);
+		config->cfg &= ~BIT(11);
 
 	/* bit[12], Return stack enable bit */
-	if ((drvdata->mode & ETM_MODE_RETURNSTACK) &&
-		(drvdata->retstack == true))
-		drvdata->cfg |= BIT(12);
+	if ((config->mode & ETM_MODE_RETURNSTACK) &&
+					(drvdata->retstack == true))
+		config->cfg |= BIT(12);
 	else
-		drvdata->cfg &= ~BIT(12);
+		config->cfg &= ~BIT(12);
 
 	/* bits[14:13], Q element enable field */
-	mode = ETM_MODE_QELEM(drvdata->mode);
+	mode = ETM_MODE_QELEM(config->mode);
 	/* start by clearing QE bits */
-	drvdata->cfg &= ~(BIT(13) | BIT(14));
+	config->cfg &= ~(BIT(13) | BIT(14));
 	/* if supported, Q elements with instruction counts are enabled */
 	if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
-		drvdata->cfg |= BIT(13);
+		config->cfg |= BIT(13);
 	/*
 	 * if supported, Q elements with and without instruction
 	 * counts are enabled
 	 */
 	if ((mode & BIT(1)) && (drvdata->q_support & BIT(1)))
-		drvdata->cfg |= BIT(14);
+		config->cfg |= BIT(14);
 
 	/* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
-	if ((drvdata->mode & ETM_MODE_ATB_TRIGGER) &&
+	if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
 	    (drvdata->atbtrig == true))
-		drvdata->eventctrl1 |= BIT(11);
+		config->eventctrl1 |= BIT(11);
 	else
-		drvdata->eventctrl1 &= ~BIT(11);
+		config->eventctrl1 &= ~BIT(11);
 
 	/* bit[12], Low-power state behavior override bit */
-	if ((drvdata->mode & ETM_MODE_LPOVERRIDE) &&
+	if ((config->mode & ETM_MODE_LPOVERRIDE) &&
 	    (drvdata->lpoverride == true))
-		drvdata->eventctrl1 |= BIT(12);
+		config->eventctrl1 |= BIT(12);
 	else
-		drvdata->eventctrl1 &= ~BIT(12);
+		config->eventctrl1 &= ~BIT(12);
 
 	/* bit[8], Instruction stall bit */
-	if (drvdata->mode & ETM_MODE_ISTALL_EN)
-		drvdata->stall_ctrl |= BIT(8);
+	if (config->mode & ETM_MODE_ISTALL_EN)
+		config->stall_ctrl |= BIT(8);
 	else
-		drvdata->stall_ctrl &= ~BIT(8);
+		config->stall_ctrl &= ~BIT(8);
 
 	/* bit[10], Prioritize instruction trace bit */
-	if (drvdata->mode & ETM_MODE_INSTPRIO)
-		drvdata->stall_ctrl |= BIT(10);
+	if (config->mode & ETM_MODE_INSTPRIO)
+		config->stall_ctrl |= BIT(10);
 	else
-		drvdata->stall_ctrl &= ~BIT(10);
+		config->stall_ctrl &= ~BIT(10);
 
 	/* bit[13], Trace overflow prevention bit */
-	if ((drvdata->mode & ETM_MODE_NOOVERFLOW) &&
+	if ((config->mode & ETM_MODE_NOOVERFLOW) &&
 		(drvdata->nooverflow == true))
-		drvdata->stall_ctrl |= BIT(13);
+		config->stall_ctrl |= BIT(13);
 	else
-		drvdata->stall_ctrl &= ~BIT(13);
+		config->stall_ctrl &= ~BIT(13);
 
 	/* bit[9] Start/stop logic control bit */
-	if (drvdata->mode & ETM_MODE_VIEWINST_STARTSTOP)
-		drvdata->vinst_ctrl |= BIT(9);
+	if (config->mode & ETM_MODE_VIEWINST_STARTSTOP)
+		config->vinst_ctrl |= BIT(9);
 	else
-		drvdata->vinst_ctrl &= ~BIT(9);
+		config->vinst_ctrl &= ~BIT(9);
 
 	/* bit[10], Whether a trace unit must trace a Reset exception */
-	if (drvdata->mode & ETM_MODE_TRACE_RESET)
-		drvdata->vinst_ctrl |= BIT(10);
+	if (config->mode & ETM_MODE_TRACE_RESET)
+		config->vinst_ctrl |= BIT(10);
 	else
-		drvdata->vinst_ctrl &= ~BIT(10);
+		config->vinst_ctrl &= ~BIT(10);
 
 	/* bit[11], Whether a trace unit must trace a system error exception */
-	if ((drvdata->mode & ETM_MODE_TRACE_ERR) &&
+	if ((config->mode & ETM_MODE_TRACE_ERR) &&
 		(drvdata->trc_error == true))
-		drvdata->vinst_ctrl |= BIT(11);
+		config->vinst_ctrl |= BIT(11);
 	else
-		drvdata->vinst_ctrl &= ~BIT(11);
+		config->vinst_ctrl &= ~BIT(11);
 
 	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_RW(mode);
@@ -443,8 +452,9 @@ static ssize_t pe_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->pe_sel;
+	val = config->pe_sel;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -454,6 +464,7 @@ static ssize_t pe_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -464,7 +475,7 @@ static ssize_t pe_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	drvdata->pe_sel = val;
+	config->pe_sel = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -476,8 +487,9 @@ static ssize_t event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->eventctrl0;
+	val = config->eventctrl0;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -487,6 +499,7 @@ static ssize_t event_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -495,19 +508,19 @@ static ssize_t event_store(struct device *dev,
 	switch (drvdata->nr_event) {
 	case 0x0:
 		/* EVENT0, bits[7:0] */
-		drvdata->eventctrl0 = val & 0xFF;
+		config->eventctrl0 = val & 0xFF;
 		break;
 	case 0x1:
 		 /* EVENT1, bits[15:8] */
-		drvdata->eventctrl0 = val & 0xFFFF;
+		config->eventctrl0 = val & 0xFFFF;
 		break;
 	case 0x2:
 		/* EVENT2, bits[23:16] */
-		drvdata->eventctrl0 = val & 0xFFFFFF;
+		config->eventctrl0 = val & 0xFFFFFF;
 		break;
 	case 0x3:
 		/* EVENT3, bits[31:24] */
-		drvdata->eventctrl0 = val;
+		config->eventctrl0 = val;
 		break;
 	default:
 		break;
@@ -523,8 +536,9 @@ static ssize_t event_instren_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = BMVAL(drvdata->eventctrl1, 0, 3);
+	val = BMVAL(config->eventctrl1, 0, 3);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -534,29 +548,30 @@ static ssize_t event_instren_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	/* start by clearing all instruction event enable bits */
-	drvdata->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
+	config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
 	switch (drvdata->nr_event) {
 	case 0x0:
 		/* generate Event element for event 1 */
-		drvdata->eventctrl1 |= val & BIT(1);
+		config->eventctrl1 |= val & BIT(1);
 		break;
 	case 0x1:
 		/* generate Event element for event 1 and 2 */
-		drvdata->eventctrl1 |= val & (BIT(0) | BIT(1));
+		config->eventctrl1 |= val & (BIT(0) | BIT(1));
 		break;
 	case 0x2:
 		/* generate Event element for event 1, 2 and 3 */
-		drvdata->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
+		config->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
 		break;
 	case 0x3:
 		/* generate Event element for all 4 events */
-		drvdata->eventctrl1 |= val & 0xF;
+		config->eventctrl1 |= val & 0xF;
 		break;
 	default:
 		break;
@@ -572,8 +587,9 @@ static ssize_t event_ts_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->ts_ctrl;
+	val = config->ts_ctrl;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -583,13 +599,14 @@ static ssize_t event_ts_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (!drvdata->ts_size)
 		return -EINVAL;
 
-	drvdata->ts_ctrl = val & ETMv4_EVENT_MASK;
+	config->ts_ctrl = val & ETMv4_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(event_ts);
@@ -600,8 +617,9 @@ static ssize_t syncfreq_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->syncfreq;
+	val = config->syncfreq;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -611,13 +629,14 @@ static ssize_t syncfreq_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (drvdata->syncpr == true)
 		return -EINVAL;
 
-	drvdata->syncfreq = val & ETMv4_SYNC_MASK;
+	config->syncfreq = val & ETMv4_SYNC_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(syncfreq);
@@ -628,8 +647,9 @@ static ssize_t cyc_threshold_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->ccctlr;
+	val = config->ccctlr;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -639,13 +659,14 @@ static ssize_t cyc_threshold_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (val < drvdata->ccitmin)
 		return -EINVAL;
 
-	drvdata->ccctlr = val & ETM_CYC_THRESHOLD_MASK;
+	config->ccctlr = val & ETM_CYC_THRESHOLD_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(cyc_threshold);
@@ -656,8 +677,9 @@ static ssize_t bb_ctrl_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->bb_ctrl;
+	val = config->bb_ctrl;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -667,6 +689,7 @@ static ssize_t bb_ctrl_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -681,7 +704,7 @@ static ssize_t bb_ctrl_store(struct device *dev,
 	if (BMVAL(val, 0, 7) > drvdata->nr_addr_cmp)
 		return -EINVAL;
 
-	drvdata->bb_ctrl = val;
+	config->bb_ctrl = val;
 	return size;
 }
 static DEVICE_ATTR_RW(bb_ctrl);
@@ -692,8 +715,9 @@ static ssize_t event_vinst_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->vinst_ctrl & ETMv4_EVENT_MASK;
+	val = config->vinst_ctrl & ETMv4_EVENT_MASK;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -703,14 +727,15 @@ static ssize_t event_vinst_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	val &= ETMv4_EVENT_MASK;
-	drvdata->vinst_ctrl &= ~ETMv4_EVENT_MASK;
-	drvdata->vinst_ctrl |= val;
+	config->vinst_ctrl &= ~ETMv4_EVENT_MASK;
+	config->vinst_ctrl |= val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -722,8 +747,9 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = BMVAL(drvdata->vinst_ctrl, 16, 19);
+	val = BMVAL(config->vinst_ctrl, 16, 19);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -733,16 +759,17 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits (bit[18] is never implemented) */
-	drvdata->vinst_ctrl &= ~(BIT(16) | BIT(17) | BIT(19));
+	config->vinst_ctrl &= ~(BIT(16) | BIT(17) | BIT(19));
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->s_ex_level;
-	drvdata->vinst_ctrl |= (val << 16);
+	config->vinst_ctrl |= (val << 16);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -754,9 +781,10 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	/* EXLEVEL_NS, bits[23:20] */
-	val = BMVAL(drvdata->vinst_ctrl, 20, 23);
+	val = BMVAL(config->vinst_ctrl, 20, 23);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -766,16 +794,17 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits (bit[23] is never implemented */
-	drvdata->vinst_ctrl &= ~(BIT(20) | BIT(21) | BIT(22));
+	config->vinst_ctrl &= ~(BIT(20) | BIT(21) | BIT(22));
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->ns_ex_level;
-	drvdata->vinst_ctrl |= (val << 20);
+	config->vinst_ctrl |= (val << 20);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -787,8 +816,9 @@ static ssize_t addr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->addr_idx;
+	val = config->addr_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -798,6 +828,7 @@ static ssize_t addr_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -809,7 +840,7 @@ static ssize_t addr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->addr_idx = val;
+	config->addr_idx = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -822,10 +853,11 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 	ssize_t len;
 	u8 val, idx;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	val = BMVAL(drvdata->addr_acc[idx], 0, 1);
+	idx = config->addr_idx;
+	val = BMVAL(config->addr_acc[idx], 0, 1);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n",
 			val == ETM_INSTR_ADDR ? "instr" :
 			(val == ETM_DATA_LOAD_ADDR ? "data_load" :
@@ -842,6 +874,7 @@ static ssize_t addr_instdatatype_store(struct device *dev,
 	u8 idx;
 	char str[20] = "";
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (strlen(buf) >= 20)
 		return -EINVAL;
@@ -849,10 +882,10 @@ static ssize_t addr_instdatatype_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (!strcmp(str, "instr"))
 		/* TYPE, bits[1:0] */
-		drvdata->addr_acc[idx] &= ~(BIT(0) | BIT(1));
+		config->addr_acc[idx] &= ~(BIT(0) | BIT(1));
 
 	spin_unlock(&drvdata->spinlock);
 	return size;
@@ -866,15 +899,16 @@ static ssize_t addr_single_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	spin_lock(&drvdata->spinlock);
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	val = (unsigned long)drvdata->addr_val[idx];
+	val = (unsigned long)config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -886,20 +920,21 @@ static ssize_t addr_single_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	idx = config->addr_idx;
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = (u64)val;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
+	config->addr_val[idx] = (u64)val;
+	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -912,23 +947,24 @@ static ssize_t addr_range_show(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (idx % 2 != 0) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	if (!((drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
-	      (drvdata->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val1 = (unsigned long)drvdata->addr_val[idx];
-	val2 = (unsigned long)drvdata->addr_val[idx + 1];
+	val1 = (unsigned long)config->addr_val[idx];
+	val2 = (unsigned long)config->addr_val[idx + 1];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
@@ -940,6 +976,7 @@ static ssize_t addr_range_store(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
 		return -EINVAL;
@@ -948,29 +985,29 @@ static ssize_t addr_range_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (idx % 2 != 0) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	if (!((drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
-	      (drvdata->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
-	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = (u64)val1;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
-	drvdata->addr_val[idx + 1] = (u64)val2;
-	drvdata->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
+	config->addr_val[idx] = (u64)val1;
+	config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
+	config->addr_val[idx + 1] = (u64)val2;
+	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
 	/*
 	 * Program include or exclude control bits for vinst or vdata
 	 * whenever we change addr comparators to ETM_ADDR_TYPE_RANGE
 	 */
-	if (drvdata->mode & ETM_MODE_EXCLUDE)
+	if (config->mode & ETM_MODE_EXCLUDE)
 		etm4_set_mode_exclude(drvdata, true);
 	else
 		etm4_set_mode_exclude(drvdata, false);
@@ -987,17 +1024,18 @@ static ssize_t addr_start_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = (unsigned long)drvdata->addr_val[idx];
+	val = (unsigned long)config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1009,27 +1047,28 @@ static ssize_t addr_start_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (!drvdata->nr_addr_cmp) {
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = (u64)val;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_START;
-	drvdata->vissctlr |= BIT(idx);
+	config->addr_val[idx] = (u64)val;
+	config->addr_type[idx] = ETM_ADDR_TYPE_START;
+	config->vissctlr |= BIT(idx);
 	/* SSSTATUS, bit[9] - turn on start/stop logic */
-	drvdata->vinst_ctrl |= BIT(9);
+	config->vinst_ctrl |= BIT(9);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1042,17 +1081,18 @@ static ssize_t addr_stop_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = (unsigned long)drvdata->addr_val[idx];
+	val = (unsigned long)config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1064,27 +1104,28 @@ static ssize_t addr_stop_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (!drvdata->nr_addr_cmp) {
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
-	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	       drvdata->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	       config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	drvdata->addr_val[idx] = (u64)val;
-	drvdata->addr_type[idx] = ETM_ADDR_TYPE_STOP;
-	drvdata->vissctlr |= BIT(idx + 16);
+	config->addr_val[idx] = (u64)val;
+	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
+	config->vissctlr |= BIT(idx + 16);
 	/* SSSTATUS, bit[9] - turn on start/stop logic */
-	drvdata->vinst_ctrl |= BIT(9);
+	config->vinst_ctrl |= BIT(9);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1097,11 +1138,12 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	ssize_t len;
 	u8 idx, val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
-	val = BMVAL(drvdata->addr_acc[idx], 2, 3);
+	val = BMVAL(config->addr_acc[idx], 2, 3);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
@@ -1116,6 +1158,7 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 	u8 idx;
 	char str[10] = "";
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (strlen(buf) >= 10)
 		return -EINVAL;
@@ -1123,21 +1166,21 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	if (!strcmp(str, "none"))
 		/* start by clearing context type bits */
-		drvdata->addr_acc[idx] &= ~(BIT(2) | BIT(3));
+		config->addr_acc[idx] &= ~(BIT(2) | BIT(3));
 	else if (!strcmp(str, "ctxid")) {
 		/* 0b01 The trace unit performs a Context ID */
 		if (drvdata->numcidc) {
-			drvdata->addr_acc[idx] |= BIT(2);
-			drvdata->addr_acc[idx] &= ~BIT(3);
+			config->addr_acc[idx] |= BIT(2);
+			config->addr_acc[idx] &= ~BIT(3);
 		}
 	} else if (!strcmp(str, "vmid")) {
 		/* 0b10 The trace unit performs a VMID */
 		if (drvdata->numvmidc) {
-			drvdata->addr_acc[idx] &= ~BIT(2);
-			drvdata->addr_acc[idx] |= BIT(3);
+			config->addr_acc[idx] &= ~BIT(2);
+			config->addr_acc[idx] |= BIT(3);
 		}
 	} else if (!strcmp(str, "all")) {
 		/*
@@ -1145,9 +1188,9 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		 * comparison and a VMID
 		 */
 		if (drvdata->numcidc)
-			drvdata->addr_acc[idx] |= BIT(2);
+			config->addr_acc[idx] |= BIT(2);
 		if (drvdata->numvmidc)
-			drvdata->addr_acc[idx] |= BIT(3);
+			config->addr_acc[idx] |= BIT(3);
 	}
 	spin_unlock(&drvdata->spinlock);
 	return size;
@@ -1161,11 +1204,12 @@ static ssize_t addr_context_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	/* context ID comparator bits[6:4] */
-	val = BMVAL(drvdata->addr_acc[idx], 4, 6);
+	val = BMVAL(config->addr_acc[idx], 4, 6);
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1177,6 +1221,7 @@ static ssize_t addr_context_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1187,10 +1232,10 @@ static ssize_t addr_context_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->addr_idx;
+	idx = config->addr_idx;
 	/* clear context ID comparator bits[6:4] */
-	drvdata->addr_acc[idx] &= ~(BIT(4) | BIT(5) | BIT(6));
-	drvdata->addr_acc[idx] |= (val << 4);
+	config->addr_acc[idx] &= ~(BIT(4) | BIT(5) | BIT(6));
+	config->addr_acc[idx] |= (val << 4);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1202,8 +1247,9 @@ static ssize_t seq_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->seq_idx;
+	val = config->seq_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1213,6 +1259,7 @@ static ssize_t seq_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1224,7 +1271,7 @@ static ssize_t seq_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->seq_idx = val;
+	config->seq_idx = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1236,8 +1283,9 @@ static ssize_t seq_state_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->seq_state;
+	val = config->seq_state;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1247,13 +1295,14 @@ static ssize_t seq_state_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (val >= drvdata->nrseqstate)
 		return -EINVAL;
 
-	drvdata->seq_state = val;
+	config->seq_state = val;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_state);
@@ -1265,10 +1314,11 @@ static ssize_t seq_event_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->seq_idx;
-	val = drvdata->seq_ctrl[idx];
+	idx = config->seq_idx;
+	val = config->seq_ctrl[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1280,14 +1330,15 @@ static ssize_t seq_event_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->seq_idx;
+	idx = config->seq_idx;
 	/* RST, bits[7:0] */
-	drvdata->seq_ctrl[idx] = val & 0xFF;
+	config->seq_ctrl[idx] = val & 0xFF;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1299,8 +1350,9 @@ static ssize_t seq_reset_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->seq_rst;
+	val = config->seq_rst;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1310,13 +1362,14 @@ static ssize_t seq_reset_event_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (!(drvdata->nrseqstate))
 		return -EINVAL;
 
-	drvdata->seq_rst = val & ETMv4_EVENT_MASK;
+	config->seq_rst = val & ETMv4_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_reset_event);
@@ -1327,8 +1380,9 @@ static ssize_t cntr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->cntr_idx;
+	val = config->cntr_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1338,6 +1392,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1349,7 +1404,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->cntr_idx = val;
+	config->cntr_idx = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1362,10 +1417,11 @@ static ssize_t cntrldvr_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->cntr_idx;
-	val = drvdata->cntrldvr[idx];
+	idx = config->cntr_idx;
+	val = config->cntrldvr[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1377,6 +1433,7 @@ static ssize_t cntrldvr_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1384,8 +1441,8 @@ static ssize_t cntrldvr_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->cntr_idx;
-	drvdata->cntrldvr[idx] = val;
+	idx = config->cntr_idx;
+	config->cntrldvr[idx] = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1398,10 +1455,11 @@ static ssize_t cntr_val_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->cntr_idx;
-	val = drvdata->cntr_val[idx];
+	idx = config->cntr_idx;
+	val = config->cntr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1413,6 +1471,7 @@ static ssize_t cntr_val_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1420,8 +1479,8 @@ static ssize_t cntr_val_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->cntr_idx;
-	drvdata->cntr_val[idx] = val;
+	idx = config->cntr_idx;
+	config->cntr_val[idx] = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1434,10 +1493,11 @@ static ssize_t cntr_ctrl_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->cntr_idx;
-	val = drvdata->cntr_ctrl[idx];
+	idx = config->cntr_idx;
+	val = config->cntr_ctrl[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1449,13 +1509,14 @@ static ssize_t cntr_ctrl_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->cntr_idx;
-	drvdata->cntr_ctrl[idx] = val;
+	idx = config->cntr_idx;
+	config->cntr_ctrl[idx] = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1467,8 +1528,9 @@ static ssize_t res_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->res_idx;
+	val = config->res_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1478,6 +1540,7 @@ static ssize_t res_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1490,7 +1553,7 @@ static ssize_t res_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->res_idx = val;
+	config->res_idx = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1503,10 +1566,11 @@ static ssize_t res_ctrl_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->res_idx;
-	val = drvdata->res_ctrl[idx];
+	idx = config->res_idx;
+	val = config->res_ctrl[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1518,17 +1582,18 @@ static ssize_t res_ctrl_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->res_idx;
+	idx = config->res_idx;
 	/* For odd idx pair inversal bit is RES0 */
 	if (idx % 2 != 0)
 		/* PAIRINV, bit[21] */
 		val &= ~BIT(21);
-	drvdata->res_ctrl[idx] = val;
+	config->res_ctrl[idx] = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1540,8 +1605,9 @@ static ssize_t ctxid_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->ctxid_idx;
+	val = config->ctxid_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1551,6 +1617,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1562,7 +1629,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->ctxid_idx = val;
+	config->ctxid_idx = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1575,10 +1642,11 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->ctxid_idx;
-	val = (unsigned long)drvdata->ctxid_vpid[idx];
+	idx = config->ctxid_idx;
+	val = (unsigned long)config->ctxid_vpid[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1590,6 +1658,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	u8 idx;
 	unsigned long vpid, pid;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	/*
 	 * only implemented when ctxid tracing is enabled, i.e. at least one
@@ -1604,9 +1673,9 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	pid = coresight_vpid_to_pid(vpid);
 
 	spin_lock(&drvdata->spinlock);
-	idx = drvdata->ctxid_idx;
-	drvdata->ctxid_pid[idx] = (u64)pid;
-	drvdata->ctxid_vpid[idx] = (u64)vpid;
+	idx = config->ctxid_idx;
+	config->ctxid_pid[idx] = (u64)pid;
+	config->ctxid_vpid[idx] = (u64)vpid;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1618,10 +1687,11 @@ static ssize_t ctxid_masks_show(struct device *dev,
 {
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	val1 = drvdata->ctxid_mask0;
-	val2 = drvdata->ctxid_mask1;
+	val1 = config->ctxid_mask0;
+	val2 = config->ctxid_mask1;
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
@@ -1633,6 +1703,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	u8 i, j, maskbyte;
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	/*
 	 * only implemented when ctxid tracing is enabled, i.e. at least one
@@ -1652,39 +1723,39 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	switch (drvdata->numcidc) {
 	case 0x1:
 		/* COMP0, bits[7:0] */
-		drvdata->ctxid_mask0 = val1 & 0xFF;
+		config->ctxid_mask0 = val1 & 0xFF;
 		break;
 	case 0x2:
 		/* COMP1, bits[15:8] */
-		drvdata->ctxid_mask0 = val1 & 0xFFFF;
+		config->ctxid_mask0 = val1 & 0xFFFF;
 		break;
 	case 0x3:
 		/* COMP2, bits[23:16] */
-		drvdata->ctxid_mask0 = val1 & 0xFFFFFF;
+		config->ctxid_mask0 = val1 & 0xFFFFFF;
 		break;
 	case 0x4:
 		 /* COMP3, bits[31:24] */
-		drvdata->ctxid_mask0 = val1;
+		config->ctxid_mask0 = val1;
 		break;
 	case 0x5:
 		/* COMP4, bits[7:0] */
-		drvdata->ctxid_mask0 = val1;
-		drvdata->ctxid_mask1 = val2 & 0xFF;
+		config->ctxid_mask0 = val1;
+		config->ctxid_mask1 = val2 & 0xFF;
 		break;
 	case 0x6:
 		/* COMP5, bits[15:8] */
-		drvdata->ctxid_mask0 = val1;
-		drvdata->ctxid_mask1 = val2 & 0xFFFF;
+		config->ctxid_mask0 = val1;
+		config->ctxid_mask1 = val2 & 0xFFFF;
 		break;
 	case 0x7:
 		/* COMP6, bits[23:16] */
-		drvdata->ctxid_mask0 = val1;
-		drvdata->ctxid_mask1 = val2 & 0xFFFFFF;
+		config->ctxid_mask0 = val1;
+		config->ctxid_mask1 = val2 & 0xFFFFFF;
 		break;
 	case 0x8:
 		/* COMP7, bits[31:24] */
-		drvdata->ctxid_mask0 = val1;
-		drvdata->ctxid_mask1 = val2;
+		config->ctxid_mask0 = val1;
+		config->ctxid_mask1 = val2;
 		break;
 	default:
 		break;
@@ -1695,7 +1766,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * For example, if bit[3] of ctxid_mask0 is 1, we must clear bits[31:24]
 	 * of ctxid comparator0 value (corresponding to byte 0) register.
 	 */
-	mask = drvdata->ctxid_mask0;
+	mask = config->ctxid_mask0;
 	for (i = 0; i < drvdata->numcidc; i++) {
 		/* mask value of corresponding ctxid comparator */
 		maskbyte = mask & ETMv4_EVENT_MASK;
@@ -1705,13 +1776,13 @@ static ssize_t ctxid_masks_store(struct device *dev,
 		 */
 		for (j = 0; j < 8; j++) {
 			if (maskbyte & 1)
-				drvdata->ctxid_pid[i] &= ~(0xFF << (j * 8));
+				config->ctxid_pid[i] &= ~(0xFF << (j * 8));
 			maskbyte >>= 1;
 		}
 		/* Select the next ctxid comparator mask value */
 		if (i == 3)
 			/* ctxid comparators[4-7] */
-			mask = drvdata->ctxid_mask1;
+			mask = config->ctxid_mask1;
 		else
 			mask >>= 0x8;
 	}
@@ -1727,8 +1798,9 @@ static ssize_t vmid_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = drvdata->vmid_idx;
+	val = config->vmid_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1738,6 +1810,7 @@ static ssize_t vmid_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1749,7 +1822,7 @@ static ssize_t vmid_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	drvdata->vmid_idx = val;
+	config->vmid_idx = val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1761,8 +1834,9 @@ static ssize_t vmid_val_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
-	val = (unsigned long)drvdata->vmid_val[drvdata->vmid_idx];
+	val = (unsigned long)config->vmid_val[config->vmid_idx];
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1772,6 +1846,7 @@ static ssize_t vmid_val_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
@@ -1783,7 +1858,7 @@ static ssize_t vmid_val_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	drvdata->vmid_val[drvdata->vmid_idx] = (u64)val;
+	config->vmid_val[config->vmid_idx] = (u64)val;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1794,10 +1869,11 @@ static ssize_t vmid_masks_show(struct device *dev,
 {
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
 
 	spin_lock(&drvdata->spinlock);
-	val1 = drvdata->vmid_mask0;
-	val2 = drvdata->vmid_mask1;
+	val1 = config->vmid_mask0;
+	val2 = config->vmid_mask1;
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
@@ -1809,6 +1885,8 @@ static ssize_t vmid_masks_store(struct device *dev,
 	u8 i, j, maskbyte;
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
@@ -1827,39 +1905,39 @@ static ssize_t vmid_masks_store(struct device *dev,
 	switch (drvdata->numvmidc) {
 	case 0x1:
 		/* COMP0, bits[7:0] */
-		drvdata->vmid_mask0 = val1 & 0xFF;
+		config->vmid_mask0 = val1 & 0xFF;
 		break;
 	case 0x2:
 		/* COMP1, bits[15:8] */
-		drvdata->vmid_mask0 = val1 & 0xFFFF;
+		config->vmid_mask0 = val1 & 0xFFFF;
 		break;
 	case 0x3:
 		/* COMP2, bits[23:16] */
-		drvdata->vmid_mask0 = val1 & 0xFFFFFF;
+		config->vmid_mask0 = val1 & 0xFFFFFF;
 		break;
 	case 0x4:
 		/* COMP3, bits[31:24] */
-		drvdata->vmid_mask0 = val1;
+		config->vmid_mask0 = val1;
 		break;
 	case 0x5:
 		/* COMP4, bits[7:0] */
-		drvdata->vmid_mask0 = val1;
-		drvdata->vmid_mask1 = val2 & 0xFF;
+		config->vmid_mask0 = val1;
+		config->vmid_mask1 = val2 & 0xFF;
 		break;
 	case 0x6:
 		/* COMP5, bits[15:8] */
-		drvdata->vmid_mask0 = val1;
-		drvdata->vmid_mask1 = val2 & 0xFFFF;
+		config->vmid_mask0 = val1;
+		config->vmid_mask1 = val2 & 0xFFFF;
 		break;
 	case 0x7:
 		/* COMP6, bits[23:16] */
-		drvdata->vmid_mask0 = val1;
-		drvdata->vmid_mask1 = val2 & 0xFFFFFF;
+		config->vmid_mask0 = val1;
+		config->vmid_mask1 = val2 & 0xFFFFFF;
 		break;
 	case 0x8:
 		/* COMP7, bits[31:24] */
-		drvdata->vmid_mask0 = val1;
-		drvdata->vmid_mask1 = val2;
+		config->vmid_mask0 = val1;
+		config->vmid_mask1 = val2;
 		break;
 	default:
 		break;
@@ -1871,7 +1949,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	 * For example, if bit[3] of vmid_mask0 is 1, we must clear bits[31:24]
 	 * of vmid comparator0 value (corresponding to byte 0) register.
 	 */
-	mask = drvdata->vmid_mask0;
+	mask = config->vmid_mask0;
 	for (i = 0; i < drvdata->numvmidc; i++) {
 		/* mask value of corresponding vmid comparator */
 		maskbyte = mask & ETMv4_EVENT_MASK;
@@ -1881,13 +1959,13 @@ static ssize_t vmid_masks_store(struct device *dev,
 		 */
 		for (j = 0; j < 8; j++) {
 			if (maskbyte & 1)
-				drvdata->vmid_val[i] &= ~(0xFF << (j * 8));
+				config->vmid_val[i] &= ~(0xFF << (j * 8));
 			maskbyte >>= 1;
 		}
 		/* Select the next vmid comparator mask value */
 		if (i == 3)
 			/* vmid comparators[4-7] */
-			mask = drvdata->vmid_mask1;
+			mask = config->vmid_mask1;
 		else
 			mask >>= 0x8;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 5cb919118d70..102e9aaf952b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -95,6 +95,7 @@ static void etm4_enable_hw(void *info)
 {
 	int i;
 	struct etmv4_drvdata *drvdata = info;
+	struct etmv4_config *config = &drvdata->config;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -109,69 +110,69 @@ static void etm4_enable_hw(void *info)
 			"timeout observed when probing at offset %#x\n",
 			TRCSTATR);
 
-	writel_relaxed(drvdata->pe_sel, drvdata->base + TRCPROCSELR);
-	writel_relaxed(drvdata->cfg, drvdata->base + TRCCONFIGR);
+	writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
+	writel_relaxed(config->cfg, drvdata->base + TRCCONFIGR);
 	/* nothing specific implemented */
 	writel_relaxed(0x0, drvdata->base + TRCAUXCTLR);
-	writel_relaxed(drvdata->eventctrl0, drvdata->base + TRCEVENTCTL0R);
-	writel_relaxed(drvdata->eventctrl1, drvdata->base + TRCEVENTCTL1R);
-	writel_relaxed(drvdata->stall_ctrl, drvdata->base + TRCSTALLCTLR);
-	writel_relaxed(drvdata->ts_ctrl, drvdata->base + TRCTSCTLR);
-	writel_relaxed(drvdata->syncfreq, drvdata->base + TRCSYNCPR);
-	writel_relaxed(drvdata->ccctlr, drvdata->base + TRCCCCTLR);
-	writel_relaxed(drvdata->bb_ctrl, drvdata->base + TRCBBCTLR);
+	writel_relaxed(config->eventctrl0, drvdata->base + TRCEVENTCTL0R);
+	writel_relaxed(config->eventctrl1, drvdata->base + TRCEVENTCTL1R);
+	writel_relaxed(config->stall_ctrl, drvdata->base + TRCSTALLCTLR);
+	writel_relaxed(config->ts_ctrl, drvdata->base + TRCTSCTLR);
+	writel_relaxed(config->syncfreq, drvdata->base + TRCSYNCPR);
+	writel_relaxed(config->ccctlr, drvdata->base + TRCCCCTLR);
+	writel_relaxed(config->bb_ctrl, drvdata->base + TRCBBCTLR);
 	writel_relaxed(drvdata->trcid, drvdata->base + TRCTRACEIDR);
-	writel_relaxed(drvdata->vinst_ctrl, drvdata->base + TRCVICTLR);
-	writel_relaxed(drvdata->viiectlr, drvdata->base + TRCVIIECTLR);
-	writel_relaxed(drvdata->vissctlr,
+	writel_relaxed(config->vinst_ctrl, drvdata->base + TRCVICTLR);
+	writel_relaxed(config->viiectlr, drvdata->base + TRCVIIECTLR);
+	writel_relaxed(config->vissctlr,
 		       drvdata->base + TRCVISSCTLR);
-	writel_relaxed(drvdata->vipcssctlr,
+	writel_relaxed(config->vipcssctlr,
 		       drvdata->base + TRCVIPCSSCTLR);
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
-		writel_relaxed(drvdata->seq_ctrl[i],
+		writel_relaxed(config->seq_ctrl[i],
 			       drvdata->base + TRCSEQEVRn(i));
-	writel_relaxed(drvdata->seq_rst, drvdata->base + TRCSEQRSTEVR);
-	writel_relaxed(drvdata->seq_state, drvdata->base + TRCSEQSTR);
-	writel_relaxed(drvdata->ext_inp, drvdata->base + TRCEXTINSELR);
+	writel_relaxed(config->seq_rst, drvdata->base + TRCSEQRSTEVR);
+	writel_relaxed(config->seq_state, drvdata->base + TRCSEQSTR);
+	writel_relaxed(config->ext_inp, drvdata->base + TRCEXTINSELR);
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		writel_relaxed(drvdata->cntrldvr[i],
+		writel_relaxed(config->cntrldvr[i],
 			       drvdata->base + TRCCNTRLDVRn(i));
-		writel_relaxed(drvdata->cntr_ctrl[i],
+		writel_relaxed(config->cntr_ctrl[i],
 			       drvdata->base + TRCCNTCTLRn(i));
-		writel_relaxed(drvdata->cntr_val[i],
+		writel_relaxed(config->cntr_val[i],
 			       drvdata->base + TRCCNTVRn(i));
 	}
 
 	/* Resource selector pair 0 is always implemented and reserved */
-	for (i = 2; i < drvdata->nr_resource * 2; i++)
-		writel_relaxed(drvdata->res_ctrl[i],
+	for (i = 0; i < drvdata->nr_resource * 2; i++)
+		writel_relaxed(config->res_ctrl[i],
 			       drvdata->base + TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-		writel_relaxed(drvdata->ss_ctrl[i],
+		writel_relaxed(config->ss_ctrl[i],
 			       drvdata->base + TRCSSCCRn(i));
-		writel_relaxed(drvdata->ss_status[i],
+		writel_relaxed(config->ss_status[i],
 			       drvdata->base + TRCSSCSRn(i));
-		writel_relaxed(drvdata->ss_pe_cmp[i],
+		writel_relaxed(config->ss_pe_cmp[i],
 			       drvdata->base + TRCSSPCICRn(i));
 	}
 	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
-		writeq_relaxed(drvdata->addr_val[i],
+		writeq_relaxed(config->addr_val[i],
 			       drvdata->base + TRCACVRn(i));
-		writeq_relaxed(drvdata->addr_acc[i],
+		writeq_relaxed(config->addr_acc[i],
 			       drvdata->base + TRCACATRn(i));
 	}
 	for (i = 0; i < drvdata->numcidc; i++)
-		writeq_relaxed(drvdata->ctxid_pid[i],
+		writeq_relaxed(config->ctxid_pid[i],
 			       drvdata->base + TRCCIDCVRn(i));
-	writel_relaxed(drvdata->ctxid_mask0, drvdata->base + TRCCIDCCTLR0);
-	writel_relaxed(drvdata->ctxid_mask1, drvdata->base + TRCCIDCCTLR1);
+	writel_relaxed(config->ctxid_mask0, drvdata->base + TRCCIDCCTLR0);
+	writel_relaxed(config->ctxid_mask1, drvdata->base + TRCCIDCCTLR1);
 
 	for (i = 0; i < drvdata->numvmidc; i++)
-		writeq_relaxed(drvdata->vmid_val[i],
+		writeq_relaxed(config->vmid_val[i],
 			       drvdata->base + TRCVMIDCVRn(i));
-	writel_relaxed(drvdata->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
-	writel_relaxed(drvdata->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
+	writel_relaxed(config->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
+	writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
 
 	/* Enable the trace unit */
 	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
@@ -438,83 +439,84 @@ static void etm4_init_arch_data(void *info)
 static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
 {
 	int i;
+	struct etmv4_config *config = &drvdata->config;
 
-	drvdata->pe_sel = 0x0;
-	drvdata->cfg = (ETMv4_MODE_CTXID | ETM_MODE_VMID |
+	config->pe_sel = 0x0;
+	config->cfg = (ETMv4_MODE_CTXID | ETM_MODE_VMID |
 			ETMv4_MODE_TIMESTAMP | ETM_MODE_RETURNSTACK);
 
 	/* disable all events tracing */
-	drvdata->eventctrl0 = 0x0;
-	drvdata->eventctrl1 = 0x0;
+	config->eventctrl0 = 0x0;
+	config->eventctrl1 = 0x0;
 
 	/* disable stalling */
-	drvdata->stall_ctrl = 0x0;
+	config->stall_ctrl = 0x0;
 
 	/* disable timestamp event */
-	drvdata->ts_ctrl = 0x0;
+	config->ts_ctrl = 0x0;
 
 	/* enable trace synchronization every 4096 bytes for trace */
 	if (drvdata->syncpr == false)
-		drvdata->syncfreq = 0xC;
+		config->syncfreq = 0xC;
 
 	/*
 	 *  enable viewInst to trace everything with start-stop logic in
 	 *  started state
 	 */
-	drvdata->vinst_ctrl |= BIT(0);
+	config->vinst_ctrl |= BIT(0);
 	/* set initial state of start-stop logic */
 	if (drvdata->nr_addr_cmp)
-		drvdata->vinst_ctrl |= BIT(9);
+		config->vinst_ctrl |= BIT(9);
 
 	/* no address range filtering for ViewInst */
-	drvdata->viiectlr = 0x0;
+	config->viiectlr = 0x0;
 	/* no start-stop filtering for ViewInst */
-	drvdata->vissctlr = 0x0;
+	config->vissctlr = 0x0;
 
 	/* disable seq events */
 	for (i = 0; i < drvdata->nrseqstate-1; i++)
-		drvdata->seq_ctrl[i] = 0x0;
-	drvdata->seq_rst = 0x0;
-	drvdata->seq_state = 0x0;
+		config->seq_ctrl[i] = 0x0;
+	config->seq_rst = 0x0;
+	config->seq_state = 0x0;
 
 	/* disable external input events */
-	drvdata->ext_inp = 0x0;
+	config->ext_inp = 0x0;
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
-		drvdata->cntrldvr[i] = 0x0;
-		drvdata->cntr_ctrl[i] = 0x0;
-		drvdata->cntr_val[i] = 0x0;
+		config->cntrldvr[i] = 0x0;
+		config->cntr_ctrl[i] = 0x0;
+		config->cntr_val[i] = 0x0;
 	}
 
 	/* Resource selector pair 0 is always implemented and reserved */
-	drvdata->res_idx = 0x2;
+	config->res_idx = 0x2;
 	for (i = 2; i < drvdata->nr_resource * 2; i++)
-		drvdata->res_ctrl[i] = 0x0;
+		config->res_ctrl[i] = 0x0;
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-		drvdata->ss_ctrl[i] = 0x0;
-		drvdata->ss_pe_cmp[i] = 0x0;
+		config->ss_ctrl[i] = 0x0;
+		config->ss_pe_cmp[i] = 0x0;
 	}
 
 	if (drvdata->nr_addr_cmp >= 1) {
-		drvdata->addr_val[0] = (unsigned long)_stext;
-		drvdata->addr_val[1] = (unsigned long)_etext;
-		drvdata->addr_type[0] = ETM_ADDR_TYPE_RANGE;
-		drvdata->addr_type[1] = ETM_ADDR_TYPE_RANGE;
+		config->addr_val[0] = (unsigned long)_stext;
+		config->addr_val[1] = (unsigned long)_etext;
+		config->addr_type[0] = ETM_ADDR_TYPE_RANGE;
+		config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
 	}
 
 	for (i = 0; i < drvdata->numcidc; i++) {
-		drvdata->ctxid_pid[i] = 0x0;
-		drvdata->ctxid_vpid[i] = 0x0;
+		config->ctxid_pid[i] = 0x0;
+		config->ctxid_vpid[i] = 0x0;
 	}
 
-	drvdata->ctxid_mask0 = 0x0;
-	drvdata->ctxid_mask1 = 0x0;
+	config->ctxid_mask0 = 0x0;
+	config->ctxid_mask1 = 0x0;
 
 	for (i = 0; i < drvdata->numvmidc; i++)
-		drvdata->vmid_val[i] = 0x0;
-	drvdata->vmid_mask0 = 0x0;
-	drvdata->vmid_mask1 = 0x0;
+		config->vmid_val[i] = 0x0;
+	config->vmid_mask0 = 0x0;
+	config->vmid_mask1 = 0x0;
 
 	/*
 	 * A trace ID value of 0 is invalid, so let's start at some
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index e6ff9aae2a7e..709d96e63910 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -180,66 +180,19 @@
 #define TRCSTATR_IDLE_BIT		0
 
 /**
- * struct etm4_drvdata - specifics associated to an ETM component
- * @base:       Memory mapped base address for this component.
- * @dev:        The device entity associated to this component.
- * @csdev:      Component vitals needed by the framework.
- * @spinlock:   Only one at a time pls.
- * @cpu:        The cpu this component is affined to.
- * @arch:       ETM version number.
- * @enable:	Is this ETM currently tracing.
- * @sticky_enable: true if ETM base configuration has been done.
- * @boot_enable:True if we should start tracing at boot time.
- * @os_unlock:  True if access to management registers is allowed.
- * @nr_pe:	The number of processing entity available for tracing.
- * @nr_pe_cmp:	The number of processing entity comparator inputs that are
- *		available for tracing.
- * @nr_addr_cmp:Number of pairs of address comparators available
- *		as found in ETMIDR4 0-3.
- * @nr_cntr:    Number of counters as found in ETMIDR5 bit 28-30.
- * @nr_ext_inp: Number of external input.
- * @numcidc:	Number of contextID comparators.
- * @numvmidc:	Number of VMID comparators.
- * @nrseqstate: The number of sequencer states that are implemented.
- * @nr_event:	Indicates how many events the trace unit support.
- * @nr_resource:The number of resource selection pairs available for tracing.
- * @nr_ss_cmp:	Number of single-shot comparator controls that are available.
+ * struct etmv4_config - configuration information related to an ETMv4
  * @mode:	Controls various modes supported by this ETM.
- * @trcid:	value of the current ID for this component.
- * @trcid_size: Indicates the trace ID width.
- * @instrp0:	Tracing of load and store instructions
- *		as P0 elements is supported.
- * @trccond:	If the trace unit supports conditional
- *		instruction tracing.
- * @retstack:	Indicates if the implementation supports a return stack.
- * @trc_error:	Whether a trace unit can trace a system
- *		error exception.
- * @atbtrig:	If the implementation can support ATB triggers
- * @lpoverride:	If the implementation can support low-power state over.
  * @pe_sel:	Controls which PE to trace.
  * @cfg:	Controls the tracing options.
  * @eventctrl0: Controls the tracing of arbitrary events.
  * @eventctrl1: Controls the behavior of the events that @event_ctrl0 selects.
  * @stallctl:	If functionality that prevents trace unit buffer overflows
  *		is available.
- * @sysstall:	Does the system support stall control of the PE?
- * @nooverflow:	Indicate if overflow prevention is supported.
- * @stall_ctrl:	Enables trace unit functionality that prevents trace
- *		unit buffer overflows.
- * @ts_size:	Global timestamp size field.
  * @ts_ctrl:	Controls the insertion of global timestamps in the
  *		trace streams.
- * @syncpr:	Indicates if an implementation has a fixed
- *		synchronization period.
  * @syncfreq:	Controls how often trace synchronization requests occur.
- * @trccci:	Indicates if the trace unit supports cycle counting
- *		for instruction.
- * @ccsize:	Indicates the size of the cycle counter in bits.
- * @ccitmin:	minimum value that can be programmed in
  *		the TRCCCCTLR register.
  * @ccctlr:	Sets the threshold value for cycle counting.
- * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
- * @q_support:	Q element support characteristics.
  * @vinst_ctrl:	Controls instruction trace filtering.
  * @viiectlr:	Set or read, the address range comparators.
  * @vissctlr:	Set, or read, the single address comparators that control the
@@ -264,73 +217,28 @@
  * @addr_acc:	Address comparator access type.
  * @addr_type:	Current status of the comparator register.
  * @ctxid_idx:	Context ID index selector.
- * @ctxid_size:	Size of the context ID field to consider.
  * @ctxid_pid:	Value of the context ID comparator.
  * @ctxid_vpid:	Virtual PID seen by users if PID namespace is enabled, otherwise
  *		the same value of ctxid_pid.
  * @ctxid_mask0:Context ID comparator mask for comparator 0-3.
  * @ctxid_mask1:Context ID comparator mask for comparator 4-7.
  * @vmid_idx:	VM ID index selector.
- * @vmid_size:	Size of the VM ID comparator to consider.
  * @vmid_val:	Value of the VM ID comparator.
  * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
  * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
- * @s_ex_level:	In secure state, indicates whether instruction tracing is
- *		supported for the corresponding Exception level.
- * @ns_ex_level:In non-secure state, indicates whether instruction tracing is
- *		supported for the corresponding Exception level.
  * @ext_inp:	External input selection.
  */
-struct etmv4_drvdata {
-	void __iomem			*base;
-	struct device			*dev;
-	struct coresight_device		*csdev;
-	spinlock_t			spinlock;
-	int				cpu;
-	u8				arch;
-	bool				enable;
-	bool				sticky_enable;
-	bool				boot_enable;
-	bool				os_unlock;
-	u8				nr_pe;
-	u8				nr_pe_cmp;
-	u8				nr_addr_cmp;
-	u8				nr_cntr;
-	u8				nr_ext_inp;
-	u8				numcidc;
-	u8				numvmidc;
-	u8				nrseqstate;
-	u8				nr_event;
-	u8				nr_resource;
-	u8				nr_ss_cmp;
+struct etmv4_config {
 	u32				mode;
-	u8				trcid;
-	u8				trcid_size;
-	bool				instrp0;
-	bool				trccond;
-	bool				retstack;
-	bool				trc_error;
-	bool				atbtrig;
-	bool				lpoverride;
 	u32				pe_sel;
 	u32				cfg;
 	u32				eventctrl0;
 	u32				eventctrl1;
-	bool				stallctl;
-	bool				sysstall;
-	bool				nooverflow;
 	u32				stall_ctrl;
-	u8				ts_size;
 	u32				ts_ctrl;
-	bool				syncpr;
 	u32				syncfreq;
-	bool				trccci;
-	u8				ccsize;
-	u8				ccitmin;
 	u32				ccctlr;
-	bool				trcbb;
 	u32				bb_ctrl;
-	bool				q_support;
 	u32				vinst_ctrl;
 	u32				viiectlr;
 	u32				vissctlr;
@@ -353,19 +261,119 @@ struct etmv4_drvdata {
 	u64				addr_acc[ETM_MAX_SINGLE_ADDR_CMP];
 	u8				addr_type[ETM_MAX_SINGLE_ADDR_CMP];
 	u8				ctxid_idx;
-	u8				ctxid_size;
 	u64				ctxid_pid[ETMv4_MAX_CTXID_CMP];
 	u64				ctxid_vpid[ETMv4_MAX_CTXID_CMP];
 	u32				ctxid_mask0;
 	u32				ctxid_mask1;
 	u8				vmid_idx;
-	u8				vmid_size;
 	u64				vmid_val[ETM_MAX_VMID_CMP];
 	u32				vmid_mask0;
 	u32				vmid_mask1;
+	u32				ext_inp;
+};
+
+/**
+ * struct etm4_drvdata - specifics associated to an ETM component
+ * @base:       Memory mapped base address for this component.
+ * @dev:        The device entity associated to this component.
+ * @csdev:      Component vitals needed by the framework.
+ * @spinlock:   Only one at a time pls.
+ * @cpu:        The cpu this component is affined to.
+ * @arch:       ETM version number.
+ * @nr_pe:	The number of processing entity available for tracing.
+ * @nr_pe_cmp:	The number of processing entity comparator inputs that are
+ *		available for tracing.
+ * @nr_addr_cmp:Number of pairs of address comparators available
+ *		as found in ETMIDR4 0-3.
+ * @nr_cntr:    Number of counters as found in ETMIDR5 bit 28-30.
+ * @nr_ext_inp: Number of external input.
+ * @numcidc:	Number of contextID comparators.
+ * @numvmidc:	Number of VMID comparators.
+ * @nrseqstate: The number of sequencer states that are implemented.
+ * @nr_event:	Indicates how many events the trace unit support.
+ * @nr_resource:The number of resource selection pairs available for tracing.
+ * @nr_ss_cmp:	Number of single-shot comparator controls that are available.
+ * @trcid:	value of the current ID for this component.
+ * @trcid_size: Indicates the trace ID width.
+ * @ts_size:	Global timestamp size field.
+ * @ctxid_size:	Size of the context ID field to consider.
+ * @vmid_size:	Size of the VM ID comparator to consider.
+ * @ccsize:	Indicates the size of the cycle counter in bits.
+ * @ccitmin:	minimum value that can be programmed in
+ * @s_ex_level:	In secure state, indicates whether instruction tracing is
+ *		supported for the corresponding Exception level.
+ * @ns_ex_level:In non-secure state, indicates whether instruction tracing is
+ *		supported for the corresponding Exception level.
+ * @enable:	Is this ETM currently tracing.
+ * @sticky_enable: true if ETM base configuration has been done.
+ * @boot_enable:True if we should start tracing at boot time.
+ * @os_unlock:  True if access to management registers is allowed.
+ * @instrp0:	Tracing of load and store instructions
+ *		as P0 elements is supported.
+ * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
+ * @trccond:	If the trace unit supports conditional
+ *		instruction tracing.
+ * @retstack:	Indicates if the implementation supports a return stack.
+ * @trccci:	Indicates if the trace unit supports cycle counting
+ *		for instruction.
+ * @q_support:	Q element support characteristics.
+ * @trc_error:	Whether a trace unit can trace a system
+ *		error exception.
+ * @syncpr:	Indicates if an implementation has a fixed
+ *		synchronization period.
+ * @stall_ctrl:	Enables trace unit functionality that prevents trace
+ *		unit buffer overflows.
+ * @sysstall:	Does the system support stall control of the PE?
+ * @nooverflow:	Indicate if overflow prevention is supported.
+ * @atbtrig:	If the implementation can support ATB triggers
+ * @lpoverride:	If the implementation can support low-power state over.
+ * @config:	structure holding configuration parameters.
+ */
+struct etmv4_drvdata {
+	void __iomem			*base;
+	struct device			*dev;
+	struct coresight_device		*csdev;
+	spinlock_t			spinlock;
+	int				cpu;
+	u8				arch;
+	u8				nr_pe;
+	u8				nr_pe_cmp;
+	u8				nr_addr_cmp;
+	u8				nr_cntr;
+	u8				nr_ext_inp;
+	u8				numcidc;
+	u8				numvmidc;
+	u8				nrseqstate;
+	u8				nr_event;
+	u8				nr_resource;
+	u8				nr_ss_cmp;
+	u8				trcid;
+	u8				trcid_size;
+	u8				ts_size;
+	u8				ctxid_size;
+	u8				vmid_size;
+	u8				ccsize;
+	u8				ccitmin;
 	u8				s_ex_level;
 	u8				ns_ex_level;
-	u32				ext_inp;
+	bool				enable;
+	bool				sticky_enable;
+	bool				boot_enable;
+	bool				os_unlock;
+	bool				instrp0;
+	bool				trcbb;
+	bool				trccond;
+	bool				retstack;
+	bool				trccci;
+	bool				q_support;
+	bool				trc_error;
+	bool				syncpr;
+	bool				stallctl;
+	bool				sysstall;
+	bool				nooverflow;
+	bool				atbtrig;
+	bool				lpoverride;
+	struct etmv4_config		config;
 };
 
 /* Address comparator access types */
-- 
2.1.4

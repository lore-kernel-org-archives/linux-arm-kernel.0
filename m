From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 22 Jun 2016 12:14:17 +0100
Subject: [PATCH v2] coresight: etm4x: request to retain power to the trace
 unit when active
In-Reply-To: <1466590513-22505-1-git-send-email-sudeep.holla@arm.com>
References: <1466590513-22505-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1466594057-32289-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Coresight ETMv4 architecture provides a way to request to keep the
power to the trace unit. This might help to collect the traces without
the need to disable the CPU power management(entering/exiting deeper
idle states).

Trace PowerDown Control Register provides powerup request bit which when
set requests the system to retain power to the trace unit and emulate
the powerdown request.

Typically, a trace unit drives a signal to the power controller to
request that the trace unit core power domain is powered up. However,
if the trace unit and the CPU are in the same power domain then the
implementation might combine the trace unit power up status with a
signal from the CPU.

This patch requests to retain power to the trace unit when active and
to remove when inactive. Note this change will only request but the
behaviour depends on the implementation. However, it matches the
exact behaviour expected when the external debugger is connected with
respect to CPU power states.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 12 ++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +++
 2 files changed, 15 insertions(+)

Hi Mathieu,

This is tested on Juno, and on Juno the trace unit core power domain and
CPU power domain are shared. So we can manage just with the trace unit
debug power domain info from the DT as done with my Juno DT patch series.

Regards,
Sudeep

v1->v2:
	- do Read-Modify-Write of TRCPDCR as suggested by Suzuki

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d6f1d6d874eb..93a947b9c1c2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -163,6 +163,13 @@ static void etm4_enable_hw(void *info)
 	writel_relaxed(config->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
 	writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);

+	/*
+	 * Request to keep the trace unit powered and also
+	 * emulation of powerdown
+	 */
+	writel_relaxed(readl_relaxed(drvdata->base + TRCPDCR) | TRCPDCR_PU,
+		       drvdata->base + TRCPDCR);
+
 	/* Enable the trace unit */
 	writel_relaxed(1, drvdata->base + TRCPRGCTLR);

@@ -293,6 +300,11 @@ static void etm4_disable_hw(void *info)

 	CS_UNLOCK(drvdata->base);

+	/* power can be removed from the trace unit now */
+	control = readl_relaxed(drvdata->base + TRCPDCR);
+	control &= ~TRCPDCR_PU;
+	writel_relaxed(control, drvdata->base + TRCPDCR);
+
 	control = readl_relaxed(drvdata->base + TRCPRGCTLR);

 	/* EN, bit[0] Trace unit enable bit */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 5359c5197c1d..2629954429a1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -183,6 +183,9 @@
 #define TRCSTATR_IDLE_BIT		0
 #define ETM_DEFAULT_ADDR_COMP		0

+/* PowerDown Control Register bits */
+#define TRCPDCR_PU			BIT(3)
+
 /* secure state access levels */
 #define ETM_EXLEVEL_S_APP		BIT(8)
 #define ETM_EXLEVEL_S_OS		BIT(9)
--
2.7.4

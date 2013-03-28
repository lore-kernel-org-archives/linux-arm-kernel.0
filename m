From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Thu, 28 Mar 2013 17:11:27 +0100
Subject: [PATCH V2 01/12] mfd: db8500: Add IO force function
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Message-ID: <1364487098-10319-2-git-send-email-rickard.andersson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IO force signal needs to be controlled when
the system enters/exits the sleep state ApSleep.
This hardware signal tells the system that some
pins could be driven by GPIO settings instead of
directly from the hardware block.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/mfd/db8500-prcmu.c       | 9 +++++++++
 include/linux/mfd/db8500-prcmu.h | 1 +
 include/linux/mfd/dbx500-prcmu.h | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 268f45d..7f32575 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -879,6 +879,15 @@ bool db8500_prcmu_pending_irq(void)
 	return false;
 }
 
+void db8500_prcmu_set_ioforce(bool enable)
+{
+	u32 val = readl(PRCM_IOCR) & ~PRCM_IOCR_IOFORCE;
+
+	if (enable)
+		val |= PRCM_IOCR_IOFORCE;
+	writel(val, PRCM_IOCR);
+}
+
 /*
  * This function checks if the specified cpu is in in WFI. It's usage
  * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 6ee4247..21660f6 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -547,6 +547,7 @@ int db8500_prcmu_gic_recouple(void);
 int db8500_prcmu_copy_gic_settings(void);
 bool db8500_prcmu_gic_pending_irq(void);
 bool db8500_prcmu_pending_irq(void);
+void db8500_prcmu_set_ioforce(bool enable);
 bool db8500_prcmu_is_cpu_in_wfi(int cpu);
 void db8500_prcmu_enable_wakeups(u32 wakeups);
 int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index c202d6c..2909546 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -267,6 +267,11 @@ static inline bool prcmu_pending_irq(void)
 	return db8500_prcmu_pending_irq();
 }
 
+static inline void prcmu_set_ioforce(bool force)
+{
+	return db8500_prcmu_set_ioforce(force);
+}
+
 static inline int prcmu_set_epod(u16 epod_id, u8 epod_state)
 {
 	return db8500_prcmu_set_epod(epod_id, epod_state);
-- 
1.8.2

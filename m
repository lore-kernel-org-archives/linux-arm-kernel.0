From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:17 +0800
Subject: [PATCH v2 11/11] USB: chipidea: re-order irq handling to avoid
 unhandled irq
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-12-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- let role driver handle irq before ID change check. It give the
  role driver a chance to handle disconnect.
- disable irq during switch role. No role driver to handle irq in
  the period.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/core.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7485c84..0942b9b 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -279,6 +279,7 @@ static void ci_role_work(struct work_struct *work)
 
 		ci_role_stop(ci);
 		ci_role_start(ci, role);
+		enable_irq(ci->irq);
 	}
 }
 
@@ -318,18 +319,22 @@ static irqreturn_t ci_irq(int irq, void *data)
 {
 	struct ci13xxx *ci = data;
 	irqreturn_t ret = IRQ_NONE;
+	u32 otgsc = 0;
 
-	if (ci->is_otg) {
-		u32 sts = hw_read(ci, OP_OTGSC, ~0);
+	if (ci->is_otg)
+		otgsc = hw_read(ci, OP_OTGSC, ~0);
 
-		if (sts & OTGSC_IDIS) {
-			hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);
-			queue_work(ci->wq, &ci->work);
-			ret = IRQ_HANDLED;
-		}
+	if (ci->role != CI_ROLE_END)
+		ret = ci_role(ci)->irq(ci);
+
+	if (ci->is_otg && (otgsc & OTGSC_IDIS)) {
+		hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);
+		disable_irq_nosync(ci->irq);
+		queue_work(ci->wq, &ci->work);
+		ret = IRQ_HANDLED;
 	}
 
-	return ci->role == CI_ROLE_END ? ret : ci_role(ci)->irq(ci);
+	return ret;
 }
 
 static DEFINE_IDA(ci_ida);
-- 
1.7.9.5

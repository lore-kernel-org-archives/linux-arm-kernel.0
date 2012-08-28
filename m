From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 15:03:09 +0800
Subject: [PATCH v2 03/11] USB: chipidea: move OTGSC_IDIS clearing from
 ci_role_work to irq handler
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137397-32374-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OTGSC_IDIS must be cleared in irq handler to avoid re-queue the work.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3c3ed77..19ef324 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -273,8 +273,6 @@ static void ci_role_work(struct work_struct *work)
 	struct ci13xxx *ci = container_of(work, struct ci13xxx, work);
 	enum ci_role role = ci_otg_role(ci);
 
-	hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);
-
 	if (role != ci->role) {
 		dev_dbg(ci->dev, "switching from %s to %s\n",
 			ci_role(ci)->name, ci->roles[role]->name);
@@ -325,6 +323,7 @@ static irqreturn_t ci_irq(int irq, void *data)
 		u32 sts = hw_read(ci, OP_OTGSC, ~0);
 
 		if (sts & OTGSC_IDIS) {
+			hw_write(ci, OP_OTGSC, OTGSC_IDIS, OTGSC_IDIS);
 			queue_work(ci->wq, &ci->work);
 			ret = IRQ_HANDLED;
 		}
-- 
1.7.9.5

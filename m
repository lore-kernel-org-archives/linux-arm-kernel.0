From: jgutierrez@ti.com (Juan Gutierrez)
Date: Fri, 13 Apr 2012 18:39:50 -0500
Subject: [PATCH v2 1/3] omap: mailbox: enable mailbox irq per instance
In-Reply-To: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
Message-ID: <1334360392-1494-2-git-send-email-jgutierrez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine-specific omap2_mbox_startup is called only once
to initialize the whole mbox module. Enabling mbox irq at
startup is only enabling the irq of the very first mailbox
instance created.

The enable_irq function should be called every time a
new mbox instance is created, in the generic platform
mailbox layer.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 --
 arch/arm/plat-omap/mailbox.c  |    3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 415a6f1..f727034 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -83,8 +83,6 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	l = mbox_read_reg(MAILBOX_REVISION);
 	pr_debug("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
 
-	omap2_mbox_enable_irq(mbox, IRQ_RX);
-
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index ad32621..ebc1ba5 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -282,6 +282,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		}
 		mbox->rxq = mq;
 		mq->mbox = mbox;
+
+		mbox->ops->enable_irq(mbox, IRQ_RX);
 	}
 	mutex_unlock(&mbox_configured_lock);
 	return 0;
@@ -305,6 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mutex_lock(&mbox_configured_lock);
 
 	if (!--mbox->use_count) {
+		mbox->ops->disable_irq(mbox, IRQ_RX);
 		free_irq(mbox->irq, mbox);
 		tasklet_kill(&mbox->txq->tasklet);
 		flush_work_sync(&mbox->rxq->work);
-- 
1.7.1

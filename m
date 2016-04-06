From: s-anna@ti.com (Suman Anna)
Date: Wed, 6 Apr 2016 18:37:17 -0500
Subject: [PATCH 1/4] mailbox/omap: store mailbox interrupt type in
 omap_mbox_device
In-Reply-To: <1459985840-1106-1-git-send-email-s-anna@ti.com>
References: <1459985840-1106-1-git-send-email-s-anna@ti.com>
Message-ID: <1459985840-1106-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt type used for identifying the layout of the interrupt
configuration registers between OMAP4+ SoCs and older SoCs is stored
only in the sub-mailbox structures for easier access. Store this type
in the the omap_mbox_device structure as well along with the other
global variables. This is being done to facilitate the context save
and restore of appropriate registers during system suspend/resume.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 84cafc02e761..adf37f494690 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -90,6 +90,7 @@ struct omap_mbox_device {
 	void __iomem *mbox_base;
 	u32 num_users;
 	u32 num_fifos;
+	u32 intr_type;
 	struct omap_mbox **mboxes;
 	struct mbox_controller controller;
 	struct list_head elem;
@@ -828,6 +829,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	mdev->dev = &pdev->dev;
 	mdev->num_users = num_users;
 	mdev->num_fifos = num_fifos;
+	mdev->intr_type = intr_type;
 	mdev->mboxes = list;
 
 	/* OMAP does not have a Tx-Done IRQ, but rather a Tx-Ready IRQ */
-- 
2.7.4

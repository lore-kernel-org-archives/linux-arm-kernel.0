From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu,  1 Mar 2012 10:11:35 +0200
Subject: [PATCH 5/7] remoteproc/omap: remove the mbox_callback limitation
In-Reply-To: <1330589497-4139-1-git-send-email-ohad@wizery.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
Message-ID: <1330589497-4139-6-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that remoteproc supports any number of virtio devices,
the previous sanity check in omap_rproc_mbox_callback
doesn't make sense anymore.

Remove that so we can start supporting multiple vdevs.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Iliyan Malchev <malchev@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mark Grosen <mgrosen@ti.com>
Cc: John Williams <john.williams@petalogix.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Loic PALLARDY <loic.pallardy@stericsson.com>
Cc: Ludovic BARRE <ludovic.barre@stericsson.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Guzman Lugo Fernando <fernando.lugo@ti.com>
Cc: Anna Suman <s-anna@ti.com>
Cc: Clark Rob <rob@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Kieran Bingham <kieranbingham@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/remoteproc/omap_remoteproc.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index aa3ce52..69425c4 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -80,16 +80,7 @@ static int omap_rproc_mbox_callback(struct notifier_block *this,
 		dev_info(dev, "received echo reply from %s\n", name);
 		break;
 	default:
-		/* ignore vq indices which are too large to be valid */
-		if (msg >= 2) {
-			dev_warn(dev, "invalid mbox msg: 0x%x\n", msg);
-			break;
-		}
-
-		/*
-		 * At this point, 'msg' contains the index of the vring
-		 * which was just triggered.
-		 */
+		/* msg contains the index of the triggered vring */
 		if (rproc_vq_interrupt(oproc->rproc, msg) == IRQ_NONE)
 			dev_dbg(dev, "no message was found in vqid %d\n", msg);
 	}
-- 
1.7.5.4

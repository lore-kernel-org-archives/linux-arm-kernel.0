From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 17 Feb 2013 17:24:42 +0800
Subject: [PATCH v9 8/9] usb: chipidea: tell platform layer the ci core probe's
 result
In-Reply-To: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1361093083-22940-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the probe fails, the ci13xxx_add_device will not return error,
(bus_probe_device doesn't has return value)
therefore, the platform layer can't know whether core's probe
is successful or not, if platform layer goes on using core's struct
which is initialized at core's probe, the error will occur.

This error is showed when I only compile gadget, the host-only
controller reports "no supported roles", and fails probe, but imx
platform code doesn't know it, and goes on using core's private data.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c  |    2 ++
 include/linux/usb/chipidea.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 6cc6069..45fa227 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -689,6 +689,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	/* Defer some operations */
 	queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(200));
 
+	ci->platdata->probe_retval = ret;
 	return ret;
 
 free_irq:
@@ -704,6 +705,7 @@ rm_wq:
 	flush_workqueue(ci->wq);
 	destroy_workqueue(ci->wq);
 
+	ci->platdata->probe_retval = ret;
 	return ret;
 }
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index d543e4a..8f61e97 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -23,6 +23,7 @@ struct ci13xxx_platform_data {
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
 	void	(*notify_event) (struct ci13xxx *ci, unsigned event);
+	int probe_retval; /* tell platform layer ci core probe's result */
 };
 
 /* Default offset of capability registers */
-- 
1.7.0.4

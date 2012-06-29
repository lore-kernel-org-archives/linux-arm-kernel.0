From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 29 Jun 2012 17:48:49 +0800
Subject: [PATCH v8 01/14] usb: chipidea: remove unneeded NULL check
In-Reply-To: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
References: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340963342-28735-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

As reported by Dan Carpenter, there is a NULL check in udc_start() that
follows a dereference of the pointer that's being checked. However, at
that point udc pointer shouldn't ever be NULL and if it is, the dereference
should cause an oops.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Marek Vasut <marex@denx.de>
---
 drivers/usb/chipidea/udc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 51f9694..cdb9212 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1647,9 +1647,6 @@ static int udc_start(struct ci13xxx *udc)
 	struct device *dev = udc->dev;
 	int retval = 0;
 
-	if (!udc)
-		return -EINVAL;
-
 	spin_lock_init(&udc->lock);
 
 	udc->gadget.ops          = &usb_gadget_ops;
-- 
1.7.9.5

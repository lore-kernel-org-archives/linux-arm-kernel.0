From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 14:27:42 +0100
Subject: [PATCH 7/7] s3c-hsudc: use release_mem_region instead of
 release_resource
In-Reply-To: <201112191423.21461.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
Message-ID: <201112191427.43121.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the memory region is requested through request_mem_region
use the correct paired method to release it in the error path
and don't go "beneath the API" as pointed out by Russel King.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index d6544f6..af1e700 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1376,9 +1376,7 @@ err_irq:
 	iounmap(hsudc->regs);
 
 err_remap:
-	release_resource(hsudc->mem_rsrc);
-	kfree(hsudc->mem_rsrc);
-
+	release_mem_region(res->start, resource_size(res));
 err_res:
 	if (hsudc->transceiver)
 		otg_put_transceiver(hsudc->transceiver);
-- 
1.7.5.4

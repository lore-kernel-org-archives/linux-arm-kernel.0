From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 12 Jun 2015 09:16:03 +0200
Subject: [RESEND PATCH v4 11/14] crypto: marvell/CESA: add allhwsupport module
 parameter
In-Reply-To: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1434093366-14681-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old and new marvell CESA drivers both support Orion and Kirkwood SoCs.
Add a module parameter to choose whether these SoCs should be attached to
the new or the old driver.

The default policy is to keep attaching those IPs to the old driver if it
is enabled, until we decide the new CESA driver is stable/secure enough.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/crypto/marvell/cesa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index 087370e..c7e25a0 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -31,6 +31,10 @@
 
 #include "cesa.h"
 
+static int allhwsupport = !IS_ENABLED(CONFIG_CRYPTO_DEV_MV_CESA);
+module_param_named(allhwsupport, allhwsupport, int, 0444);
+MODULE_PARM_DESC(allhwsupport, "Enable support for all hardware (even it if overlaps with the mv_cesa driver)");
+
 struct mv_cesa_dev *cesa_dev;
 
 static void mv_cesa_dequeue_req_unlocked(struct mv_cesa_engine *engine)
-- 
1.9.1

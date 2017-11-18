From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 14:40:12 +0530
Subject: [PATCH 1/2 v2] misc: aspeed-lpc-snoop: Fix platform_get_irq's error
 checking
Message-ID: <6e238a28aa79c581c90329060805c0b07e2187a7.1510995185.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ 0 is not valid.

 drivers/misc/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/misc/aspeed-lpc-snoop.c
index cb78c98..14c3c90 100644
--- a/drivers/misc/aspeed-lpc-snoop.c
+++ b/drivers/misc/aspeed-lpc-snoop.c
@@ -115,8 +115,8 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
-		return -ENODEV;
+	if (lpc_snoop->irq <= 0)
+		return lpc_snoop->irq;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
 			      aspeed_lpc_snoop_irq, IRQF_SHARED,
-- 
2.7.4

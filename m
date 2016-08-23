From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Tue, 23 Aug 2016 20:28:54 +0530
Subject: [PATCH] crypto: rockchip - use devm_add_action_or_reset()
Message-ID: <1471964334-27060-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If devm_add_action() fails we are explicitly calling the cleanup to free
the resources allocated.  Lets use the helper devm_add_action_or_reset()
and return directly in case of error, as we know that the cleanup function
has been already called by the helper if there was any error.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index af50825..d0f80c6 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -304,11 +304,9 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	usleep_range(10, 20);
 	reset_control_deassert(crypto_info->rst);
 
-	err = devm_add_action(dev, rk_crypto_action, crypto_info);
-	if (err) {
-		reset_control_assert(crypto_info->rst);
+	err = devm_add_action_or_reset(dev, rk_crypto_action, crypto_info);
+	if (err)
 		goto err_crypto;
-	}
 
 	spin_lock_init(&crypto_info->lock);
 
-- 
1.9.1

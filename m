From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Sep 2017 11:35:38 +0200
Subject: [PATCH 1/2] crypto: stm32 - Fix uninitialized data usage
Message-ID: <20170912093553.2580986-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error handling in stm32_hash_irq_thread passes
uninitialized data into stm32_hash_finish_req, as gcc
points out:

drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_irq_thread':
drivers/crypto/stm32/stm32-hash.c:1088:2: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I could not tell what data should be passed there instead,
so this changes the code to always pass zero, making it
well-defined, though possibly still wrong. Please check.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/stm32/stm32-hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index b585ce54a802..3c23a23e9ee5 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1067,7 +1067,6 @@ static int stm32_hash_cra_sha256_init(struct crypto_tfm *tfm)
 static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 {
 	struct stm32_hash_dev *hdev = dev_id;
-	int err;
 
 	if (HASH_FLAGS_CPU & hdev->flags) {
 		if (HASH_FLAGS_OUTPUT_READY & hdev->flags) {
@@ -1085,7 +1084,7 @@ static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 
 finish:
 	/*Finish current request */
-	stm32_hash_finish_req(hdev->req, err);
+	stm32_hash_finish_req(hdev->req, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.9.0

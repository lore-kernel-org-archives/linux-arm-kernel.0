From: lionel.debieve@st.com (Lionel Debieve)
Date: Fri, 18 Aug 2017 15:54:01 +0200
Subject: [PATCH 1/1] crypto: stm32/hash - Remove uninitialized symbol
Message-ID: <1503064441-19964-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove err symbol as this is not used in the thread context
and the variable is not initialized.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index b585ce5..b34ee85 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1067,7 +1067,6 @@ static int stm32_hash_cra_sha256_init(struct crypto_tfm *tfm)
 static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 {
 	struct stm32_hash_dev *hdev = dev_id;
-	int err;
 
 	if (HASH_FLAGS_CPU & hdev->flags) {
 		if (HASH_FLAGS_OUTPUT_READY & hdev->flags) {
@@ -1084,8 +1083,8 @@ static irqreturn_t stm32_hash_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 
 finish:
-	/*Finish current request */
-	stm32_hash_finish_req(hdev->req, err);
+	/* Finish current request */
+	stm32_hash_finish_req(hdev->req, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

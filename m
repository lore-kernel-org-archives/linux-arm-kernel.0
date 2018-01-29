From: lionel.Debieve@st.com (Lionel Debieve)
Date: Mon, 29 Jan 2018 15:28:11 +0100
Subject: [PATCH 3/3] crypto: stm32/hash: rework padding length
In-Reply-To: <20180129142811.13273-1-lionel.Debieve@st.com>
References: <20180129142811.13273-1-lionel.Debieve@st.com>
Message-ID: <20180129142811.13273-4-lionel.Debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lionel Debieve <lionel.debieve@st.com>

Due to another patch, the dma fails when padding is
needed as the given length is not correct.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d8444aeb6609..80b9ec76bbb5 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -626,7 +626,7 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 			writesl(hdev->io_base + HASH_DIN, buffer,
 				DIV_ROUND_UP(ncp, sizeof(u32)));
 		}
-		stm32_hash_set_nblw(hdev, DIV_ROUND_UP(ncp, sizeof(u32)));
+		stm32_hash_set_nblw(hdev, ncp);
 		reg = stm32_hash_read(hdev, HASH_STR);
 		reg |= HASH_STR_DCAL;
 		stm32_hash_write(hdev, HASH_STR, reg);
-- 
2.15.1

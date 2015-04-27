From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Apr 2015 09:22:28 +0000
Subject: [PATCH] spi: sirf: replace BUG condition by error code for
 unsupported transfer
Message-ID: <1430126548-8171-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

return error for unsupported bits-per-word format, BUG() is not right
for this scenerios as we are not an ASSERT but an error handler.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <baohua.song@csr.com>
---
 drivers/spi/spi-sirf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index f5715c9..a50ee9b 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -559,7 +559,8 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		sspi->tx_word = spi_sirfsoc_tx_word_u32;
 		break;
 	default:
-		BUG();
+		dev_err(&spi->dev, "bpw %d not supported\n", bits_per_word);
+		return -EINVAL;
 	}
 
 	sspi->word_width = DIV_ROUND_UP(bits_per_word, 8);
-- 
1.9.1

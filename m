From: drinkcat@chromium.org (Nicolas Boichat)
Date: Tue,  4 Aug 2015 14:09:58 +0800
Subject: [PATCH 3/3] spi: s3c24xx: Convert spinlock to mutex
In-Reply-To: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Message-ID: <1438668598-6678-3-git-send-email-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bitbang->lock is now a mutex: replace spinlock function calls
by mutex functions.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/spi/spi-s3c24xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index f36bc32..b1d03e5 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -198,12 +198,11 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	spin_lock(&hw->bitbang.lock);
-	if (!hw->bitbang.busy) {
+	if (mutex_trylock(&hw->bitbang.lock)) {
 		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
 		/* need to ndelay for 0.5 clocktick ? */
+		mutex_unlock(&hw->bitbang.lock);
 	}
-	spin_unlock(&hw->bitbang.lock);
 
 	return 0;
 }
-- 
2.5.0.rc2.392.g76e840b

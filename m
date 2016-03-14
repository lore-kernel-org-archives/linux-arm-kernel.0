From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Mar 2016 23:46:55 +0100
Subject: [PATCH] mailbox: rockchip: avoid 64-bit division
Message-ID: <1457995629-1480353-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added rockchip mailbox driver causes a bug in
the ARM allyesconfig build because of a division of a resource_size_t
variable that may be 64 bit wide:

drivers/mailbox/built-in.o: In function `rockchip_mbox_probe':
:(.text+0x6614): undefined reference to `__aeabi_uldivmod'

This adds a cast to size_t, which turns it into a 32-bit division
in this case. This is safe because we know that we cannot possibly
map a resource that is longer than what a pointer contains, and
in practice it will be very short instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mailbox/rockchip-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index b79a2871227c..d702a204f5c1 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -213,7 +213,7 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 		return PTR_ERR(mb->mbox_base);
 
 	/* Each channel has two buffers for A2B and B2A */
-	mb->buf_size = resource_size(res) / (drv_data->num_chans * 2);
+	mb->buf_size = (size_t)resource_size(res) / (drv_data->num_chans * 2);
 
 	mb->pclk = devm_clk_get(&pdev->dev, "pclk_mailbox");
 	if (IS_ERR(mb->pclk)) {
-- 
2.7.0

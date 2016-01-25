From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:53:48 +0100
Subject: [PATCH 1/4] crypto: sunxi - don't print uninitialized data
Message-ID: <1453740845-1980433-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc correctly warns that the printk output contains a variable that
is not initialized in some cases:

drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In function 'sun4i_ss_cipher_poll':
drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:254:76: warning: 'todo' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15: note: 'todo' was declared here

This adds an explicit initialization to zero in the exact case where it
was missing, to avoid leaking stack data to the console and to shut up
that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
index a19ee127edca..db52ae16c147 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
@@ -246,6 +246,8 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
 				sg_miter_next(&mi);
 				oi = 0;
 			}
+		} else {
+			todo = 0;
 		}
 
 		spaces = readl(ss->base + SS_FCSR);
-- 
2.7.0

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  9 Jul 2018 16:56:03 +0200
Subject: [PATCH] gpio: aspeed: fix compile testing warning
Message-ID: <20180709145612.4166409-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gcc cannot always see that BUG_ON(1) is guaranteed to not
return, so we get a warning message in some configurations:

drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]

Using a plain BUG() is easier here and avoids the problem.

Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 1e00f4045f9d..2342e154029b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -240,7 +240,7 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
 	case reg_cmdsrc1:
 		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
 	}
-	BUG_ON(1);
+	BUG();
 }
 
 #define GPIO_BANK(x)	((x) >> 5)
-- 
2.9.0

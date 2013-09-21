From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 20 Sep 2013 22:03:10 -0300
Subject: [PATCH 1/3] clk: sunxi: factors: fix off-by-one masks
In-Reply-To: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1379725392-30202-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous code would generate one bit too long masks, and was
needlessly complicated. This patch replaces it by simpler code that can
generate the masks correctly.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-factors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 88523f9..5687ac9 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -40,7 +40,7 @@ struct clk_factors {
 
 #define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
 
-#define SETMASK(len, pos)		(((-1U) >> (31-len))  << (pos))
+#define SETMASK(len, pos)		(((1U << (len)) - 1) << (pos))
 #define CLRMASK(len, pos)		(~(SETMASK(len, pos)))
 #define FACTOR_GET(bit, len, reg)	(((reg) & SETMASK(len, bit)) >> (bit))
 
-- 
1.8.4

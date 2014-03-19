From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 19 Mar 2014 15:19:32 -0300
Subject: [PATCH 3/4] clk: sunxi: fix some calculations
In-Reply-To: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1395253173-30437-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some divisor calculations were misrounded, causing higher than requested
rates on some clocks. Fix them up using DIV_ROUND_UP, and replace one
homebrew instance of it as well with the right macro.

Reported-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index a393df1..0393f85 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -326,7 +326,7 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
 	if (parent_rate < *freq)
 		*freq = parent_rate;
 
-	parent_rate = (parent_rate + (*freq - 1)) / *freq;
+	parent_rate = DIV_ROUND_UP(parent_rate, *freq);
 
 	/* Invalid rate! */
 	if (parent_rate > 32)
@@ -371,7 +371,7 @@ static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
 	if (*freq > parent_rate)
 		*freq = parent_rate;
 
-	div = parent_rate / *freq;
+	div = DIV_ROUND_UP(parent_rate, *freq);
 
 	if (div < 16)
 		calcp = 0;
@@ -412,7 +412,7 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
 	if (*freq > parent_rate)
 		*freq = parent_rate;
 
-	div = parent_rate / *freq;
+	div = DIV_ROUND_UP(parent_rate, *freq);
 
 	if (div < 32)
 		calcp = 0;
-- 
1.9.0

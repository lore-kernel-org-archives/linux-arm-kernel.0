From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 5 Jul 2013 14:40:53 +0200
Subject: [PATCH v3 1/6] misc: sram: fix error path in sram_probe
In-Reply-To: <201307051440.19428.heiko@sntech.de>
References: <201307051440.19428.heiko@sntech.de>
Message-ID: <201307051440.53993.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pool is created thru devm_gen_pool_create, so the call to
gen_pool_destroy is not necessary.
Instead the sram-clock must be turned off again if it exists.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 drivers/misc/sram.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index d87cc91..afe66571 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -68,7 +68,8 @@ static int sram_probe(struct platform_device *pdev)
 	ret = gen_pool_add_virt(sram->pool, (unsigned long)virt_base,
 				res->start, size, -1);
 	if (ret < 0) {
-		gen_pool_destroy(sram->pool);
+		if (sram->clk)
+			clk_disable_unprepare(sram->clk);
 		return ret;
 	}
 
-- 
1.7.10.4

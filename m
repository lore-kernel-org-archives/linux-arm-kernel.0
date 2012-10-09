From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 22:13:55 +0200
Subject: [PATCH v2 5/8] clk: don't mark clkdev_add_table as init
In-Reply-To: <1349813638-4617-1-git-send-email-arnd@arndb.de>
References: <1349813638-4617-1-git-send-email-arnd@arndb.de>
Message-ID: <1349813638-4617-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2440_clk_add is a subsys_interface method and calls clkdev_add_table,
which means we might be calling it after the __init section is
discarded.

Without this patch, building mini2440_defconfig results in:

WARNING: vmlinux.o(.text+0x9848): Section mismatch in reference from the function s3c2440_clk_add() to the function .init.text:clkdev_add_table()
The function s3c2440_clk_add() references
the function __init clkdev_add_table().
This is often because s3c2440_clk_add lacks a __init
annotation or the annotation of clkdev_add_table is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/clk/clkdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..6956857 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -179,7 +179,7 @@ void clkdev_add(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_add);
 
-void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
+void clkdev_add_table(struct clk_lookup *cl, size_t num)
 {
 	mutex_lock(&clocks_mutex);
 	while (num--) {
-- 
1.7.10

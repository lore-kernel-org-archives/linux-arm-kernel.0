From: cjb@laptop.org (Chris Ball)
Date: Thu, 21 Jun 2012 03:32:04 -0400
Subject: [PATCH 02/02] clk: clk-of: Use alloc_bootmem() instead of kzalloc()
In-Reply-To: <87bokd15x7.fsf@octavius.laptop.org> (Chris Ball's message of
 "Thu, 21 Jun 2012 03:27:00 -0400")
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <87bokd15x7.fsf@octavius.laptop.org>
Message-ID: <87395p15or.fsf_-_@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When of_clk_add_provider() is used at boot time (during .init_early on
ARM, in the motivating case for this patch), kzalloc() cannot be used
because slab isn't up yet.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/clk/clk-of.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-of.c b/drivers/clk/clk-of.c
index 8b43416..adbb56b 100644
--- a/drivers/clk/clk-of.c
+++ b/drivers/clk/clk-of.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/bootmem.h>
 
 #ifdef CONFIG_OF
 
@@ -67,7 +68,7 @@ int of_clk_add_provider(struct device_node *np,
 {
 	struct of_clk_provider *cp;
 
-	cp = kzalloc(sizeof(struct of_clk_provider), GFP_KERNEL);
+	cp = alloc_bootmem(sizeof(struct of_clk_provider));
 	if (!cp)
 		return -ENOMEM;
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

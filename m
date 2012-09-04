From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 05 Sep 2012 07:41:14 +0900
Subject: [PATCH] ARM: Samsung: Remove unused code for the clocks debug-fs
 interface
In-Reply-To: <1346603823-14422-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1346603823-14422-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <227c01cd8aee$638ee0d0$2aaca270$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Commit f86c6660927614fcda257 "ARM: SAMSUNG: Add clkdev infrastructure"
> disabled population of the 'clocks' list - the clocks are now on the
> clkdev clock list. However, this effectively broke the existing clocks
> debug-fs interface on all Samsung platforms. Nobody complained about
> this missing feature for over one year, so remove the unused code.
> 
Yeah, could be. BTW, following will fix it on Samsung platforms?

From: Arve Hj<C3><B8>nnev<C3><A5>g <arve@android.com>
Subject: [PATCH] ARM: SAMSUNG: Fix clock debugfs code

Restore list add deleted by commit f86c66609276('ARM: SAMSUNG:
Add clkdev infrastructure') and fix clk_debugfs_register_one
to not crash when devname is NULL.

Signed-off-by: Arve Hj<C3><B8>nnev<C3><A5>g <arve@android.com>
Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/plat-samsung/clock.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index 65c5eca..b7338ce 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -281,6 +281,15 @@ int s3c24xx_register_clock(struct clk *clk)
 	if (clk->enable == NULL)
 		clk->enable = clk_null_enable;
 
+	/* add to the list of available clocks */
+
+	/* Quick check to see if this clock has already been registered. */
+	BUG_ON(clk->list.prev != clk->list.next);
+
+	spin_lock(&clocks_lock);
+	list_add(&clk->list, &clocks);
+	spin_unlock(&clocks_lock);
+
 	/* fill up the clk_lookup structure and register it*/
 	clk->lookup.dev_id = clk->devname;
 	clk->lookup.con_id = clk->name;
@@ -395,7 +404,11 @@ static int clk_debugfs_register_one(struct clk *c)
 	char s[255];
 	char *p = s;
 
-	p += sprintf(p, "%s", c->devname);
+	if (c->name)
+		p += sprintf(p, "%s", c->name);
+
+	if (c->devname)
+		p += sprintf(p, ":%s", c->devname);
 
 	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
 	if (!d)
-- 
1.7.1

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> This functionality will be restored when switching to the common clock
> framework.
> 
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> ---
>  arch/arm/plat-samsung/clock.c              |   92
---------------------------
> -
>  arch/arm/plat-samsung/include/plat/clock.h |    8 +--
>  2 files changed, 1 insertions(+), 99 deletions(-)
